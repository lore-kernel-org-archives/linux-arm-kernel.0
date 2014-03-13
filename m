From: marex@denx.de (Marek Vasut)
Date: Thu, 13 Mar 2014 02:21:47 +0100
Subject: [PATCH 3/3 V2] crypto: Simplify the ahash_finup implementation
In-Reply-To: <20140312121101.GB25881@gondor.apana.org.au>
References: <1389720829-5963-1-git-send-email-marex@denx.de>
 <1393806108-6374-3-git-send-email-marex@denx.de>
 <20140312121101.GB25881@gondor.apana.org.au>
Message-ID: <201403130221.47172.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, March 12, 2014 at 01:11:01 PM, Herbert Xu wrote:
> On Mon, Mar 03, 2014 at 01:21:48AM +0100, Marek Vasut wrote:
> > -static void ahash_def_finup_done2(struct crypto_async_request *req, int
> > err) +static void ahash_def_finup_done2(struct crypto_async_request
> > *areq, int err)
> 
> Please keep the existing name to be consistent with the rest
> of the crypto API code.  You should also use the same name in
> your second patch for consistency.

Done.

Moreover, the original code this patch changes still has a bug I think. The 
invocation of areq->base.complete() is wrong in the original code here. I will 
post V3 of the patches where I explain the problem in detail.

Best regards,
Marek Vasut
