From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 23 Jan 2017 14:13:31 +0000
Subject: [V2 2/2] arm64: dts: Add dts files for Hisilicon Hi3660 SoC
In-Reply-To: <1484034915-48879-2-git-send-email-puck.chen@hisilicon.com>
References: <1484034915-48879-1-git-send-email-puck.chen@hisilicon.com>
 <1484034915-48879-2-git-send-email-puck.chen@hisilicon.com>
Message-ID: <1f003ff0-656d-6d2f-20e3-9f9e7010e236@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/01/17 07:55, Chen Feng wrote:
> Add initial dtsi file to support Hisilicon Hi3660 SoC with
> support of Octal core CPUs in two clusters(4 * A53 & 4 * A73).
> 
> Also add dts file to support HiKey960 development board which
> based on Hi3660 SoC.
> The output console is earlycon "earlycon=pl011,0xfdf05000".
> And the con_init uart5 with a fixed clock, which already
> configured at bootloader.
> 
> When clock is available, the uart5 will be modified.
> 
> Tested on HiKey960 Board.
> 
> Signed-off-by: Chen Feng <puck.chen@hisilicon.com>
> ---
>  arch/arm64/boot/dts/hisilicon/Makefile            |   1 +
>  arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts |  34 +++++
>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi         | 156 ++++++++++++++++++++++
>  3 files changed, 191 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
>  create mode 100644 arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> 

> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> new file mode 100644
> index 0000000..7f9805c
> --- /dev/null
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> @@ -0,0 +1,156 @@
> +/*
> + * dts file for Hisilicon Hi3660 SoC
> + *
> + * Copyright (C) 2016, Hisilicon Ltd.
> + */
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
> +	compatible = "hisilicon,hi3660";
> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	psci {
> +		compatible = "arm,psci-0.2";
> +		method = "smc";
> +	};

[...]

> +
> +		cpu0: cpu at 0 {
> +			compatible = "arm,armv8";

You can add more specific compatibles as you mentioned this SoC contains
Cortex A53 & A73.

-- 
Regards,
Sudeep
