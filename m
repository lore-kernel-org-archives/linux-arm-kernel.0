From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Thu, 2 Feb 2017 22:05:10 +0800
Subject: [PATCH v3 2/3] crypto: brcm: Add Broadcom SPU driver
In-Reply-To: <1485362689-11294-3-git-send-email-rob.rice@broadcom.com>
References: <1485362689-11294-1-git-send-email-rob.rice@broadcom.com>
 <1485362689-11294-3-git-send-email-rob.rice@broadcom.com>
Message-ID: <20170202140510.GB5289@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 25, 2017 at 11:44:48AM -0500, Rob Rice wrote:
>
> +static int ahash_export(struct ahash_request *req, void *out)
> +{
> +	const struct iproc_reqctx_s *rctx = ahash_request_ctx(req);
> +
> +	memcpy(out, rctx, offsetof(struct iproc_reqctx_s, msg_buf));
> +	return 0;
> +}

The reqctx data structure seems to contain a lot of info unrelated
to the hash state.  Can't we get away with just copying the hash
state (incr_hash) itself?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
