From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 20 Feb 2015 16:12:59 +0000
Subject: [PATCH] genirq: fix virtual irq demuxer related comments
In-Reply-To: <20150210161425.GZ21418@twins.programming.kicks-ass.net>
References: <20150210150013.GD7119@twins.programming.kicks-ass.net>
 <1423582992-8154-1-git-send-email-boris.brezillon@free-electrons.com>
 <20150210161425.GZ21418@twins.programming.kicks-ass.net>
Message-ID: <20150220161259.GL13659@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On Tue, Feb 10, 2015 at 04:14:25PM +0000, Peter Zijlstra wrote:
> On Tue, Feb 10, 2015 at 04:43:12PM +0100, Boris Brezillon wrote:
> > Replace remaining 'Dumb' occurrences by 'Virtual'.
> > Remove inappropriate notes in kerneldoc headers.
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> 
> Thanks, squished into the other one.

Would you be able to drop the virtual demuxer patch(es) for now?

The fundamental problem here is that a physical IRQ is shared by wakeup
and IRQF_NO_SUSPEND handlers. Neither the virtual demuxer nor the flag
approach solve that problem.

Boris and I have spoken on IRC and have some ideas as to what we could
do, but no code just yet.

Thanks,
Mark.
