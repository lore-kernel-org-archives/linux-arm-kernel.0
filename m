From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 8 Sep 2016 14:18:18 +0100
Subject: [PATCH 3/7] [v2] arm64: dts: add QorIQ LS1046A SoC support
In-Reply-To: <20160908131326.GE26570@leverpostej>
References: <1473069695-33092-1-git-send-email-shh.xie@gmail.com>
 <1473069695-33092-4-git-send-email-shh.xie@gmail.com>
 <20160908131326.GE26570@leverpostej>
Message-ID: <20160908131818.GF26570@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 08, 2016 at 02:13:26PM +0100, Mark Rutland wrote:
> On Mon, Sep 05, 2016 at 06:01:31PM +0800, shh.xie at gmail.com wrote:
> > +	cpus {
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +
> > +		cpu0: cpu at 0 {
> > +			device_type = "cpu";
> > +			compatible = "arm,cortex-a72";
> > +			reg = <0x0>;
> > +			clocks = <&clockgen 1 0>;
> > +			next-level-cache = <&l2>;
> > +			cpu-idle-states = <&CPU_PH20>;
> > +		};
> 
> [...]
> 
> > +	};
> > +
> > +	idle-states {
> > +		entry-method = "arm,psci";
> > +
> > +		CPU_PH20: cpu-ph20 {
> > +			compatible = "arm,idle-state";
> > +			idle-state-name = "PH20";
> > +			arm,psci-suspend-param = <0x00010000>;
> > +			entry-latency-us = <1000>;
> > +			exit-latency-us = <1000>;
> > +			min-residency-us = <3000>;
> > +		};
> > +	};
> 
> There's no PSCI node in this file, and none from am included file, so
> this doesn't look right.

Looking again, none of the cpu nodes has an enable-method property, and
subsequent patches don't seem to add that to any cpu node.

Has this DT actually been tested?

Thanks,
Mark.
