From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 9 Sep 2016 22:04:35 +0200
Subject: [PATCH 12/13] arm64: dts: add Allwinner A64 SoC .dtsi
In-Reply-To: <c2334630-edab-5b42-48dd-5e4edd5f3de1@arm.com>
References: <20160726203041.29366-1-maxime.ripard@free-electrons.com>
 <20160726203041.29366-13-maxime.ripard@free-electrons.com>
 <c2334630-edab-5b42-48dd-5e4edd5f3de1@arm.com>
Message-ID: <20160909200435.GJ8881@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Sep 08, 2016 at 09:41:10AM +0100, Andre Przywara wrote:
> > +	timer {
> > +		compatible = "arm,armv8-timer";
> > +		interrupts = <GIC_PPI 13
> > +			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
> > +			     <GIC_PPI 14
> > +			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
> > +			     <GIC_PPI 11
> > +			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
> > +			     <GIC_PPI 10
> > +			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
> > +	};
> 
> Can you add a PMU node here? Or shall I send a patch on top of it?
> It would be:
> 
> 	pmu {
>         	compatible = "arm,cortex-a53-pmu", "arm,armv8-pmuv3";
> 		interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
> 			     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,	
> 			     <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
> 			     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
> 		interrupt-affinity = <&cpu0>,
> 				     <&cpu1>,
> 				     <&cpu2>,
> 				     <&cpu3>;
> 	};
> 
> This enables perf to use hardware counters (for cycles and instructions,
> for instance).
> 
> > +
> > +	clocks {
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		ranges;
> > +
> > +		osc24M: osc24M_clk {
> > +			#clock-cells = <0>;
> > +			compatible = "fixed-clock";
> > +			clock-frequency = <24000000>;
> > +			clock-output-names = "osc24M";
> > +		};
> > +
> > +		osc32k: osc32k_clk {
> > +			#clock-cells = <0>;
> > +			compatible = "fixed-clock";
> > +			clock-frequency = <32768>;
> > +			clock-output-names = "osc32k";
> > +		};
> > +	};
> 
> Can you remove this "clocks" node and put the two subnodes directly onto
> the top level?
> I know that putting clocks into a subnode is quite wide spread, but it
> does not represent any hardware hierarchy, especially in this
> fixed-clock case.
> So if we can (and it is easy here!) we should avoid any clocks subnode.
> 
> (Yes, I know that this was in my original DT as well, but Mark Rutland
> convinced me of this.)

I'll do those changes before sending the new version.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160909/87c052f4/attachment.sig>
