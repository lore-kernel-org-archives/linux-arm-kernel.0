From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Mon, 15 Jun 2015 17:48:27 +0800
Subject: [RESEND PATCH v4 04/14] crypto: add a new driver for Marvell's
 CESA
In-Reply-To: <1434093366-14681-5-git-send-email-boris.brezillon@free-electrons.com>
References: <1434093366-14681-1-git-send-email-boris.brezillon@free-electrons.com>
 <1434093366-14681-5-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20150615094827.GA32073@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 12, 2015 at 09:15:56AM +0200, Boris Brezillon wrote:
>
> +static void mv_cesa_dequeue_req_unlocked(struct mv_cesa_engine *engine)
> +{
> +	struct crypto_async_request *req;
> +	struct mv_cesa_ctx *ctx;
> +
> +	spin_lock_bh(&cesa_dev->lock);
> +	req = crypto_dequeue_request(&cesa_dev->queue);

Need to call crypto_get_backlog before this so you can do the
backlog notification afterwards.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
