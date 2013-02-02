From: mporter@ti.com (Matt Porter)
Date: Sat, 2 Feb 2013 09:44:10 -0500
Subject: [PATCH v7 01/10] ARM: davinci: move private EDMA API to arm/common
In-Reply-To: <20130202124906.GB2637@n2100.arm.linux.org.uk>
References: <1359742975-10421-1-git-send-email-mporter@ti.com>
 <1359742975-10421-2-git-send-email-mporter@ti.com>
 <20130201184107.GM22517@atomide.com>
 <20130202124906.GB2637@n2100.arm.linux.org.uk>
Message-ID: <20130202144409.GR2244@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 02, 2013 at 12:49:06PM +0000, Russell King wrote:
> On Fri, Feb 01, 2013 at 10:41:08AM -0800, Tony Lindgren wrote:
> > * Matt Porter <mporter@ti.com> [130201 10:25]:
> > > Move mach-davinci/dma.c to common/edma.c so it can be used
> > > by OMAP (specifically AM33xx) as well.
> > 
> > I think this should rather go to drivers/dma/?
> 
> Yes, it should, but just like OMAP, there's a conversion effort that needs
> to be gone through.  It has one point - and only one point - which allows
> its continued existence under arch/arm, and that is it already exists
> there.
> 
> If it was new code, the answer would be a definite NACK, but it isn't.
> It's pre-existing code which is already in mainline.  It's merely being
> moved.
> 
> Another plus point for it is that there does seem to be a DMA engine
> driver for it, so hopefully we'll see it killed off in arch/arm soon.

That's definitely the plan. I was able to start this effort
independently by converting the Davinci mmc and spi drivers to dmaengine
before I took this step. I've got the next micro-step of addressing
omap_hsmmc in process (pending on agreement on a dmaengine api change
with Vinod), cleaning up the mcasp driver is also pending this series so
that it can also be converted to dmaengine. Once mcasp (or "davinci
audio") is converted, we're rid of all the in-kernel users of the
private API and can get rid of this...which also is helping clean up
mach-davinci, of course.

If I can get your ack on this patch that should move things along to
these next steps.

Thanks,
Matt
