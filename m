From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Mon, 23 Jan 2017 22:58:37 +0800
Subject: [PATCH] crypto: arm64/aes-blk - honour iv_out requirement in CBC
 and CTR modes
In-Reply-To: <1484660789-7036-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1484660789-7036-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20170123145837.GC20806@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 17, 2017 at 01:46:29PM +0000, Ard Biesheuvel wrote:
> Update the ARMv8 Crypto Extensions and the plain NEON AES implementations
> in CBC and CTR modes to return the next IV back to the skcipher API client.
> This is necessary for chaining to work correctly.
> 
> Note that for CTR, this is only done if the request is a round multiple of
> the block size, since otherwise, chaining is impossible anyway.
> 
> Cc: <stable@vger.kernel.org> # v3.16+
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
