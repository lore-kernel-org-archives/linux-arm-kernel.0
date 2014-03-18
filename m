From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 18 Mar 2014 10:24:35 +0800
Subject: [PATCH v3 1/3] ARM: dts: berlin2q: add the Marvell Armada 1500 pro
In-Reply-To: <1395068788-19786-2-git-send-email-antoine.tenart@free-electrons.com>
References: <1395068788-19786-1-git-send-email-antoine.tenart@free-electrons.com>
 <1395068788-19786-2-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <20140318102435.2d29abc7@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Antoine,

On Mon, 17 Mar 2014 08:06:26 -0700
Antoine T?nart <antoine.tenart@free-electrons.com> wrote:

> Adds initial support for the Marvell Armada 1500 pro (BG2Q) SoC (Berlin
> family). The SoC has nodes for cpu, l2 cache controller, interrupt
> controllers, local timer, apb timers and uarts for now.
> 
> Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  arch/arm/boot/dts/berlin2q.dtsi | 210
> ++++++++++++++++++++++++++++++++++++++++ 1 file changed, 210 insertions(+)
>  create mode 100644 arch/arm/boot/dts/berlin2q.dtsi
> 
> diff --git a/arch/arm/boot/dts/berlin2q.dtsi
> b/arch/arm/boot/dts/berlin2q.dtsi new file mode 100644
> index 000000000000..7a50267b1044
> --- /dev/null
> +++ b/arch/arm/boot/dts/berlin2q.dtsi
> @@ -0,0 +1,210 @@
> +/*
> + * Copyright (C) 2014 Antoine T?nart <antoine.tenart@free-electrons.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +#include "skeleton.dtsi"
> +
> +/ {
> +	model = "Marvell Armada 1500 pro (BG2-Q) SoC";
> +	compatible = "marvell,berlin2q", "marvell,berlin";
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu at 0 {
> +			compatible = "arm,cortex-a9";
> +			device_type = "cpu";
> +			next-level-cache = <&l2>;
> +			reg = <0>;
> +		};
> +
> +		cpu at 1 {
> +			compatible = "arm,cortex-a9";
> +			device_type = "cpu";
> +			next-level-cache = <&l2>;
> +			reg = <1>;
> +		};
> +
> +		cpu at 2 {
> +			compatible = "arm,cortex-a9";
> +			device_type = "cpu";
> +			next-level-cache = <&l2>;
> +			reg = <2>;
> +		};
> +
> +		cpu at 3 {
> +			compatible = "arm,cortex-a9";
> +			device_type = "cpu";
> +			next-level-cache = <&l2>;
> +			reg = <3>;
> +		};
> +	};
> +
> +	smclk: sysmgr-clock {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <25000000>;
> +	};
> +
> +	cpuclk: cpu-clock {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <1200000000>;
> +	};
> +
> +	sysclk: system-clock {
> +		compatible = "fixed-factor-clock";
> +		#clock-cells = <0>;
> +		clocks = <&cpuclk>;
> +		clock-multi = <1>;
> +		clock-div = <3>;
> +	};

Can you please name it as twdclk to avoid confusion? On Berlin, sysclk is another
clk rather than the clk for twd. 
