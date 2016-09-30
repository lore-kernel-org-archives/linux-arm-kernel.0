From: leoyang.li@nxp.com (Leo Li)
Date: Fri, 30 Sep 2016 21:29:35 +0000
Subject: [linux-devel] [PATCH v2 1/1] arm64: Add DTS support for FSL's
 LS1012A SoC
In-Reply-To: <AM4PR0401MB2275E76A1EC44FE6DA19D4978CC10@AM4PR0401MB2275.eurprd04.prod.outlook.com>
References: <1472207241-18461-1-git-send-email-Bhaskar.Upadhaya@nxp.com>
 <VI1PR0401MB2638C032B77C9313C17BBE898DC10@VI1PR0401MB2638.eurprd04.prod.outlook.com>
 <AM4PR0401MB2275E76A1EC44FE6DA19D4978CC10@AM4PR0401MB2275.eurprd04.prod.outlook.com>
Message-ID: <AM2PR04MB077066631548C36D7C564EF28FC10@AM2PR04MB0770.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: linux-devel-bounces at gforge.freescale.net [mailto:linux-devel-
> bounces at gforge.freescale.net] On Behalf Of Bhaskar U
> Sent: Friday, September 30, 2016 4:19 PM
> To: Stuart Yoder <stuart.yoder@nxp.com>; devicetree at vger.kernel.org;
> shawnguo at kernel.org
> Cc: oss at buserror.net; linux-devel at gforge.freescale.net; Pratiyush Srivastava
> <pratiyush.srivastava@nxp.com>; Prabhakar Kushwaha
> <prabhakar.kushwaha@nxp.com>; linux-arm-kernel at lists.infradead.org
> Subject: Re: [linux-devel] [PATCH v2 1/1] arm64: Add DTS support for FSL's
> LS1012A SoC
> 
> 
> 
> >-----Original Message-----
> >From: Stuart Yoder
> >Sent: Friday, September 30, 2016 7:28 PM
> >To: Bhaskar U <bhaskar.upadhaya@nxp.com>; devicetree at vger.kernel.org;
> >shawnguo at kernel.org
> >Cc: oss at buserror.net; linux-arm-kernel at lists.infradead.org; linux-
> >devel at gforge.freescale.net; Bhaskar U <bhaskar.upadhaya@nxp.com>;
> >Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>; Pratiyush Srivastava
> ><pratiyush.srivastava@nxp.com>
> >Subject: RE: [PATCH v2 1/1] arm64: Add DTS support for FSL's LS1012A
> >SoC
> >
> >> +		dspi0: dspi at 2100000 {
> >> +			compatible = "fsl,ls1012a-dspi",
> >> +				     "fsl,ls1043a-dspi",
> >> +				     "fsl,ls1021a-v1.0-dspi";
> >> +			#address-cells = <1>;
> >> +			#size-cells = <0>;
> >> +			reg = <0x0 0x2100000 0x0 0x10000>;
> >> +			interrupts = <0 64 0x4>;
> >> +			clock-names = "dspi";
> >> +			clocks = <&clockgen 4 0>;
> >> +			spi-num-chipselects = <5>;
> >> +			big-endian;
> >> +			status = "enabled";
> >
> >"enabled" is not a valid status value.
> >
> 
> So shall I put the status = "okay" ?
> 
> But there are other nodes like i2c below having status = "enabled", so do we
> need to edit them also ? If yes then what should be written in the status ?
> i2c0: i2c at 2180000 {
>                         compatible = "fsl,vf610-i2c";
>                         #address-cells = <1>;
>                         #size-cells = <0>;
>                         reg = <0x0 0x2180000 0x0 0x10000>;
>                         interrupts = <0 56 0x4>;
>                         clock-names = "i2c";
>                         clocks = <&clockgen 4 0>;
>                         status = "enabled";
>                 };
> 
>                 i2c1: i2c at 2190000 {
>                         compatible = "fsl,vf610-i2c";
>                         #address-cells = <1>;
>                         #size-cells = <0>;
>                         reg = <0x0 0x2190000 0x0 0x10000>;
>                         interrupts = <0 57 0x4>;
>                         clock-names = "i2c";
>                         clocks = <&clockgen 4 0>;
>                         status = "enabled";
>                 };

The default is "okay".  You should just remove these status properties.

Regards,
Leo
