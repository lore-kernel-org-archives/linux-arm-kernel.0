From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 5 Jan 2017 13:58:37 +0000
Subject: [PATCHv2 4/5] arm: mvebu: Add device tree for 98DX3236 SoCs
In-Reply-To: <20170105033641.6212-5-chris.packham@alliedtelesis.co.nz>
References: <20170105033641.6212-1-chris.packham@alliedtelesis.co.nz>
 <20170105033641.6212-5-chris.packham@alliedtelesis.co.nz>
Message-ID: <20170105135837.GC25333@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 05, 2017 at 04:36:40PM +1300, Chris Packham wrote:
> +		internal-regs {
> +			coreclk: mvebu-sar at 18230 {
> +				compatible = "marvell,mv98dx3236-core-clock";
> +			};
> +
> +			cpuclk: clock-complex at 18700 {
> +				compatible = "marvell,mv98dx3236-cpu-clock";
> +			};
> +
> +			corediv-clock at 18740 {
> +				compatible = "marvell,mv98dx3236-corediv-clock";
> +				reg = <0xf8268 0xc>;
> +				base = <&dfx>;
> +				#clock-cells = <1>;
> +				clocks = <&mainpll>;
> +				clock-output-names = "nand";
> +			};

[...]

> +		};
> +
> +		dfx-registers {
> +			compatible = "simple-bus";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0 MBUS_ID(0x08, 0x00) 0 0x100000>;
> +
> +			dfx: dfx at 0 {
> +				compatible = "simple-bus";
> +				reg = <0 0x100000>;
> +			};
> +		};

What is this dfx-registers, exactly? It has no children, so why is it a
simple-bus?

>From the above, and the patch adding the corediv driver, it looks like
the corediv-clock actually lives in this block, so I don't understand
why the corediv-clock is sitting in internal-regs with a sideband
reference to dfx.

Thanks,
Mark.
