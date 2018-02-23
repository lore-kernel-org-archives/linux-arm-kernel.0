From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 23 Feb 2018 16:20:38 +0100
Subject: [PATCH v3 6/7] arm64: allwinner: h6: add the basical Allwinner
 H6 DTSI file
In-Reply-To: <20180223123555.64009-7-icenowy@aosc.io>
References: <20180223123555.64009-6-icenowy@aosc.io>
 <20180223123555.64009-7-icenowy@aosc.io>
Message-ID: <20180223152038.2bflylwa6vj4gzfj@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 23, 2018 at 08:35:54PM +0800, Icenowy Zheng wrote:
> Allwinner H6 is a new SoC with Cortex-A53 cores from Allwinner, with its
> memory map fully reworked and some high-speed peripherals (PCIe, USB
> 3.0) introduced.
> 
> This commit adds the basical DTSI file of it, including the clock
> support and UART support.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>
> ---
> Changes in v3:
> - SPDX license identifier fix.
> 
> Changes in v2:
> - Add APB1 clock as PIO's APB clock.
> - Switched to SPDX license identifier.
> 
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 177 +++++++++++++++++++++++++++
>  1 file changed, 177 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> new file mode 100644
> index 000000000000..4a6236bd9778
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> @@ -0,0 +1,177 @@
> +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> +/*
> + * Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.io>
> + */
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/clock/sun50i-h6-ccu.h>
> +#include <dt-bindings/reset/sun50i-h6-ccu.h>
> +
> +/ {
> +	interrupt-parent = <&gic>;
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu0: cpu at 0 {
> +			compatible = "arm,cortex-a53", "arm,armv8";
> +			device_type = "cpu";
> +			reg = <0>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu1: cpu at 1 {
> +			compatible = "arm,cortex-a53", "arm,armv8";
> +			device_type = "cpu";
> +			reg = <1>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu2: cpu at 2 {
> +			compatible = "arm,cortex-a53", "arm,armv8";
> +			device_type = "cpu";
> +			reg = <2>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu3: cpu at 3 {
> +			compatible = "arm,cortex-a53", "arm,armv8";
> +			device_type = "cpu";
> +			reg = <3>;
> +			enable-method = "psci";
> +		};
> +	};
> +
> +	iosc: internal-osc-clk {
> +		#clock-cells = <0>;
> +		compatible = "fixed-clock";
> +		clock-frequency = <16000000>;
> +		clock-accuracy = <300000000>;
> +		clock-output-names = "iosc";
> +	};

You're not using it anywhere

> +	osc24M: osc24M_clk {
> +		#clock-cells = <0>;
> +		compatible = "fixed-clock";
> +		clock-frequency = <24000000>;
> +		clock-output-names = "osc24M";
> +	};
> +
> +	osc32k: osc32k_clk {
> +		#clock-cells = <0>;
> +		compatible = "fixed-clock";
> +		clock-frequency = <32768>;
> +		clock-output-names = "osc32k";
> +	};
> +
> +	psci {
> +		compatible = "arm,psci-0.2";
> +		method = "smc";
> +	};

Is it needed? The bootloader should fill it with whatever version it
has, shouldn't it?

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180223/5a314a9f/attachment.sig>
