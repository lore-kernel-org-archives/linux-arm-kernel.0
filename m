From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Tue, 7 Aug 2018 17:53:41 +0800
Subject: [PATCH 0/2] crypto: arm64/ghash-ce - performance improvements
In-Reply-To: <20180804184625.28523-1-ard.biesheuvel@linaro.org>
References: <20180804184625.28523-1-ard.biesheuvel@linaro.org>
Message-ID: <20180807095341.osf4ugfhl5kzhenc@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 04, 2018 at 08:46:23PM +0200, Ard Biesheuvel wrote:
> Another bit of performance work on the GHASH driver: this time it is not
> the combined AES/GCM algorithm but the bare GHASH driver that gets updated.
> 
> Even though ARM cores that implement the polynomical multiplication
> instructions that these routines depend on are guaranteed to also support
> the AES instructions, and can thus use the AES/GCM driver, there could
> be reasons to use the accelerated GHASH in isolation, e.g., with another
> symmetric blockcipher, with a faster h/w accelerator, or potentially with
> an accelerator that does not expose the AES key to the OS.
> 
> The resulting code runs at 1.1 cycles per byte on Cortex-A53 (down from
> 2.4 cycles per byte)
> 
> Ard Biesheuvel (2):
>   crypto: arm64/ghash-ce - replace NEON yield check with block limit
>   crypto: arm64/ghash-ce - implement 4-way aggregation
> 
>  arch/arm64/crypto/ghash-ce-core.S | 153 ++++++++++++++------
>  arch/arm64/crypto/ghash-ce-glue.c |  87 ++++++-----
>  2 files changed, 161 insertions(+), 79 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
