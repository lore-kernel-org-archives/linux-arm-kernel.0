From: grinberg@compulab.co.il (Igor Grinberg)
Date: Thu, 29 Nov 2012 09:10:48 +0200
Subject: [PATCH V2 3/4] ARM: AM335x: Fix warning in timer.c
In-Reply-To: <1354140300-16825-4-git-send-email-jon-hunter@ti.com>
References: <1354140300-16825-1-git-send-email-jon-hunter@ti.com>
 <1354140300-16825-4-git-send-email-jon-hunter@ti.com>
Message-ID: <50B70A78.3010704@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/29/12 00:04, Jon Hunter wrote:
> When compiling the kernel with configuration options ...
> 
>  # CONFIG_ARCH_OMAP2 is not set
>  # CONFIG_ARCH_OMAP3 is not set
>  # CONFIG_ARCH_OMAP4 is not set
>  # CONFIG_SOC_OMAP5 is not set
>  CONFIG_SOC_AM33XX=y
> 
>  ... the following build warning is seen.
> 
>   CC      arch/arm/mach-omap2/timer.o
>   arch/arm/mach-omap2/timer.c:395:19: warning: ?omap2_sync32k_clocksource_init?
>   	defined but not used [-Wunused-function]
> 
> This issue was introduced by commit 6f80b3b (ARM: OMAP2+: timer: remove
> CONFIG_OMAP_32K_TIMER) where the omap2_sync32k_clocksource_init() is no
> longer referenced by the timer initialisation function for the AM335x
> device as it has no 32k-sync timer.
> 
> Fix this by adding the "__maybe_unused" compiler directive to the
> omap2_sync32k_clocksource_init() function to indicate that this function
> may be used for certain configurations.
> 
> Cc: Igor Grinberg <grinberg@compulab.co.il>
> 
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>

Acked-by: Igor Grinberg <grinberg@compulab.co.il>


-- 
Regards,
Igor.
