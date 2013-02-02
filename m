From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 2 Feb 2013 12:49:06 +0000
Subject: [PATCH v7 01/10] ARM: davinci: move private EDMA API to arm/common
In-Reply-To: <20130201184107.GM22517@atomide.com>
References: <1359742975-10421-1-git-send-email-mporter@ti.com>
 <1359742975-10421-2-git-send-email-mporter@ti.com>
 <20130201184107.GM22517@atomide.com>
Message-ID: <20130202124906.GB2637@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 01, 2013 at 10:41:08AM -0800, Tony Lindgren wrote:
> * Matt Porter <mporter@ti.com> [130201 10:25]:
> > Move mach-davinci/dma.c to common/edma.c so it can be used
> > by OMAP (specifically AM33xx) as well.
> 
> I think this should rather go to drivers/dma/?

Yes, it should, but just like OMAP, there's a conversion effort that needs
to be gone through.  It has one point - and only one point - which allows
its continued existence under arch/arm, and that is it already exists
there.

If it was new code, the answer would be a definite NACK, but it isn't.
It's pre-existing code which is already in mainline.  It's merely being
moved.

Another plus point for it is that there does seem to be a DMA engine
driver for it, so hopefully we'll see it killed off in arch/arm soon.
