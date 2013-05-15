From: linux@prisktech.co.nz (Tony Prisk)
Date: Thu, 16 May 2013 06:52:03 +1200
Subject: [PATCH 20/20] ARM: vt8500: Remove init_irq declaration in machine
 description
In-Reply-To: <1368545933-7430-21-git-send-email-maxime.ripard@free-electrons.com>
References: <1368545933-7430-1-git-send-email-maxime.ripard@free-electrons.com>
 <1368545933-7430-21-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <5193D953.5040202@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/05/13 03:38, Maxime Ripard wrote:
> Commit ebafed7a ("ARM: irq: Call irqchip_init if no init_irq function is
> specified") removed the need to explictly setup the init_irq field in
> the machine description when using only irqchip_init. Remove that
> declaration for vt8500 as well.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>   arch/arm/mach-vt8500/vt8500.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/arch/arm/mach-vt8500/vt8500.c b/arch/arm/mach-vt8500/vt8500.c
> index 1dd281e..70a5ac9 100644
> --- a/arch/arm/mach-vt8500/vt8500.c
> +++ b/arch/arm/mach-vt8500/vt8500.c
> @@ -20,7 +20,6 @@
>   
>   #include <linux/clocksource.h>
>   #include <linux/io.h>
> -#include <linux/irqchip.h>
>   #include <linux/pm.h>
>   
>   #include <asm/mach-types.h>
> @@ -178,7 +177,6 @@ static const char * const vt8500_dt_compat[] = {
>   DT_MACHINE_START(WMT_DT, "VIA/Wondermedia SoC (Device Tree Support)")
>   	.dt_compat	= vt8500_dt_compat,
>   	.map_io		= vt8500_map_io,
> -	.init_irq	= irqchip_init,
>   	.init_machine	= vt8500_init,
>   	.init_time	= clocksource_of_init,
>   	.restart	= vt8500_restart,
I don't have any plans to touch this driver, so please send direct to 
arm-soc as Arnd
requested.

Acked-by: Tony Prisk <linux@prisktech.co.nz>

Regards
Tony Prisk
