From: tony@atomide.com (Tony Lindgren)
Date: Mon, 28 Mar 2011 13:50:27 -0700
Subject: [pm-core][PATCH v3 01/21] OMAP4: PM: Add omap WakeupGen module
	support
In-Reply-To: <1301304157-2466-2-git-send-email-santosh.shilimkar@ti.com>
References: <1301304157-2466-1-git-send-email-santosh.shilimkar@ti.com>
	<1301304157-2466-2-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20110328205027.GC30616@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [110328 02:20]:
> --- a/arch/arm/mach-omap2/omap4-common.c
> +++ b/arch/arm/mach-omap2/omap4-common.c
> @@ -21,6 +21,7 @@
>  
>  #include <mach/hardware.h>
>  #include <mach/omap4-common.h>
> +#include <mach/omap-wakeupgen.h>
>  
>  #ifdef CONFIG_CACHE_L2X0
>  void __iomem *l2cache_base;
> @@ -41,6 +42,8 @@ void __init gic_init_irq(void)
>  	gic_cpu_base = ioremap(OMAP44XX_GIC_CPU_BASE, SZ_512);
>  	BUG_ON(!gic_cpu_base);
>  
> +	omap_wakeupgen_init();
> +
>  	gic_init(0, 29, gic_dist_base_addr, gic_cpu_base);
>  }

Do you really need to initialize all of this that early?

Tony
