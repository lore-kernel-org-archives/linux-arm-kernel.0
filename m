From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Mon, 8 Oct 2018 13:53:13 +0800
Subject: [PATCH] crypto: arm64/aes - fix handling sub-block CTS-CBC inputs
In-Reply-To: <20181003052215.22468-1-ebiggers@kernel.org>
References: <20181003052215.22468-1-ebiggers@kernel.org>
Message-ID: <20181008055313.escoye4faoo2qbh5@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 02, 2018 at 10:22:15PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> In the new arm64 CTS-CBC implementation, return an error code rather
> than crashing on inputs shorter than AES_BLOCK_SIZE bytes.  Also set
> cra_blocksize to AES_BLOCK_SIZE (like is done in the cts template) to
> indicate the minimum input size.
> 
> Fixes: dd597fb33ff0 ("crypto: arm64/aes-blk - add support for CTS-CBC mode")
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
