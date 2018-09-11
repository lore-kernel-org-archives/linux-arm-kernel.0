From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Tue, 11 Sep 2018 13:53:34 +0800
Subject: [PATCH v2 2/4] crypto: skcipher - Enforce non-ASYNC for on-stack
 requests
In-Reply-To: <CAGXu5jLx8bdr+Ld7QE1LxttPB-LOs-H96kyx0O0MXq9MzX2vNw@mail.gmail.com>
References: <20180906225854.40989-1-keescook@chromium.org>
 <20180906225854.40989-3-keescook@chromium.org>
 <20180907034242.zhm4dglzkldhvh3x@gondor.apana.org.au>
 <CAGXu5jLx8bdr+Ld7QE1LxttPB-LOs-H96kyx0O0MXq9MzX2vNw@mail.gmail.com>
Message-ID: <20180911055334.py26ff7rib3sla2c@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 07, 2018 at 09:02:45AM -0700, Kees Cook wrote:
>
> I'll continue to investigate alternatives, but I wanted to point out
> that the struct change actually fills an existing padding byte (so no
> change in memory usage) and marking this as an unlikely() test means
> it wouldn't even be measurable due to the branch predictor (so no
> change in speed). encrypt/decrypt entry is a tiny tiny fraction of the
> actual work done during encryption/decryption, etc.

The point is the ON_STACK request stuff is purely for backwards
compatibility and we don't want it to proliferate and pollute the
core API.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
