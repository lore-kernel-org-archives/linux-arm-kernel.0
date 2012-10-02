From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 1 Oct 2012 20:52:48 -0400
Subject: [PATCH] [ARM] Enable the second I2C bus on Marvell Kirkwood
In-Reply-To: <20121001235932.GA678@obsidianresearch.com>
References: <20121001235932.GA678@obsidianresearch.com>
Message-ID: <20121002005248.GN17765@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 01, 2012 at 05:59:32PM -0600, Jason Gunthorpe wrote:
> mv64xxx_of_config requires that the tclk frequency be found
> through the clk stuff rather than through device tree, so add
> another override for the 2nd controller.
> 
> Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>

Thanks for the patch, Jason.  Looks good.  One small note, please don't
forget to CC: the maintainers in future submissions.  In this case,
myself and Andrew Lunn.

thx,

Jason.

> ---
>  arch/arm/mach-kirkwood/board-dt.c |    2 ++
>  arch/arm/mach-kirkwood/common.c   |    1 +
>  2 files changed, 3 insertions(+), 0 deletions(-)
> 
> of_serial specifies the tclk frequency (via clock-frequency) in the
> DT, should the i2c have the same option?
> 
> diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
> index d00223e..4428f2f 100644
> --- a/arch/arm/mach-kirkwood/board-dt.c
> +++ b/arch/arm/mach-kirkwood/board-dt.c
> @@ -30,6 +30,8 @@ struct of_dev_auxdata kirkwood_auxdata_lookup[] __initdata = {
>  	OF_DEV_AUXDATA("marvell,orion-spi", 0xf1010600, "orion_spi.0", NULL),
>  	OF_DEV_AUXDATA("marvell,mv64xxx-i2c", 0xf1011000, "mv64xxx_i2c.0",
>  		       NULL),
> +	OF_DEV_AUXDATA("marvell,mv64xxx-i2c", 0xf1011100, "mv64xxx_i2c.1",
> +		       NULL),
>  	OF_DEV_AUXDATA("marvell,orion-wdt", 0xf1020300, "orion_wdt", NULL),
>  	OF_DEV_AUXDATA("marvell,orion-sata", 0xf1080000, "sata_mv.0", NULL),
>  	OF_DEV_AUXDATA("marvell,orion-nand", 0xf4000000, "orion_nand", NULL),
> diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
> index 4177304..0cc2bd2 100644
> --- a/arch/arm/mach-kirkwood/common.c
> +++ b/arch/arm/mach-kirkwood/common.c
> @@ -278,6 +278,7 @@ void __init kirkwood_clk_init(void)
>  	orion_clkdev_add("1", "pcie", pex1);
>  	orion_clkdev_add(NULL, "kirkwood-i2s", audio);
>  	orion_clkdev_add(NULL, MV64XXX_I2C_CTLR_NAME ".0", runit);
> +	orion_clkdev_add(NULL, MV64XXX_I2C_CTLR_NAME ".1", runit);
>  
>  	/* Marvell says runit is used by SPI, UART, NAND, TWSI, ...,
>  	 * so should never be gated.
> -- 
> 1.7.5.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
