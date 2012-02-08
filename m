From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 8 Feb 2012 08:46:49 +0000
Subject: [PATCH v2 1/2] DMA: PL330: Merge PL330 driver into drivers/dma/
In-Reply-To: <003101cce5fe$734b9990$59e2ccb0$%kim@samsung.com>
References: <1323654668-32504-1-git-send-email-boojin.kim@samsung.com>
 <20120105145425.GW11810@n2100.arm.linux.org.uk>
 <003101cce5fe$734b9990$59e2ccb0$%kim@samsung.com>
Message-ID: <20120208084649.GF889@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 08, 2012 at 10:10:30AM +0900, Boojin Kim wrote:
> Russell King - ARM Linux wrote:
> >
> > Now that the PL330 code is entirely out of arch/arm, the header should no
> > longer be in asm/hardware/pl330.h.
> >
> > Definitions private to the driver should be in drivers/dma/pl330.c or a
> > header file co-located.  Other definitions for interfaces to that driver
> > (eg, platform data) should be in include/linux/amba.
> >
> > That can be the subject of a follow-up patch if this is already finalized.
> >
> Sorry to late response. I believed my reply was sent. But, It maybe be not.
> Anyway.. get to the point.
> Pl08x also has asm/hardware/pl080.h to include hw specific information.

History basically.

> It seems to be same purpose with asm/hardware/pl330.h
> Do you mean both asm/hardware/pl080.h and asm/hardware/pl330.h should be
> moved to include/linux/amba?

No.  asm/hardware/pl330.h Should go into drivers/dma if nothing but the
PL330 DMA driver in there needs it.

Same for pl080.h but as your patches isn't touching that, then that's not
something that should be done separately.
