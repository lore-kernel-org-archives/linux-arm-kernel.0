From: csd@broadcom.com (Christian Daudt)
Date: Tue, 14 May 2013 11:04:50 -0700
Subject: [PATCH 12/20] ARM: bcm281xx: Remove init_irq declaration in
 machine description
In-Reply-To: <1368545933-7430-13-git-send-email-maxime.ripard@free-electrons.com>
References: <1368545933-7430-1-git-send-email-maxime.ripard@free-electrons.com>
 <1368545933-7430-13-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <51927CC2.7080101@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13-05-14 08:38 AM, Maxime Ripard wrote:
> Commit ebafed7a ("ARM: irq: Call irqchip_init if no init_irq function is
> specified") removed the need to explictly setup the init_irq field in
> the machine description when using only irqchip_init. Remove that
> declaration for bcm281xx as well.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Acked-by: Christian Daudt <csd@broadcom.com>
> ---
>   arch/arm/mach-bcm/board_bcm.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/arch/arm/mach-bcm/board_bcm.c b/arch/arm/mach-bcm/board_bcm.c
> index 22e8421..2859932 100644
> --- a/arch/arm/mach-bcm/board_bcm.c
> +++ b/arch/arm/mach-bcm/board_bcm.c
> @@ -15,7 +15,6 @@
>   #include <linux/init.h>
>   #include <linux/device.h>
>   #include <linux/platform_device.h>
> -#include <linux/irqchip.h>
>   #include <linux/clocksource.h>
>   
>   #include <asm/mach/arch.h>
> @@ -54,7 +53,6 @@ static void __init board_init(void)
>   static const char * const bcm11351_dt_compat[] = { "bcm,bcm11351", NULL, };
>   
>   DT_MACHINE_START(BCM11351_DT, "Broadcom Application Processor")
> -	.init_irq = irqchip_init,
>   	.init_time = clocksource_of_init,
>   	.init_machine = board_init,
>   	.dt_compat = bcm11351_dt_compat,
Applied.

  Thanks,
    csd
