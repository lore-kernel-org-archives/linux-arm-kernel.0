From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Wed, 29 Apr 2015 17:49:02 +0800
Subject: [PATCH 0/2] crypto: add new driver for Marvell CESA
In-Reply-To: <20150428215232.6834906c@bbrezillon>
References: <1428591523-1780-1-git-send-email-boris.brezillon@free-electrons.com>
 <20150428215232.6834906c@bbrezillon>
Message-ID: <20150429094902.GC9874@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 28, 2015 at 09:52:32PM +0200, Boris Brezillon wrote:
> 
> In particular, I'd like to discuss the threaded-irq approach taken in
> this driver (other drivers are using tasklets).
> The main reason behind this choice is the fact that crypto engines
> are quite fast, and I'm worried about the CPU contention that might
> happen in case of fully loaded crypto engines (the CPU might spend most
> of its time in interrupt context until the crypto queue is emptied).
> Using threaded-irq allows preemption of the crypto completion
> operation, thus authorizing another thread (with higher priority) to be
> scheduled. ITOH, the tasklet approach provide slightly performances (I
> don't recall the exact numbers, but Arnaud did some tests).

Either approach is fine with me.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
