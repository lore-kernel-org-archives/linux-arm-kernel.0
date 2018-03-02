From: robh@kernel.org (Rob Herring)
Date: Fri, 2 Mar 2018 12:06:42 -0600
Subject: [PATCH v2 6/8] arm64: zynqmp: Add support for Xilinx zcu111-revA
In-Reply-To: <db4b958c2280352939de0e7e55bc00d416b694e9.1519396753.git.michal.simek@xilinx.com>
References: <cover.1519396753.git.michal.simek@xilinx.com>
 <db4b958c2280352939de0e7e55bc00d416b694e9.1519396753.git.michal.simek@xilinx.com>
Message-ID: <20180302180642.vctexdelz6z7h6cq@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 23, 2018 at 03:40:28PM +0100, Michal Simek wrote:
> Xilinx zcu111 is a customer board. It is reusing some parts from zcu102.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
> Changes in v2:
> - Remove i2c mw u-boot commands
> - Use i2c-mux instead of i2cswitch
> - Use clock generator without numbers.
> - Record compatible string to xilinx.txt
> 
>  Documentation/devicetree/bindings/arm/xilinx.txt  |   3 +
>  arch/arm64/boot/dts/xilinx/Makefile               |   1 +
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts | 446 ++++++++++++++++++++++
>  3 files changed, 450 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
> 
> diff --git a/Documentation/devicetree/bindings/arm/xilinx.txt b/Documentation/devicetree/bindings/arm/xilinx.txt
> index 8503fabf90ee..c2bc75774010 100644
> --- a/Documentation/devicetree/bindings/arm/xilinx.txt
> +++ b/Documentation/devicetree/bindings/arm/xilinx.txt
> @@ -32,3 +32,6 @@ Additional compatible strings:
>  
>  - Xilinx evaluation board zcu106
>    "xlnx,zynqmp-zcu106-revA", "xlnx,zynqmp-zcu106"
> +
> +- Xilinx evaluation board zcu111
> +  "xlnx,zynqmp-zcu111-revA", "xlnx,zynqmp-zcu111"
> diff --git a/arch/arm64/boot/dts/xilinx/Makefile b/arch/arm64/boot/dts/xilinx/Makefile
> index 922c5da39600..d15c9dc1d8f2 100644
> --- a/arch/arm64/boot/dts/xilinx/Makefile
> +++ b/arch/arm64/boot/dts/xilinx/Makefile
> @@ -6,3 +6,4 @@ dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu102-revB.dtb
>  dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu102-rev1.0.dtb
>  dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu104-revA.dtb
>  dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu106-revA.dtb
> +dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu111-revA.dtb
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
> new file mode 100644
> index 000000000000..f07f6dafb417
> --- /dev/null
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
> @@ -0,0 +1,446 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * dts file for Xilinx ZynqMP ZCU111
> + *
> + * (C) Copyright 2017 - 2018, Xilinx, Inc.
> + *
> + * Michal Simek <michal.simek@xilinx.com>
> + */
> +
> +/dts-v1/;
> +
> +#include "zynqmp.dtsi"
> +#include "zynqmp-clk.dtsi"
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/gpio/gpio.h>
> +
> +/ {
> +	model = "ZynqMP ZCU111 RevA";
> +	compatible = "xlnx,zynqmp-zcu111-revA", "xlnx,zynqmp-zcu111", "xlnx,zynqmp";
> +
> +	aliases {
> +		ethernet0 = &gem3;
> +		gpio0 = &gpio;
> +		i2c0 = &i2c0;
> +		i2c1 = &i2c1;
> +		mmc0 = &sdhci1;
> +		rtc0 = &rtc;
> +		serial0 = &uart0;
> +		serial1 = &dcc;
> +		usb0 = &usb0;

And here too.

Reviewed-by: Rob Herring <robh@kernel.org>
