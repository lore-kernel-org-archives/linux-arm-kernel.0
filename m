From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Tue, 4 Sep 2018 13:20:17 +0800
Subject: [PATCH v2] crypto: arm/ghash-ce - implement support for 4-way
 aggregation
In-Reply-To: <20180823144851.14601-1-ard.biesheuvel@linaro.org>
References: <20180823144851.14601-1-ard.biesheuvel@linaro.org>
Message-ID: <20180904052017.b33xkndrmr57urw7@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 23, 2018 at 03:48:51PM +0100, Ard Biesheuvel wrote:
> Speed up the GHASH algorithm based on 64-bit polynomial multiplication
> by adding support for 4-way aggregation. This improves throughput by
> ~85% on Cortex-A53, from 1.7 cycles per byte to 0.9 cycles per byte.
> 
> When combined with AES into GCM, throughput improves by ~25%, from
> 3.8 cycles per byte to 3.0 cycles per byte.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> v2: modulo schedule the loads of the input
>     add AES/GCM performance numbers to commit log
> 
>  arch/arm/crypto/Kconfig         |   1 +
>  arch/arm/crypto/ghash-ce-core.S | 108 +++++++++++++++++++-
>  arch/arm/crypto/ghash-ce-glue.c |  38 +++++--
>  3 files changed, 131 insertions(+), 16 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
