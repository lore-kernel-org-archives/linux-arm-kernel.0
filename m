From: tony@atomide.com (Tony Lindgren)
Date: Tue, 19 Apr 2011 04:05:17 -0700
Subject: [PATCH v4 0/4] OMAP: DMA: mstandby mode and runtime pm support
In-Reply-To: <1301322422-29886-1-git-send-email-manjugk@ti.com>
References: <1301322422-29886-1-git-send-email-manjugk@ti.com>
Message-ID: <20110419110517.GG477@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* G, Manjunath Kondaiah <manjugk@ti.com> [110328 07:29]:
> 
> G, Manjunath Kondaiah (4):
>   OMAP2+: PM: omap device: API's for handling mstandby mode
>   OMAP2+: DMA: prevent races while setting M idle mode to nostandby
>   OMAP: PM: DMA: Enable runtime pm
>   OMAP: DMA: Fix: context restore during off mode
> 
>  arch/arm/mach-omap1/dma.c                     |    1 +
>  arch/arm/mach-omap2/dma.c                     |   16 ++
>  arch/arm/mach-omap2/omap_hwmod.c              |   42 ++++++
>  arch/arm/plat-omap/dma.c                      |  196 +++++++++++++++++++++----
>  arch/arm/plat-omap/include/plat/dma.h         |    1 +
>  arch/arm/plat-omap/include/plat/omap_device.h |    2 +
>  arch/arm/plat-omap/include/plat/omap_hwmod.h  |    4 +-
>  arch/arm/plat-omap/omap_device.c              |   62 ++++++++
>  8 files changed, 291 insertions(+), 33 deletions(-)

With the DMA code too we need to do the cleanup to move it
to drivers/dma before adding new features.

Tony
 
