From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Sat, 11 Feb 2017 18:51:02 +0800
Subject: [PATCH] crypto: arm64/crc32 - merge CRC32 and PMULL instruction
 based drivers
In-Reply-To: <1485963340-25297-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1485963340-25297-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20170211105102.GB855@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 01, 2017 at 03:35:40PM +0000, Ard Biesheuvel wrote:
> The PMULL based CRC32 implementation already contains code based on the
> separate, optional CRC32 instructions to fallback to when operating on
> small quantities of data. We can expose these routines directly on systems
> that lack the 64x64 PMULL instructions but do implement the CRC32 ones,
> which makes the driver that is based solely on those CRC32 instructions
> redundant. So remove it.
> 
> Note that this aligns arm64 with ARM, whose accelerated CRC32 driver
> also combines the CRC32 extension based and the PMULL based versions.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
