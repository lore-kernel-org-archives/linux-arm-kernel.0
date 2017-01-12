From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Fri, 13 Jan 2017 00:45:04 +0800
Subject: [PATCH v2 0/7] crypto: ARM/arm64 - AES and ChaCha20 updates for
 v4.11
In-Reply-To: <1484152915-26517-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1484152915-26517-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20170112164504.GD20313@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 11, 2017 at 04:41:48PM +0000, Ard Biesheuvel wrote:
> This adds ARM and arm64 implementations of ChaCha20, scalar AES and SIMD
> AES (using bit slicing). The SIMD algorithms in this series take advantage
> of the new skcipher walksize attribute to iterate over the input in the most
> efficient manner possible.
> 
> Patch #1 adds a NEON implementation of ChaCha20 for ARM.
> 
> Patch #2 adds a NEON implementation of ChaCha20 for arm64.
> 
> Patch #3 modifies the existing NEON and ARMv8 Crypto Extensions implementations
> of AES-CTR to be available as a synchronous skcipher as well. This is intended
> for the mac80211 code, which uses synchronous encapsulations of ctr(aes)
> [ccm, gcm] in softirq context, during which arm64 supports use of SIMD code.
> 
> Patch #4 adds a scalar implementation of AES for arm64, using the key schedule
> generation routines and lookup tables of the generic code in crypto/aes_generic.
> 
> Patch #5 does the same for ARM, replacing existing scalar code that originated
> in the OpenSSL project, and contains redundant key schedule generation routines
> and lookup tables (and is slightly slower on modern cores)
> 
> Patch #6 replaces the ARM bit sliced NEON code with a new implementation that
> has a number of advantages over the original code (which also originated in the
> OpenSSL project.) The performance should be identical.
> 
> Patch #7 adds a port of the ARM bit-sliced AES code to arm64, in ECB, CBC, CTR
> and XTS modes.
> 
> Due to the size of patch #7, it may be difficult to apply these patches from
> patchwork, so I pushed them here as well:

It seems to have made it.

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
