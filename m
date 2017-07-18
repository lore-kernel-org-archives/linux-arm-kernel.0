From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Tue, 18 Jul 2017 17:49:46 +0800
Subject: [PATCH v2 2/2] crypto: arm64/ghash - add NEON accelerated
 fallback for 64-bit PMULL
In-Reply-To: <20170704234319.8398-2-ard.biesheuvel@linaro.org>
References: <20170704234319.8398-1-ard.biesheuvel@linaro.org>
 <20170704234319.8398-2-ard.biesheuvel@linaro.org>
Message-ID: <20170718094946.GA6347@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 05, 2017 at 12:43:19AM +0100, Ard Biesheuvel wrote:
> Implement a NEON fallback for systems that do support NEON but have
> no support for the optional 64x64->128 polynomial multiplication
> instruction that is part of the ARMv8 Crypto Extensions. It is based
> on the paper "Fast Software Polynomial Multiplication on ARM Processors
> Using the NEON Engine" by Danilo Camara, Conrado Gouvea, Julio Lopez and
> Ricardo Dahab (https://hal.inria.fr/hal-01506572), but has been reworked
> extensively for the AArch64 ISA.
> 
> On a low-end core such as the Cortex-A53 found in the Raspberry Pi3, the
> NEON based implementation is 4x faster than the table based one, and
> is time invariant as well, making it less vulnerable to timing attacks.
> When combined with the bit-sliced NEON implementation of AES-CTR, the
> AES-GCM performance increases by ~2x (from 58 to 30 cycles per byte).
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

This patch does not apply against cryptodev.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
