From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Fri, 15 May 2015 14:52:22 +0800
Subject: [PATCH v9 4/4] crypto: Add Allwinner Security System crypto
 accelerator
In-Reply-To: <1431608341-10936-5-git-send-email-clabbe.montjoie@gmail.com>
References: <1431608341-10936-1-git-send-email-clabbe.montjoie@gmail.com>
 <1431608341-10936-5-git-send-email-clabbe.montjoie@gmail.com>
Message-ID: <20150515065222.GA16808@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 14, 2015 at 02:59:01PM +0200, LABBE Corentin wrote:
>
> +int sun4i_hash_export(struct ahash_request *areq, void *out)
> +{
> +	struct sun4i_req_ctx *op = ahash_request_ctx(areq);
> +
> +	memcpy(out, op, sizeof(struct sun4i_req_ctx));
> +	return 0;
> +}
> +
> +int sun4i_hash_import(struct ahash_request *areq, const void *in)
> +{
> +	struct sun4i_req_ctx *op = ahash_request_ctx(areq);
> +
> +	memcpy(op, in, sizeof(struct sun4i_req_ctx));

This is very wrong.  You're importing an arbitrary ss pointer.  The
whole point of having an import function instead of just a simple
memcpy is to deal with such problems.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
