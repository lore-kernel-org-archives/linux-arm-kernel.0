From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 23 Apr 2013 14:12:15 +0100
Subject: [PATCH V2 4/4] arm64: Add initial DTS for APM X-Gene Storm SOC
 and APM Mustang board
In-Reply-To: <1366712759-3431-5-git-send-email-vkale@apm.com>
References: <1366712759-3431-1-git-send-email-vkale@apm.com>
 <1366712759-3431-5-git-send-email-vkale@apm.com>
Message-ID: <20130423131215.GB28663@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Apr 23, 2013 at 11:25:59AM +0100, Vinayak Kale wrote:
> This patch adds initial DTS files required for APM Mustang board.
> 
> Signed-off-by: Kumar Sankaran <ksankaran@apm.com>
> Signed-off-by: Loc Ho <lho@apm.com>
> Signed-off-by: Feng Kan <fkan@apm.com>
> ---
>  arch/arm64/boot/dts/Makefile        |    1 +
>  arch/arm64/boot/dts/apm-mustang.dts |   27 ++++++++
>  arch/arm64/boot/dts/apm-storm.dtsi  |  116 +++++++++++++++++++++++++++++++++++
>  3 files changed, 144 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/apm-mustang.dts
>  create mode 100644 arch/arm64/boot/dts/apm-storm.dtsi
> 
> diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
> index 68457e9..c52bdb0 100644
> --- a/arch/arm64/boot/dts/Makefile
> +++ b/arch/arm64/boot/dts/Makefile
> @@ -1,4 +1,5 @@
>  dtb-$(CONFIG_ARCH_VEXPRESS) += rtsm_ve-aemv8a.dtb foundation-v8.dtb
> +dtb-$(CONFIG_ARCH_XGENE) += apm-mustang.dtb
>  
>  targets += dtbs
>  targets += $(dtb-y)
> diff --git a/arch/arm64/boot/dts/apm-mustang.dts b/arch/arm64/boot/dts/apm-mustang.dts
> new file mode 100644
> index 0000000..625322c
> --- /dev/null
> +++ b/arch/arm64/boot/dts/apm-mustang.dts
> @@ -0,0 +1,27 @@
> +/*
> + * dts file for AppliedMicro (APM) Mustang Board
> + *
> + * Copyright (C) 2013, Applied Micro Circuits Corporation
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + */
> +
> +/dts-v1/;
> +
> +/include/ "apm-storm.dtsi"
> +
> +/ {
> +	model = "mustang";
> +
> +	chosen {
> +		linux,stdout-path = &serial0;
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = < 0x1 0x00000000 0x0 0x80000000 >; /* Updated by bootloader */
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/apm-storm.dtsi b/arch/arm64/boot/dts/apm-storm.dtsi
> new file mode 100644
> index 0000000..d3f3f5d
> --- /dev/null
> +++ b/arch/arm64/boot/dts/apm-storm.dtsi
> @@ -0,0 +1,116 @@
> +/*
> + * dts file for AppliedMicro (APM) X-Gene Storm SOC
> + *
> + * Copyright (C) 2013, Applied Micro Circuits Corporation
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + */
> +
> +/ {
> +	compatible = "apm,xgene,storm", "apm,xgene";
> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	cpus {
> +		#address-cells = <2>;
> +		#size-cells = <0>;
> +
> +		cpu at 000 {
> +			device_type = "cpu";
> +			compatible = "apm,xgene", "arm,armv8";

You've used the "apm,xgene" compatible string for both the CPU and the board.

In PATCH 3, you added APM_CPU_PART_POTENZA, so presumably "apm,potenza" makes
more sense as the CPU compatible string?

Thanks,
Mark.
