From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 19 Sep 2016 17:55:31 +0100
Subject: [PATCH v5 3/5] arm64: arch_timer: Work around QorIQ Erratum
 A-008585
In-Reply-To: <1474259505.15220.8.camel@buserror.net>
References: <1473469413-11019-1-git-send-email-oss@buserror.net>
 <1473469413-11019-3-git-send-email-oss@buserror.net>
 <20160912113615.GA20804@leverpostej>
 <20160912114406.GG23211@arm.com>
 <20160912123027.GA13741@leverpostej>
 <20160912125948.GB13899@leverpostej> <57D6A88D.7000002@arm.com>
 <1474259505.15220.8.camel@buserror.net>
Message-ID: <20160919165531.GB30584@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 18, 2016 at 11:31:45PM -0500, Scott Wood wrote:
> On Mon, 2016-09-12 at 14:07 +0100, Marc Zyngier wrote:
> > On 12/09/16 13:59, Mark Rutland wrote:
> > > 
> > > On Mon, Sep 12, 2016 at 01:30:28PM +0100, Mark Rutland wrote:
> > > > 
> > > > On Mon, Sep 12, 2016 at 12:44:07PM +0100, Will Deacon wrote:
> > > > > 
> > > > > On Mon, Sep 12, 2016 at 12:36:15PM +0100, Mark Rutland wrote:
> > > > > > 
> > > > > > The changes in arm64's <asm/arch_timer.h> are going to conflict with
> > > > > > some cleanup [1,2] that just landed in the arm64 for-next/core
> > > > > > branch.
> > > > > > 
> > > > > > Could you please rebase atop of that?
> > > > > Well, we should figure out what tree this is going through first.
> > > > > There
> > > > > are a mixture of arm, arm64, driver and dts changes here and not all
> > > > > of it is carrying the appropriate acks for me to queue it.
> > > > Given that mix, I had assumed that this would all go through the arm64
> > > > tree -- I see that Rob has already acked the binding, and I'm happy to
> > > > give my ack for the driver once that's in shape.
> > > Now I see that I'd missed the arch/arm changes in patch 4, which lack a
> > > relevant ack.
> > > 
> > > Given that, I don't know what to suggest.
> > I wouldn't mind delaying patch 4 until it gets acked by RMK, as it
> > doesn't impact the functionality.
> 
> Mark asked me to move that patch before the workaround patch, to avoid ever
> having to add more code that messes with the name. ?Should I keep the order as
> is then?

Yes; at this stage I think we have to.

Thanks,
Mark.
