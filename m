From: robherring2@gmail.com (Rob Herring)
Date: Fri, 04 Nov 2011 13:30:46 -0500
Subject: [PATCH v3 05/17] ARM: highbank: convert to
	CONFIG_MULTI_IRQ_HANDLER
In-Reply-To: <1320425871-30564-6-git-send-email-marc.zyngier@arm.com>
References: <1320425871-30564-1-git-send-email-marc.zyngier@arm.com>
	<1320425871-30564-6-git-send-email-marc.zyngier@arm.com>
Message-ID: <4EB42F56.1040402@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/04/2011 11:57 AM, Marc Zyngier wrote:
> Convert the highbank platform to be using the gic_handle_irq
> function as its primary interrupt handler.
> 
> Cc: Rob Herring <rob.herring@calxeda.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Rob Herring <rob.herring@calxeda.com>

Rob

> ---
>  arch/arm/Kconfig                                  |    1 +
>  arch/arm/mach-highbank/highbank.c                 |    1 +
>  arch/arm/mach-highbank/include/mach/entry-macro.S |    2 --
>  3 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index c4f13c3..503daf0 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -345,6 +345,7 @@ config ARCH_HIGHBANK
>  	select GENERIC_CLOCKEVENTS
>  	select HAVE_ARM_SCU
>  	select USE_OF
> +	select MULTI_IRQ_HANDLER
>  	help
>  	  Support for the Calxeda Highbank SoC based boards.
>  
> diff --git a/arch/arm/mach-highbank/highbank.c b/arch/arm/mach-highbank/highbank.c
> index b82dcf0..89bdf00 100644
> --- a/arch/arm/mach-highbank/highbank.c
> +++ b/arch/arm/mach-highbank/highbank.c
> @@ -140,6 +140,7 @@ DT_MACHINE_START(HIGHBANK, "Highbank")
>  	.map_io		= highbank_map_io,
>  	.init_irq	= highbank_init_irq,
>  	.timer		= &highbank_timer,
> +	.handle_irq	= gic_handle_irq,
>  	.init_machine	= highbank_init,
>  	.dt_compat	= highbank_match,
>  MACHINE_END
> diff --git a/arch/arm/mach-highbank/include/mach/entry-macro.S b/arch/arm/mach-highbank/include/mach/entry-macro.S
> index 73c1129..a14f9e6 100644
> --- a/arch/arm/mach-highbank/include/mach/entry-macro.S
> +++ b/arch/arm/mach-highbank/include/mach/entry-macro.S
> @@ -1,5 +1,3 @@
> -#include <asm/hardware/entry-macro-gic.S>
> -
>  	.macro	disable_fiq
>  	.endm
>  
