From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 4 Nov 2018 12:19:34 +0800
Subject: [PATCH v2 1/2] arm64: dts: Add support for NXP LS1028A SoC
In-Reply-To: <AM6PR04MB4407CDF0EC1DE0442CF205508CCF0@AM6PR04MB4407.eurprd04.prod.outlook.com>
References: <1539760132-3386-1-git-send-email-Bhaskar.Upadhaya@nxp.com>
 <20181031071413.GI10386@tiger>
 <AM6PR04MB4407CDF0EC1DE0442CF205508CCF0@AM6PR04MB4407.eurprd04.prod.outlook.com>
Message-ID: <20181104041931.GB6093@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 02, 2018 at 09:51:49AM +0000, Bhaskar Upadhaya wrote:
> 
> 
> >-----Original Message-----
> >From: Shawn Guo <shawnguo@kernel.org>
> >Sent: Wednesday, October 31, 2018 12:44 PM
> >To: Bhaskar Upadhaya <bhaskar.upadhaya@nxp.com>
> >Cc: devicetree at vger.kernel.org; Harninder Rai <harninder.rai@nxp.com>;
> >Sudhanshu Gupta <sudhanshu.gupta@nxp.com>; Rajesh Bhagat
> ><rajesh.bhagat@nxp.com>; linux-arm-kernel at lists.infradead.org; Leo Li
> ><leoyang.li@nxp.com>
> >Subject: Re: [PATCH v2 1/2] arm64: dts: Add support for NXP LS1028A SoC
> >> +	compatible = "fsl,ls1028a";
> >> +	interrupt-parent = <&gic>;
> >> +	#address-cells = <2>;
> >> +	#size-cells = <2>;
> >> +
> >> +	cpus {
> >> +		#address-cells = <1>;
> >> +		#size-cells = <0>;
> >> +
> >> +		cpu0: cpu at 0 {
> >> +			device_type = "cpu";
> >> +			compatible = "arm,cortex-a72";
> >> +			reg = <0x0>;
> >> +			enable-method = "psci";
> >> +			clocks = <&clockgen 1 0>;
> >> +			next-level-cache = <&l2>;
> >> +			cpu-idle-states = <&CPU_PH20>;
> >> +		};
> >> +
> >> +		cpu1: cpu at 1 {
> >> +			device_type = "cpu";
> >> +			compatible = "arm,cortex-a72";
> >> +			reg = <0x1>;
> >> +			enable-method = "psci";
> >> +			clocks = <&clockgen 1 0>;
> >> +			next-level-cache = <&l2>;
> >> +			cpu-idle-states = <&CPU_PH20>;
> >> +		};
> >> +
> >> +		l2: l2-cache {
> >> +			compatible = "cache";
> >> +		};
> >
> >Not sure what's the point of this node without any properties.
> 
> Shawn, I looked into the NXP and non-NXP platforms, but all are creating cache nodes with "compatible" being the only property.

Okay, just noticed that the node is referred by next-level-cache
property of cpu node.  So I guess this 'dummy' cache node is there only
for architectural integrity/sanity check or something.

Shawn
