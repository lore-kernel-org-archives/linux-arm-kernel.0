From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Mon, 15 Jun 2015 20:40:00 +0800
Subject: [RESEND PATCH v4 04/14] crypto: add a new driver for Marvell's
 CESA
In-Reply-To: <20150615133853.57687ecf@bbrezillon>
References: <1434093366-14681-1-git-send-email-boris.brezillon@free-electrons.com>
 <1434093366-14681-5-git-send-email-boris.brezillon@free-electrons.com>
 <20150615094827.GA32073@gondor.apana.org.au>
 <20150615133853.57687ecf@bbrezillon>
Message-ID: <20150615124000.GB1646@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 15, 2015 at 01:38:53PM +0200, Boris Brezillon wrote:
> Oh right.
> I still have trouble understanding the need for the backlog concept
> (maybe you can give some insight): the backlog is just another list
> where we put all the requests when the queue has exceeded the limit
> fixed in crypto_queue_init, but the result is pretty much the same, the
> request stored in the backlog will be handled at some point, so what's
> the real point of this backlog.

The point is to tell the user to stop sending requests by returning
EBUSY.  When the queue clears up again we then invoke the callback
and tell the user that they can send requests again.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
