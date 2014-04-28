From: dinguyen@altera.com (Dinh Nguyen)
Date: Mon, 28 Apr 2014 12:56:04 -0500
Subject: [PATCH 15/16] ARM: l2c: convert socfpga to generic l2c
 initialisation
In-Reply-To: <E1WeotT-0002QK-Em@rmk-PC.arm.linux.org.uk>
References: <20140428165631.GM26756@n2100.arm.linux.org.uk>
 <E1WeotT-0002QK-Em@rmk-PC.arm.linux.org.uk>
Message-ID: <1398707764.20739.1.camel@linux-builds1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-04-28 at 17:59 +0100, Russell King wrote:
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/mach-socfpga/socfpga.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/mach-socfpga/socfpga.c
> index 9bbb8177f247..adbf38314ca8 100644
> --- a/arch/arm/mach-socfpga/socfpga.c
> +++ b/arch/arm/mach-socfpga/socfpga.c
> @@ -98,22 +98,17 @@ static void socfpga_cyclone5_restart(enum reboot_mode mode, const char *cmd)
>  	writel(temp, rst_manager_base_addr + SOCFPGA_RSTMGR_CTRL);
>  }
>  
> -static void __init socfpga_cyclone5_init(void)
> -{
> -	l2x0_of_init(0, ~0);
> -	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> -}
> -
>  static const char *altera_dt_match[] = {
>  	"altr,socfpga",
>  	NULL
>  };
>  
>  DT_MACHINE_START(SOCFPGA, "Altera SOCFPGA")
> +	.l2c_aux_val	= 0,
> +	.l2c_aux_mask	= ~0,
>  	.smp		= smp_ops(socfpga_smp_ops),
>  	.map_io		= socfpga_map_io,
>  	.init_irq	= socfpga_init_irq,
> -	.init_machine	= socfpga_cyclone5_init,
>  	.restart	= socfpga_cyclone5_restart,
>  	.dt_compat	= altera_dt_match,
>  MACHINE_END

Thanks so much for doing this.

Tested-by: Dinh Nguyen <dinguyen@altera.com>

Dinh
