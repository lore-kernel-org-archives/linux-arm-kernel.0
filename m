From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 13 Nov 2015 11:15:00 +0000
Subject: Conditionals in dtsi files
In-Reply-To: <5151887.Q3EmlRO4WY@wuerfel>
References: <5645AE7E.4090003@free.fr>
 <5151887.Q3EmlRO4WY@wuerfel>
Message-ID: <20151113111459.GA22469@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 13, 2015 at 10:43:11AM +0100, Arnd Bergmann wrote:
> On Friday 13 November 2015 10:33:50 Mason wrote:
> > Hello,
> > 
> > I'm wondering how much C preprocessor syntax one can use in DT files.
> > 
> > Suppose I have 2 board DTS (both including common.dtsi)
> > 
> > board_A.dts (1-core), board_B.dts (2-core)
> > 
> > Can I have in common.dtsi something along these lines:
> > 
> > 	cpus {
> > 		enable-method = "foo,bar";
> > 		#address-cells = <1>;
> > 		#size-cells = <0>;
> > 
> > 		cpu0: cpu at 0 {
> > 			compatible = "arm,cortex-a9";
> > 			device_type = "cpu";
> > 			reg = <0>;
> > 		};
> > 
> > #if CORE_COUNT > 1
> > 		cpu1: cpu at 1 {
> > 			compatible = "arm,cortex-a9";
> > 			device_type = "cpu";
> > 			reg = <1>;
> > 		};
> > #endif
> > 	};
> > 
> > 
> > board_A.dts would have
> > #define CORE_COUNT 1
> > #include "common.dtsi"
> > 
> > board_B.dts would have
> > #define CORE_COUNT 2
> > #include "common.dtsi"
> 
> I would prefer not using any preprocessor statements other than
> #include in .dts files.

I very much agree with this.

We should only have (simple) macros for symbolic names, and #includes
required for those to work.

Thanks,
Mark.
