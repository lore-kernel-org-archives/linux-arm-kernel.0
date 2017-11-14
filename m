From: yinbo.zhu@nxp.com (Yinbo Zhu)
Date: Tue, 14 Nov 2017 08:00:00 +0000
Subject: [PATCH v2] arm64: dts: ls1088a: Add USB support
In-Reply-To: <VI1PR04MB1262D160BA8625330E32CAF9E9470@VI1PR04MB1262.eurprd04.prod.outlook.com>
References: <20170913091009.21448-1-yinbo.zhu@nxp.com>
 <20170922065454.GF26358@dragon>
 <VI1PR04MB1262D160BA8625330E32CAF9E9470@VI1PR04MB1262.eurprd04.prod.outlook.com>
Message-ID: <AM3PR04MB12515DB71B8ACF7422A20244E9280@AM3PR04MB1251.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



-----Original Message-----
From: Yinbo Zhu 
Sent: Tuesday, October 24, 2017 5:15 PM
To: Shawn Guo <shawnguo@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>; Catalin Marinas ) <catalin.marinas@arm.com>; Will Deacon ) <will.deacon@arm.com>; Harninder Rai <harninder.rai@nxp.com>; Raghav Dogra <raghav.dogra@nxp.com>; Ashish Kumar <ashish.kumar@nxp.com>; Andy Tang <andy.tang@nxp.com>; open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS <devicetree@vger.kernel.org>; linux-arm-kernel at lists.infradead.org; open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] arm64: dts: ls1088a: Add USB support


-----Original Message-----
From: Shawn Guo [mailto:shawnguo at kernel.org] 
Sent: Friday, September 22, 2017 2:55 PM
To: Yinbo Zhu <yinbo.zhu@nxp.com>
Cc: Rob Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>; Catalin Marinas ) <catalin.marinas@arm.com>; Will Deacon ) <will.deacon@arm.com>; Harninder Rai <harninder.rai@nxp.com>; Raghav Dogra <raghav.dogra@nxp.com>; Ashish Kumar <ashish.kumar@nxp.com>; Andy Tang <andy.tang@nxp.com>; open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS <devicetree@vger.kernel.org>; linux-arm-kernel at lists.infradead.org; open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] arm64: dts: ls1088a: Add USB support

On Wed, Sep 13, 2017 at 05:10:09PM +0800, yinbo.zhu at nxp.com wrote:
> From: "yinbo.zhu" <yinbo.zhu@nxp.com>
> 
> Fix the issue that usb is not detected on ls1088ardb

>It's not really about fixing issue but adding support.

The patch had been tested on upstream 4.14 code, it can fix the issue. 
> 
> Signed-off-by: yinbo.zhu <yinbo.zhu@nxp.com>
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> ---

>You should better have a version history here to tell what's changed between version.

>I will add a version history on next v3 patch
Hi,

I had modified the code as v4 version, 
https://patchwork.kernel.org/patch/10027393/
please check.

Thanks,
BRs
>  arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts |  8 ++++++++
>  arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi    | 20 ++++++++++++++++++++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts 
> b/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
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

>Please sort these labeled nodes alphabetically.

>Shawn

>  	status = "okay";
>  };
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi 
> b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
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
