From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 22 Sep 2017 14:54:56 +0800
Subject: [PATCH v2] arm64: dts: ls1088a: Add USB support
In-Reply-To: <20170913091009.21448-1-yinbo.zhu@nxp.com>
References: <20170913091009.21448-1-yinbo.zhu@nxp.com>
Message-ID: <20170922065454.GF26358@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 13, 2017 at 05:10:09PM +0800, yinbo.zhu at nxp.com wrote:
> From: "yinbo.zhu" <yinbo.zhu@nxp.com>
> 
> Fix the issue that usb is not detected on ls1088ardb

It's not really about fixing issue but adding support.

> 
> Signed-off-by: yinbo.zhu <yinbo.zhu@nxp.com>
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> ---

You should better have a version history here to tell what's changed
between version.

>  arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts |  8 ++++++++
>  arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi    | 20 ++++++++++++++++++++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
> index 213abb72de93..6c3c3bc4b681 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
> @@ -118,6 +118,14 @@
>  	status = "okay";
>  };
>  
> +&usb0 {
> +	status = "okay";
> +};
> +
> +&usb1 {
> +	status = "okay";
> +};
> +
>  &esdhc {

Please sort these labeled nodes alphabetically.

Shawn

>  	status = "okay";
>  };
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> index c144d06a6e33..c23fede8cf5d 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> @@ -359,6 +359,26 @@
>  			status = "disabled";
>  		};
>  
> +		usb0: usb3 at 3100000 {
> +			compatible = "snps,dwc3";
> +			reg = <0x0 0x3100000 0x0 0x10000>;
> +			interrupts = <0 80 IRQ_TYPE_LEVEL_HIGH>;
> +			dr_mode = "host";
> +			snps,quirk-frame-length-adjustment = <0x20>;
> +			snps,dis_rxdet_inp3_quirk;
> +			status = "disabled";
> +		};
> +
> +		usb1: usb3 at 3110000 {
> +			compatible = "snps,dwc3";
> +			reg = <0x0 0x3110000 0x0 0x10000>;
> +			interrupts = <0 81 IRQ_TYPE_LEVEL_HIGH>;
> +			dr_mode = "host";
> +			snps,quirk-frame-length-adjustment = <0x20>;
> +			snps,dis_rxdet_inp3_quirk;
> +			status = "disabled";
> +		};
> +
>  		sata: sata at 3200000 {
>  			compatible = "fsl,ls1088a-ahci";
>  			reg = <0x0 0x3200000 0x0 0x10000>,
> -- 
> 2.14.1
> 
