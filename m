From: mporter@ti.com (Matt Porter)
Date: Fri, 1 Feb 2013 13:49:16 -0500
Subject: [PATCH v7 01/10] ARM: davinci: move private EDMA API to arm/common
In-Reply-To: <5022f635a527470dbd0be932063e9cd2@DFLE72.ent.ti.com>
References: <1359742975-10421-1-git-send-email-mporter@ti.com>
 <1359742975-10421-2-git-send-email-mporter@ti.com>
 <5022f635a527470dbd0be932063e9cd2@DFLE72.ent.ti.com>
Message-ID: <20130201184915.GP2244@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 01, 2013 at 06:41:08PM +0000, Tony Lindgren wrote:
> * Matt Porter <mporter@ti.com> [130201 10:25]:
> > Move mach-davinci/dma.c to common/edma.c so it can be used
> > by OMAP (specifically AM33xx) as well.
> 
> I think this should rather go to drivers/dma/?

No, this is the private EDMA API. It's the analogous thing to
the private OMAP dma API that is in plat-omap/dma.c. The actual
dmaengine driver is in drivers/dma/edma.c as a wrapper around
this...same way OMAP DMA engine conversion is being done.

-Matt
