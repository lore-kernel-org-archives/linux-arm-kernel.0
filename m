From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 06 Jan 2012 10:47:06 +0900
Subject: [PATCH v2 1/2] DMA: PL330: Merge PL330 driver into drivers/dma/
In-Reply-To: <20120105145425.GW11810@n2100.arm.linux.org.uk>
References: <1323654668-32504-1-git-send-email-boojin.kim@samsung.com>
 <20120105145425.GW11810@n2100.arm.linux.org.uk>
Message-ID: <02c901cccc15$18d82620$4a887260$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> 
> On Mon, Dec 12, 2011 at 10:51:08AM +0900, Boojin Kim wrote:
> > Currently there were two part of DMAC PL330 driver for
> > support old styled s3c-pl330 which has been merged into
> > drivers/dma/pl330.c driver. Actually, there is no reason
> > to separate them now.
> >
> > Basically this patch merges arch/arm/common/pl330.c into
> > drivers/dma/pl330.c driver and removes useless exported
> > symbol, externed function and so on.
> >
> > The newer pl330 driver tested on SMDKV310 and SMDK4212 boards
> >
> > Cc: Jassi Brar <jassisinghbrar@gmail.com>
> > Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> > Cc: Vinod Koul <vinod.koul@intel.com>
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
> > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> >
> > Change since V1:
> > Modify the order of definitions/declarations according to linux coding
> rules.
> > ---
> >  arch/arm/common/Kconfig               |    3 -
> >  arch/arm/common/Makefile              |    1 -
> >  arch/arm/common/pl330.c               | 1971
------------------------------
> ---
> >  arch/arm/include/asm/hardware/pl330.h |  333 +++---
> >  drivers/dma/Kconfig                   |    1 -
> >  drivers/dma/pl330.c                   | 1892
+++++++++++++++++++++++++++++++
> >  6 files changed, 2074 insertions(+), 2127 deletions(-)
> >  delete mode 100644 arch/arm/common/pl330.c
> 
> Now that the PL330 code is entirely out of arch/arm, the header should no
> longer be in asm/hardware/pl330.h.
> 
Yes, right.

> Definitions private to the driver should be in drivers/dma/pl330.c or a
> header file co-located.  Other definitions for interfaces to that driver
> (eg, platform data) should be in include/linux/amba.
> 
OK.

> That can be the subject of a follow-up patch if this is already finalized.

Yes, this has been already sent to arm-soc for this merge window. So we need
another one for address comments from you.

Boojin, could you please do that?

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
