From: nsekhar@ti.com (Nori, Sekhar)
Date: Fri, 8 Jul 2011 22:21:52 +0530
Subject: [RFC PATCH v4] Consolidate SRAM support
In-Reply-To: <1306371777-20431-1-git-send-email-plagnioj@jcrosoft.com>
References: <20110512174546.GB8633@n2100.arm.linux.org.uk>
	<1306371777-20431-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D9B5940@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean-Christophe,

On Thu, May 26, 2011 at 06:32:57, Jean-Christophe PLAGNIOL-VILLARD wrote:
> From: Russell King - ARM Linux <linux@arm.linux.org.uk>
> 
> We have two SoCs using SRAM, both with their own allocation systems,
> and both with their own ways of copying functions into the SRAM.
> 
> Let's unify this before we have additional SoCs re-implementing this
> obviously common functionality themselves.
> 
> For this use the generic allocator and the newly introduce
> gen_pool_add_virt and gen_pool_virt_to_phys
> 
> Uio_pruss should probably take the SRAM pool pointer via
> platform data so that it doesn't have to include Davinci specific
> includes.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Sascha Hauer <kernel@pengutronix.de>

> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index f4b7dfa..5ec5e5f 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -848,6 +848,7 @@ config ARCH_DAVINCI
>  	bool "TI DaVinci"
>  	select GENERIC_CLOCKEVENTS
>  	select ARCH_REQUIRE_GPIOLIB
> +	select GENERIC_ALLOCATOR
>  	select ZONE_DMA
>  	select HAVE_IDE
>  	select CLKDEV_LOOKUP

GENERIC_ALLOCATOR is already selected for
DaVinci (below the "select CLKDEV_LOOKUP"
line).

Please drop this hunk.

Thanks,
Sekhar
