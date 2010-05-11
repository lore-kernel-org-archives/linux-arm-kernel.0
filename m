From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Tue, 11 May 2010 20:47:58 +1000
Subject: Rampant ext3/4 corruption on 2.6.34-rc7 with VIVT ARM (Marvell
	88f5182)
In-Reply-To: <20100511101620.GA18654@shareable.org>
References: <1273569821.21352.19.camel@pasglop>
	<20100511101620.GA18654@shareable.org>
Message-ID: <1273574878.21352.25.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-05-11 at 11:16 +0100, Jamie Lokier wrote:
> 
> I've seen similar ext3 corruption errors with an IDE on a Sigma
> Designs EM8620 with ARM core.  It's completely unrelated :-) But the
> fault was in the IDE driver doing cache flushes too late after
> starting to set up DMA.  To diagnose it, we luckily found a
> reproducible test case, then sprinkled full cache flushes at various
> places to narrow it down, and eventually found that one full cache
> flush in the driver itself sorted it out, which told us where the
> fault was.  From there it was easy. 

Ok, well, that's -a- possibility... we'll see. I'm doing some more tests
to try to characterize the problem a bit better, then we can play with
the driver. I think it's also worth trying with earlier kernels in case
it's some kind of regression, though that means I'll have to backport my
board support for that little box :-)

Cheers,
Ben.
