From: horia.geanta@nxp.com (=?iso-8859-2?Q?Horia_Geant=E3?=)
Date: Thu, 1 Feb 2018 11:44:23 +0000
Subject: [PATCH v3 5/5] ARM: dts: imx7s: add CAAM device node
References: <1517364040-27607-1-git-send-email-pure.logic@nexus-software.ie>
 <1517364040-27607-6-git-send-email-pure.logic@nexus-software.ie>
Message-ID: <VI1PR0402MB334269ACFE0805A2E31D604B98FA0@VI1PR0402MB3342.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/31/2018 4:00 AM, Bryan O'Donoghue wrote:
> From: Rui Miguel Silva <rui.silva@linaro.org>
> 
> Add CAAM device node to the i.MX7s device tree.
> 
> Signed-off-by: Rui Miguel Silva <rui.silva@linaro.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: "Horia Geant?" <horia.geanta@nxp.com>
> Cc: Aymen Sghaier <aymen.sghaier@nxp.com>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Lukas Auer <lukas.auer@aisec.fraunhofer.de>
> Signed-off-by: Bryan O'Donoghue <pure.logic@nexus-software.ie>
> ---
>  arch/arm/boot/dts/imx7s.dtsi | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
> index 82ad26e..e38c159 100644
> --- a/arch/arm/boot/dts/imx7s.dtsi
> +++ b/arch/arm/boot/dts/imx7s.dtsi
> @@ -805,6 +805,37 @@
>  				status = "disabled";
>  			};
>  
> +			crypto: caam at 30900000 {
> +				compatible = "fsl,sec-v4.0";
> +				fsl,sec-era = <4>;
CCBVID[CAAM_ERA] = 8.
Either remove this (optional) property and let the bootloader add it
dynamically, or provide a correct value for it.

Thanks,
Horia
