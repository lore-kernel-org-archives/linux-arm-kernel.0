From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 20 Mar 2015 11:54:48 +0100
Subject: [PATCH] ARM: at91: fix pm_suspend.S compilation when ARMv6 is
 selected
In-Reply-To: <1426796080-18506-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1426796080-18506-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <550BFC78.3050500@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 19/03/2015 21:14, Alexandre Belloni a ?crit :
> When compiling for multiplatform for both ARMv6 and ARMv7, the default compiler
> flags are for ARMv6, and results in:
> 
> arch/arm/mach-at91/pm_suspend.S:144: Error: selected processor does not support ARM mode `dsb'
> 
> Enforce ARMv7 flags for pm_suspend.o when CPU_V7 is selected.
> 
> Reported-by: fengguang.wu at intel.com

Changed in:

Reported-by: kbuild test robot <fengguang.wu@intel.com>

> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Thanks.

> ---
>  arch/arm/mach-at91/Makefile | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
> index 06a4cefd33a0..4fa8b4541e64 100644
> --- a/arch/arm/mach-at91/Makefile
> +++ b/arch/arm/mach-at91/Makefile
> @@ -17,6 +17,9 @@ obj-$(CONFIG_SOC_SAMA5)		+= sama5.o
>  obj-$(CONFIG_PM)		+= pm.o
>  obj-$(CONFIG_PM)		+= pm_suspend.o
>  
> +ifeq ($(CONFIG_CPU_V7),y)
> +AFLAGS_pm_suspend.o := -march=armv7-a
> +endif
>  ifeq ($(CONFIG_PM_DEBUG),y)
>  CFLAGS_pm.o += -DDEBUG
>  endif
> 


-- 
Nicolas Ferre
