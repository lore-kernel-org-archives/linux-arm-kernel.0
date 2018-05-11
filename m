From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Sat, 12 May 2018 00:18:34 +0800
Subject: [PATCH resend 00/10] crypto: arm64 - play nice with CONFIG_PREEMPT
In-Reply-To: <20180430161830.14892-1-ard.biesheuvel@linaro.org>
References: <20180430161830.14892-1-ard.biesheuvel@linaro.org>
Message-ID: <20180511161833.57h7lwc4krl5cwuo@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 30, 2018 at 06:18:20PM +0200, Ard Biesheuvel wrote:
> Hello Herbert,
> 
> These are the patches that depend on the arm64/assembler.h patches that
> inadvertently got pulled into the cryptodev tree and reverted shortly
> after. Those have now been merged into Linus's tree, and so the
> remaining changes can be applied as well. Please apply.
> 
> Ard Biesheuvel (10):
>   crypto: arm64/sha1-ce - yield NEON after every block of input
>   crypto: arm64/sha2-ce - yield NEON after every block of input
>   crypto: arm64/aes-ccm - yield NEON after every block of input
>   crypto: arm64/aes-blk - yield NEON after every block of input
>   crypto: arm64/aes-bs - yield NEON after every block of input
>   crypto: arm64/aes-ghash - yield NEON after every block of input
>   crypto: arm64/crc32-ce - yield NEON after every block of input
>   crypto: arm64/crct10dif-ce - yield NEON after every block of input
>   crypto: arm64/sha3-ce - yield NEON after every block of input
>   crypto: arm64/sha512-ce - yield NEON after every block of input
> 
>  arch/arm64/crypto/aes-ce-ccm-core.S   | 150 +++++----
>  arch/arm64/crypto/aes-ce.S            |  15 +-
>  arch/arm64/crypto/aes-modes.S         | 331 ++++++++++++--------
>  arch/arm64/crypto/aes-neonbs-core.S   | 305 ++++++++++--------
>  arch/arm64/crypto/crc32-ce-core.S     |  40 ++-
>  arch/arm64/crypto/crct10dif-ce-core.S |  32 +-
>  arch/arm64/crypto/ghash-ce-core.S     | 113 +++++--
>  arch/arm64/crypto/ghash-ce-glue.c     |  28 +-
>  arch/arm64/crypto/sha1-ce-core.S      |  42 ++-
>  arch/arm64/crypto/sha2-ce-core.S      |  37 ++-
>  arch/arm64/crypto/sha3-ce-core.S      |  77 +++--
>  arch/arm64/crypto/sha512-ce-core.S    |  27 +-
>  12 files changed, 762 insertions(+), 435 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
