From: keescook@chromium.org (Kees Cook)
Date: Mon, 17 Sep 2018 22:30:36 -0700
Subject: [PATCH][RFC] crypto: skcipher: Remove VLA usage
In-Reply-To: <20180913182328.GA9812@beast>
References: <20180913182328.GA9812@beast>
Message-ID: <CAGXu5jJdqs4Rf=RvRtzQavT0oAtEEWppmjJRFRhLL4iQfCkVnQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 13, 2018 at 11:23 AM, Kees Cook <keescook@chromium.org> wrote:
> RFC follow-up to https://lkml.kernel.org/r/CAGXu5j+bpLK=EQ9LHkO8V=sdaQwt==6fbGhgn2Vi1E9_WxSGRQ at mail.gmail.com
>
> The core API changes:
>
>         struct crypto_sync_skcipher
>         crypto_alloc_sync_skcipher()
>         crypto_free_sync_skcipher()
>         crypto_sync_skcipher_setkey()
>         skcipher_request_set_sync_tfm()
>         SKCIPHER_REQUEST_ON_STACK type check
>
> and a single user's refactoring as an example:
>
>         drivers/crypto/ccp/ccp-crypto.h
>         drivers/crypto/ccp/ccp-crypto-aes-xts.c
>
> Does this look correct? If so, I can continue and do the other 60
> instances of SKCIPHER_REQUEST_ON_STACK().

Herbert, how does this look? Should I do the other 60 instances? I'd
really like to get this finished up. :)

Thanks!

-Kees

-- 
Kees Cook
Pixel Security
