From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 19 Oct 2014 09:37:02 +0800
Subject: [PATCHv5 1/6] ARM: dts: Add SoC level device tree support for
 LS1021A
In-Reply-To: <1413192963-11153-2-git-send-email-jingchang.lu@freescale.com>
References: <1413192963-11153-1-git-send-email-jingchang.lu@freescale.com>
 <1413192963-11153-2-git-send-email-jingchang.lu@freescale.com>
Message-ID: <20141019013701.GC7869@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 13, 2014 at 05:35:58PM +0800, Jingchang Lu wrote:
> +/ {
> +	compatible = "fsl,ls1021a";
> +	interrupt-parent = <&gic>;
> +
> +	aliases {
> +		serial0 = &lpuart0;
> +		serial1 = &lpuart1;
> +		serial2 = &lpuart2;
> +		serial3 = &lpuart3;
> +		serial4 = &lpuart4;
> +		serial5 = &lpuart5;
> +		sysclk = &sysclk;

What is this sysclk aliase used for?

> +		};

Bad indent.

> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu at f00 {
> +			compatible = "arm,cortex-a7";
> +			device_type = "cpu";
> +			reg = <0xf00>;
> +		};
> +
> +		cpu at f01 {
> +			compatible = "arm,cortex-a7";
> +			device_type = "cpu";
> +			reg = <0xf01>;
> +		};
> +	};
> +
> +	timer {
> +		compatible = "arm,armv7-timer";
> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;

I like this indent style ...

> +	};
> +
> +	pmu {
> +		compatible = "arm,cortex-a7-pmu";
> +		interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>,
> +				<GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;

... not this style.  Please fix such indents through the file.

> +	};

Shawn
