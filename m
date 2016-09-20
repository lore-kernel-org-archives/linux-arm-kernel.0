From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 20 Sep 2016 20:52:05 +0800
Subject: [PATCH v5 3/5] arm64: arch_timer: Work around QorIQ Erratum
 A-008585
In-Reply-To: <1474259324.15220.5.camel@buserror.net>
References: <1473469413-11019-1-git-send-email-oss@buserror.net>
 <1473469413-11019-3-git-send-email-oss@buserror.net>
 <20160912113615.GA20804@leverpostej>
 <20160912114406.GG23211@arm.com>
 <20160912123027.GA13741@leverpostej>
 <1474259324.15220.5.camel@buserror.net>
Message-ID: <20160920125205.GB3744@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 18, 2016 at 11:28:44PM -0500, Scott Wood wrote:
> On Mon, 2016-09-12 at 13:30 +0100, Mark Rutland wrote:
> > On Mon, Sep 12, 2016 at 12:44:07PM +0100, Will Deacon wrote:
> > > 
> > > On Mon, Sep 12, 2016 at 12:36:15PM +0100, Mark Rutland wrote:
> > > > 
> > > > The changes in arm64's <asm/arch_timer.h> are going to conflict with
> > > > some cleanup [1,2] that just landed in the arm64 for-next/core branch.
> > > > 
> > > > Could you please rebase atop of that?
> > > Well, we should figure out what tree this is going through first. There
> > > are a mixture of arm, arm64, driver and dts changes here and not all
> > > of it is carrying the appropriate acks for me to queue it.
> > Given that mix, I had assumed that this would all go through the arm64
> > tree -- I see that Rob has already acked the binding, and I'm happy to
> > give my ack for the driver once that's in shape.
> > 
> > The dts change could go through arm-soc in parallel, I guess. It doesn't
> > look like arm-soc have been Cc'd for that, though.
> 
> The arm-soc section of MAINTAINERS says to e-mail linux-arm-kernel, which I
> did. ?There doesn't appear to be a separate arm-soc mailing list, nor is there
> a request to CC Olof/Arnd. ?I did CC Shawn Guo who has been handling the
> device tree patches for these chips.

This is kind of new feature development, and there is no hard dependency
between driver and DTS changes.  In this case, we normally pick up the
DTS patch only after driver part get accepted.

Shawn
