From: shaohui.xie@nxp.com (S.H. Xie)
Date: Fri, 9 Sep 2016 09:00:26 +0000
Subject: [PATCH 3/7] [v2] arm64: dts: add QorIQ LS1046A SoC support
In-Reply-To: <57D1664D.3060502@arm.com>
References: <1473069695-33092-1-git-send-email-shh.xie@gmail.com>
 <1473069695-33092-4-git-send-email-shh.xie@gmail.com>
 <57D1664D.3060502@arm.com>
Message-ID: <DB5PR0401MB2183AF1CB29F26B41192F246E8FA0@DB5PR0401MB2183.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > +	timer {
> > +		compatible = "arm,armv8-timer";
> > +		interrupts = <GIC_PPI 13 IRQ_TYPE_EDGE_RISING>,
> > +			     <GIC_PPI 14 IRQ_TYPE_EDGE_RISING>,
> > +			     <GIC_PPI 11 IRQ_TYPE_EDGE_RISING>,
> > +			     <GIC_PPI 10 IRQ_TYPE_EDGE_RISING>;
> 
> No, this is completely wrong. The timer is always level triggered, and you're
> missing the affinity bits that are described the GIC binding.
[S.H] Will use (GIC_CPU_MASK_RAW(0xf) | IRQ_TYPE_LEVEL_LOW) in next version.

> 
> > +	};
> > +
> > +	pmu {
> > +		compatible = "arm,armv8-pmuv3";
> 
> Please add "arm,cortex-a72-pmu".
[S.H] Will use "arm,cortex-a72-pmu" in next version.

> 
> > +		interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
> > +			     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
> > +			     <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>,
> > +			     <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
> > +		interrupt-affinity = <&cpu0>,
> > +				     <&cpu1>,
> > +				     <&cpu2>,
> > +				     <&cpu3>;
> > +	};
> > +
> > +	gic: interrupt-controller at 1400000 {
> > +		compatible = "arm,gic-400";
> > +		#interrupt-cells = <3>;
> > +		interrupt-controller;
> > +		reg = <0x0 0x1410000 0 0x10000>, /* GICD */
> > +		      <0x0 0x1420000 0 0x20000>, /* GICC */
> > +		      <0x0 0x1440000 0 0x20000>, /* GICH */
> > +		      <0x0 0x1460000 0 0x20000>; /* GICV */
> > +		interrupts = <1 9 0xf08>;
> 
> Please choose between expressing the interrupts entirely with numerals or entirely
> with symbols. At the moment this is a mix between the two.
[S.H] Will fix it in next version.

Thank you!

Shaohui
