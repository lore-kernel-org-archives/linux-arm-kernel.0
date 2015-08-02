From: peterz@infradead.org (Peter Zijlstra)
Date: Sun, 2 Aug 2015 11:40:28 +0200
Subject: [PATCH 1/3] clocksource: atmel-st: Remove irq handler when clock
 event is unused
In-Reply-To: <alpine.DEB.2.11.1508021100390.3825@nanos>
References: <1437161608-26782-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1437161608-26782-2-git-send-email-alexandre.belloni@free-electrons.com>
 <alpine.DEB.2.11.1507180942360.18576@nanos>
 <20150718222308.GA30489@piout.net>
 <alpine.DEB.2.11.1507201103550.18576@nanos>
 <20150720193726.GJ15539@piout.net>
 <alpine.DEB.2.11.1507202245310.18576@nanos>
 <alpine.DEB.2.11.1508021100390.3825@nanos>
Message-ID: <20150802094028.GN12596@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 02, 2015 at 11:10:21AM +0200, Thomas Gleixner wrote:
> I think Boris Brezillon had implemented it at some point, but it was
> shot down for reasons I can't remember. 

You weren't around at the time.. DT people didn't like it, said they
didn't like having to make up fake hardware in their DT crap.

> That would allow us to simply
> have disable_irq_nosync/enable_irq in the relevant code pathes and be
> done with it. I guess I need to find the references and give it a try
> again if nobody beats me to it.

lkml.kernel.org/r/1422527620-8308-3-git-send-email-boris.brezillon at free-electrons.com
