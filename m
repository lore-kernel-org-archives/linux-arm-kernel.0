From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 23 Jun 2011 09:48:40 +0200
Subject: [PATCH 1/2] ARM:mx53: Add I2C3 support
In-Reply-To: <1308771185-4491-1-git-send-email-andre.silva@freescale.com>
References: <1308771185-4491-1-git-send-email-andre.silva@freescale.com>
Message-ID: <20110623074840.GQ6069@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Applied

On Wed, Jun 22, 2011 at 04:33:04PM -0300, Andre Silva wrote:
> Signed-off-by: Andre Silva <andre.silva@freescale.com>
> 
> ---
>  arch/arm/mach-mx5/clock-mx51-mx53.c          |    3 +++
>  arch/arm/plat-mxc/devices/platform-imx-i2c.c |    3 ++-
>  2 files changed, 5 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/clock-mx51-mx53.c
> index bbc837b..4fb63d9 100644
> --- a/arch/arm/mach-mx5/clock-mx51-mx53.c
> +++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
> @@ -1279,6 +1279,8 @@ DEFINE_CLOCK(i2c2_clk, 1, MXC_CCM_CCGR1, MXC_CCM_CCGRx_CG10_OFFSET,
>  	NULL, NULL, &ipg_clk, NULL);
>  DEFINE_CLOCK(hsi2c_clk, 0, MXC_CCM_CCGR1, MXC_CCM_CCGRx_CG11_OFFSET,
>  	NULL, NULL, &ipg_clk, NULL);
> +DEFINE_CLOCK(i2c3_mx53_clk, 0, MXC_CCM_CCGR1, MXC_CCM_CCGRx_CG11_OFFSET,
> +	NULL, NULL, &ipg_clk, NULL);
>  
>  /* FEC */
>  DEFINE_CLOCK(fec_clk, 0, MXC_CCM_CCGR2, MXC_CCM_CCGRx_CG12_OFFSET,
> @@ -1467,6 +1469,7 @@ static struct clk_lookup mx53_lookups[] = {
>  	_REGISTER_CLOCK(NULL, "iim_clk", iim_clk)
>  	_REGISTER_CLOCK("imx-i2c.0", NULL, i2c1_clk)
>  	_REGISTER_CLOCK("imx-i2c.1", NULL, i2c2_clk)
> +	_REGISTER_CLOCK("imx-i2c.2", NULL, i2c3_mx53_clk)
>  	_REGISTER_CLOCK("sdhci-esdhc-imx.0", NULL, esdhc1_clk)
>  	_REGISTER_CLOCK("sdhci-esdhc-imx.1", NULL, esdhc2_mx53_clk)
>  	_REGISTER_CLOCK("sdhci-esdhc-imx.2", NULL, esdhc3_mx53_clk)
> diff --git a/arch/arm/plat-mxc/devices/platform-imx-i2c.c b/arch/arm/plat-mxc/devices/platform-imx-i2c.c
> index 2ab74f0..afe60f7 100644
> --- a/arch/arm/plat-mxc/devices/platform-imx-i2c.c
> +++ b/arch/arm/plat-mxc/devices/platform-imx-i2c.c
> @@ -94,8 +94,9 @@ const struct imx_imx_i2c_data imx53_imx_i2c_data[] __initconst = {
>  	imx_imx_i2c_data_entry(MX53, _id, _hwid, SZ_4K)
>  	imx53_imx_i2c_data_entry(0, 1),
>  	imx53_imx_i2c_data_entry(1, 2),
> +	imx53_imx_i2c_data_entry(2, 3),
>  };
> -#endif /* ifdef CONFIG_SOC_IMX51 */
> +#endif /* ifdef CONFIG_SOC_IMX53 */
>  
>  struct platform_device *__init imx_add_imx_i2c(
>  		const struct imx_imx_i2c_data *data,
> -- 
> 1.7.5.4
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
