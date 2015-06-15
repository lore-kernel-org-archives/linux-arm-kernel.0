From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Mon, 15 Jun 2015 17:59:44 +0800
Subject: [RESEND PATCH v4 04/14] crypto: add a new driver for Marvell's
 CESA
In-Reply-To: <1434093366-14681-5-git-send-email-boris.brezillon@free-electrons.com>
References: <1434093366-14681-1-git-send-email-boris.brezillon@free-electrons.com>
 <1434093366-14681-5-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20150615095944.GA32199@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 12, 2015 at 09:15:56AM +0200, Boris Brezillon wrote:
> +struct ahash_alg mv_ahmac_sha1_alg = {
> +	.init = mv_cesa_ahmac_sha1_init,
> +	.update = mv_cesa_ahash_update,
> +	.final = mv_cesa_ahash_final,
> +	.finup = mv_cesa_ahash_finup,
> +	.digest = mv_cesa_ahmac_sha1_digest,
> +	.setkey = mv_cesa_ahmac_sha1_setkey,

Please add import/export functions for hmac too.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
