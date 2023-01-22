CREATE EXTENSION IF NOT EXISTS pgcrypto;

SET check_function_bodies = false;

CREATE TABLE public.account (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    type text NOT NULL,
    provider text NOT NULL,
    provider_account_id text NOT NULL,
    refresh_token text,
    access_token text,
    expires_at bigint,
    token_type text,
    scope text,
    id_token text,
    session_state text,
    oauth_token_secret text,
    oauth_token text,
    user_id uuid NOT NULL,
    refresh_token_expires_in bigint
);

CREATE TABLE public.session (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    session_token text NOT NULL,
    user_id uuid NOT NULL,
    expires timestamptz
);

CREATE TABLE public.user (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    name text,
    email text,
    email_verified_at timestamptz,
    image text
);

CREATE TABLE public.verification_token (
    token text NOT NULL,
    identifier text NOT NULL,
    expires timestamptz
);

ALTER TABLE ONLY public.account
    ADD CONSTRAINT account_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.session
    ADD CONSTRAINT session_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.user
    ADD CONSTRAINT user_email_key UNIQUE (email);

ALTER TABLE ONLY public.user
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.verification_token
    ADD CONSTRAINT verification_token_pkey PRIMARY KEY (token);

ALTER TABLE ONLY public.account
    ADD CONSTRAINT "account_userId_fkey" FOREIGN KEY ("user_id") REFERENCES public.user(id) ON UPDATE RESTRICT ON DELETE CASCADE;

ALTER TABLE ONLY public.session
    ADD CONSTRAINT "session_userId_fkey" FOREIGN KEY ("user_id") REFERENCES public.user(id) ON UPDATE RESTRICT ON DELETE CASCADE;
