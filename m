From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Fri, 21 Sep 2018 13:44:09 +0800
Subject: [PATCH 0/4] crypto: arm64/aes-blk - cleanups and optimizations
 for XTS/CTS-CBC
In-Reply-To: <20180910144115.25727-1-ard.biesheuvel@linaro.org>
References: <20180910144115.25727-1-ard.biesheuvel@linaro.org>
Message-ID: <20180921054409.pbf7bjyw27j4rj7h@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 10, 2018 at 04:41:11PM +0200, Ard Biesheuvel wrote:
> Some cleanups and optimizations for the arm64  AES skcipher routines.
> 
> Patch #1 fixes the peculiar use of u8 arrays to refer to AES round keys,
> which are natively arrays of u32.
> 
> Patch #2 partially reverts the use of NEON yield calls, which is not
> needed for skciphers.
> 
> Patch #3 adds support for cts(cbc(aes)) in the NEON chaining mode handling.
> 
> Patch #4 tweaks the XTS handling to remove a literal load from the inner
> loop.
> 
> Cc: Eric Biggers <ebiggers@google.com>
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Steve Capper <steve.capper@arm.com>
> 
> Ard Biesheuvel (4):
>   crypto: arm64/aes-blk - remove pointless (u8 *) casts
>   crypto: arm64/aes-blk - revert NEON yield for skciphers
>   crypto: arm64/aes-blk - add support for CTS-CBC mode
>   crypto: aes/arm64-blk - improve XTS mask handling
> 
>  arch/arm64/crypto/aes-ce.S    |   5 +
>  arch/arm64/crypto/aes-glue.c  | 212 +++++++++--
>  arch/arm64/crypto/aes-modes.S | 400 ++++++++++----------
>  arch/arm64/crypto/aes-neon.S  |   6 +
>  4 files changed, 406 insertions(+), 217 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
