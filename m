From: tony@atomide.com (Tony Lindgren)
Date: Mon, 22 Feb 2010 14:13:52 -0800
Subject: [PATCH 8/9] omap4: Use dma line defines from dma-44xx.h
In-Reply-To: <1266483554-15044-8-git-send-email-santosh.shilimkar@ti.com>
References: <1266483554-15044-1-git-send-email-santosh.shilimkar@ti.com>
	<1266483554-15044-2-git-send-email-santosh.shilimkar@ti.com>
	<1266483554-15044-3-git-send-email-santosh.shilimkar@ti.com>
	<1266483554-15044-4-git-send-email-santosh.shilimkar@ti.com>
	<1266483554-15044-5-git-send-email-santosh.shilimkar@ti.com>
	<1266483554-15044-6-git-send-email-santosh.shilimkar@ti.com>
	<1266483554-15044-7-git-send-email-santosh.shilimkar@ti.com>
	<1266483554-15044-8-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20100222221352.GY18786@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [100218 00:56]:
> This patch removes all the omap4 specific dma request
> lines defines from plat/dma.h and includes dma-44xx.h
> 
> The defines are aligned so no driver should be impacted
> because of this change.

Dropped this and the next patch as they break compile for _all_
omap1 machines:

arch/arm/plat-omap/dma.c: In function 'omap_init_dma':
arch/arm/plat-omap/dma.c:2135: error: 'OMAP44XX_IRQ_SDMA_0' undeclared (first use in this function)
arch/arm/plat-omap/dma.c:2135: error: (Each undeclared identifier is reported only once
arch/arm/plat-omap/dma.c:2135: error: for each function it appears in.)

Suspect the next patch will too, not even going to try to
build test that.

Regards,

Tony
