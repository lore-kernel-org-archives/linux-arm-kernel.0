From: jamie@shareable.org (Jamie Lokier)
Date: Tue, 11 May 2010 11:16:20 +0100
Subject: Rampant ext3/4 corruption on 2.6.34-rc7 with VIVT ARM (Marvell
	88f5182)
In-Reply-To: <1273569821.21352.19.camel@pasglop>
References: <1273569821.21352.19.camel@pasglop>
Message-ID: <20100511101620.GA18654@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Benjamin Herrenschmidt wrote:
> On the other hand, it could also be a busticated marvell SATA driver :-)

I've seen similar ext3 corruption errors with an IDE on a Sigma
Designs EM8620 with ARM core.  It's completely unrelated :-) But the
fault was in the IDE driver doing cache flushes too late after
starting to set up DMA.  To diagnose it, we luckily found a
reproducible test case, then sprinkled full cache flushes at various
places to narrow it down, and eventually found that one full cache
flush in the driver itself sorted it out, which told us where the
fault was.  From there it was easy.

-- Jamie
