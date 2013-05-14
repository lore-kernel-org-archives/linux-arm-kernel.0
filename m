From: michal.simek@xilinx.com (Michal Simek)
Date: Tue, 14 May 2013 17:49:08 +0200
Subject: [PATCH 02/20] ARM: zynq: Remove init_irq declaration in machine
 description
In-Reply-To: <1368545933-7430-3-git-send-email-maxime.ripard@free-electrons.com>
References: <1368545933-7430-1-git-send-email-maxime.ripard@free-electrons.com>
 <1368545933-7430-3-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <4e7a6946-b165-4440-9785-e0d538b608e0@CO9EHSMHS013.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/14/2013 05:38 PM, Maxime Ripard wrote:
> Commit ebafed7a ("ARM: irq: Call irqchip_init if no init_irq function is
> specified") removed the need to explictly setup the init_irq field in
> the machine description when using only irqchip_init. Remove that
> declaration for zynq as well.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Acked-by: Michal Simek <monstr@monstr.eu>
> ---
>  arch/arm/mach-zynq/common.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
> index 5bfe703..4c0199b8 100644
> --- a/arch/arm/mach-zynq/common.c
> +++ b/arch/arm/mach-zynq/common.c
> @@ -25,7 +25,6 @@
>  #include <linux/of_irq.h>
>  #include <linux/of_platform.h>
>  #include <linux/of.h>
> -#include <linux/irqchip.h>
>  
>  #include <asm/mach/arch.h>
>  #include <asm/mach/map.h>
> @@ -106,7 +105,6 @@ static const char * const zynq_dt_match[] = {
>  MACHINE_START(XILINX_EP107, "Xilinx Zynq Platform")
>  	.smp		= smp_ops(zynq_smp_ops),
>  	.map_io		= zynq_map_io,
> -	.init_irq	= irqchip_init,
>  	.init_machine	= zynq_init_machine,
>  	.init_time	= zynq_timer_init,
>  	.dt_compat	= zynq_dt_match,
> 

Subject should contain v2 but anyway I have added it my zynq repo.

Thanks,
Michal
