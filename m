From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 19 Sep 2016 09:44:45 +0200
Subject: [PATCH v5 3/5] arm64: arch_timer: Work around QorIQ Erratum
 A-008585
In-Reply-To: <1474259324.15220.5.camel@buserror.net>
References: <1473469413-11019-1-git-send-email-oss@buserror.net>
 <20160912123027.GA13741@leverpostej> <1474259324.15220.5.camel@buserror.net>
Message-ID: <2134283.D1RaSsN7zL@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, September 18, 2016 11:28:44 PM CEST Scott Wood wrote:
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
> did.  There doesn't appear to be a separate arm-soc mailing list, nor is there
> a request to CC Olof/Arnd.  I did CC Shawn Guo who has been handling the
> device tree patches for these chips.

That is the right way to do it. If the DT change is a bugfix that should
get merged along with the rest, Shawn can also provide an Ack to have it
merged through the arm64 tree, ideally warning us if there might be any
conflicts with stuff that gets sent for arm-soc.

	Arnd
