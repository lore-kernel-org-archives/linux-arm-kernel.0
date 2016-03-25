From: yao.yuan@nxp.com (Yao Yuan)
Date: Fri, 25 Mar 2016 06:55:13 +0000
Subject: [PATCH v6 2/2] dts/ls2080a: update the DTS for QSPI and DSPI
 support
In-Reply-To: <1457518926-18518-3-git-send-email-yao.yuan@freescale.com>
References: <1457518926-18518-1-git-send-email-yao.yuan@freescale.com>
 <1457518926-18518-3-git-send-email-yao.yuan@freescale.com>
Message-ID: <AM2PR04MB0722AF5197CA31F40804F7F389830@AM2PR04MB0722.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

Could you please help to review and merge this patch?

Thanks.

Best Regards,
Yuan Yao


On 03/09/2016 08:59 PM, Yao Yuan wrote:
> 
> Signed-off-by: Yuan Yao <yao.yuan@nxp.com>
> Acked-by: Han xu <han.xu@nxp.com>
> ---
> Changed in v6:
> No changes.
> 
> Changed in v5:
> Resend base on arm-soc.
> 
> Changed in v4:
> No changes.
> 
> Changed in v3:
> No changes.
> 
> Changed in v2:
> Update my email to <yao.yuan@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dts | 9 ++++++++-
>  arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi    | 4 ++--
>  2 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dts
> b/arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dts
> index 4cb996d..e8801fa 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dts
> @@ -178,7 +178,14 @@
> 
>  &qspi {
>  	status = "okay";
> -	qflash0: s25fl008k {
> +	flash0: s25fl256s1 at 0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "st,m25p80";
> +		spi-max-frequency = <20000000>;
> +		reg = <0>;
> +	};
> +	flash2: s25fl256s1 at 2 {
>  		#address-cells = <1>;
>  		#size-cells = <1>;
>  		compatible = "st,m25p80";
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
> b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
> index 2b23d03..65e612a 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
> @@ -318,7 +318,7 @@
> 
>  		dspi: dspi at 2100000 {
>  			status = "disabled";
> -			compatible = "fsl,vf610-dspi";
> +			compatible = "fsl,ls2080a-dspi", "fsl,ls2085a-dspi";
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  			reg = <0x0 0x2100000 0x0 0x10000>;
> @@ -444,7 +444,7 @@
> 
>  		qspi: quadspi at 20c0000 {
>  			status = "disabled";
> -			compatible = "fsl,vf610-qspi";
> +			compatible = "fsl,ls2080a-qspi", "fsl,ls1021a-qspi";
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  			reg = <0x0 0x20c0000 0x0 0x10000>,
> --
> 2.1.0.27.g96db324
