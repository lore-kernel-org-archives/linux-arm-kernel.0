From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 24 Feb 2012 20:15:41 +0100
Subject: [PATCH] ARM: integrator: convert to sparse irqs
In-Reply-To: <1330104737-22782-1-git-send-email-linus.walleij@linaro.org>
References: <1330104737-22782-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20120224191541.GB21556@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18:32 Fri 24 Feb     , Linus Walleij wrote:
> This converts the Integrator AP/CP to use sparse IRQs.
> Tested on both machines.
> 
> Cc: Rob Herring <rob.herring@calxeda.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/arm/Kconfig                             |    1 +
>  arch/arm/mach-integrator/core.c              |    3 ++-
>  arch/arm/mach-integrator/include/mach/irqs.h |    3 ++-
>  arch/arm/mach-integrator/integrator_ap.c     |    3 ++-
>  arch/arm/mach-integrator/integrator_cp.c     |    3 ++-
>  arch/arm/mach-integrator/pci.c               |    3 ++-
>  arch/arm/mach-integrator/pci_v3.c            |    3 ++-
>  7 files changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 4852a6b..fc10ed8 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -266,6 +266,7 @@ config ARCH_INTEGRATOR
>  	select PLAT_VERSATILE
>  	select PLAT_VERSATILE_FPGA_IRQ
>  	select NEED_MACH_MEMORY_H
> +	select SPARSE_IRQ
>  	help
>  	  Support for ARM's Integrator platform.
>  
> diff --git a/arch/arm/mach-integrator/core.c b/arch/arm/mach-integrator/core.c
> index 15b87f2..304dfb2 100644
> --- a/arch/arm/mach-integrator/core.c
> +++ b/arch/arm/mach-integrator/core.c
> @@ -25,8 +25,9 @@
>  
>  #include <mach/hardware.h>
>  #include <mach/platform.h>
> -#include <asm/irq.h>
>  #include <mach/cm.h>
> +#include <mach/irqs.h>
> +
>  #include <asm/system.h>
>  #include <asm/leds.h>
>  #include <asm/mach-types.h>
> diff --git a/arch/arm/mach-integrator/include/mach/irqs.h b/arch/arm/mach-integrator/include/mach/irqs.h
> index 1fbe6d1..a19a1a2 100644
> --- a/arch/arm/mach-integrator/include/mach/irqs.h
> +++ b/arch/arm/mach-integrator/include/mach/irqs.h
> @@ -78,5 +78,6 @@
>  #define IRQ_SIC_CP_LMINT7		46
>  #define IRQ_SIC_END			46
>  
> -#define NR_IRQS                         47
> +#define NR_IRQS_INTEGRATOR_AP		34
> +#define NR_IRQS_INTEGRATOR_CP		47
why do you need to specified both?

Best Regards,
J.
