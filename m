From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 27 Aug 2018 10:13:28 +0800
Subject: [PATCH 1/2] soc: imx: gpc: use A_CORE instread of A7 for more
 i.MX platforms
In-Reply-To: <1533537589-7202-1-git-send-email-Anson.Huang@nxp.com>
References: <1533537589-7202-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <20180827021326.GA3850@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrey,

Are you fine with these two patches?

Shawn

On Mon, Aug 06, 2018 at 02:39:48PM +0800, Anson Huang wrote:
> gpcv2 driver is NOT just used on i.MX7D which has Cortex-A7
> cores, but also on i.MX8MQ/i.MX8MM platforms which use Cortex-A53
> cores, so let's use A_CORE instread of A7 to avoid confusion.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/soc/imx/gpcv2.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
> index 6ef18cf..0e31465 100644
> --- a/drivers/soc/imx/gpcv2.c
> +++ b/drivers/soc/imx/gpcv2.c
> @@ -20,14 +20,14 @@
>  #include <linux/regulator/consumer.h>
>  #include <dt-bindings/power/imx7-power.h>
>  
> -#define GPC_LPCR_A7_BSC			0x000
> +#define GPC_LPCR_A_CORE_BSC			0x000
>  
>  #define GPC_PGC_CPU_MAPPING		0x0ec
> -#define USB_HSIC_PHY_A7_DOMAIN		BIT(6)
> -#define USB_OTG2_PHY_A7_DOMAIN		BIT(5)
> -#define USB_OTG1_PHY_A7_DOMAIN		BIT(4)
> -#define PCIE_PHY_A7_DOMAIN		BIT(3)
> -#define MIPI_PHY_A7_DOMAIN		BIT(2)
> +#define USB_HSIC_PHY_A_CORE_DOMAIN		BIT(6)
> +#define USB_OTG2_PHY_A_CORE_DOMAIN		BIT(5)
> +#define USB_OTG1_PHY_A_CORE_DOMAIN		BIT(4)
> +#define PCIE_PHY_A_CORE_DOMAIN		BIT(3)
> +#define MIPI_PHY_A_CORE_DOMAIN		BIT(2)
>  
>  #define GPC_PU_PGC_SW_PUP_REQ		0x0f8
>  #define GPC_PU_PGC_SW_PDN_REQ		0x104
> @@ -167,7 +167,7 @@ static const struct imx7_pgc_domain imx7_pgc_domains[] = {
>  		},
>  		.bits  = {
>  			.pxx = MIPI_PHY_SW_Pxx_REQ,
> -			.map = MIPI_PHY_A7_DOMAIN,
> +			.map = MIPI_PHY_A_CORE_DOMAIN,
>  		},
>  		.voltage   = 1000000,
>  		.pgc	   = PGC_MIPI,
> @@ -179,7 +179,7 @@ static const struct imx7_pgc_domain imx7_pgc_domains[] = {
>  		},
>  		.bits  = {
>  			.pxx = PCIE_PHY_SW_Pxx_REQ,
> -			.map = PCIE_PHY_A7_DOMAIN,
> +			.map = PCIE_PHY_A_CORE_DOMAIN,
>  		},
>  		.voltage   = 1000000,
>  		.pgc	   = PGC_PCIE,
> @@ -191,7 +191,7 @@ static const struct imx7_pgc_domain imx7_pgc_domains[] = {
>  		},
>  		.bits  = {
>  			.pxx = USB_HSIC_PHY_SW_Pxx_REQ,
> -			.map = USB_HSIC_PHY_A7_DOMAIN,
> +			.map = USB_HSIC_PHY_A_CORE_DOMAIN,
>  		},
>  		.voltage   = 1200000,
>  		.pgc	   = PGC_USB_HSIC,
> @@ -261,7 +261,7 @@ builtin_platform_driver(imx7_pgc_domain_driver)
>  static int imx_gpcv2_probe(struct platform_device *pdev)
>  {
>  	static const struct regmap_range yes_ranges[] = {
> -		regmap_reg_range(GPC_LPCR_A7_BSC,
> +		regmap_reg_range(GPC_LPCR_A_CORE_BSC,
>  				 GPC_M4_PU_PDN_FLG),
>  		regmap_reg_range(GPC_PGC_CTRL(PGC_MIPI),
>  				 GPC_PGC_SR(PGC_MIPI)),
> -- 
> 2.7.4
> 
