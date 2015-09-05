From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 5 Sep 2015 10:28:07 +0100
Subject: [PATCH 2/2] arm64: dts: add dts files for Hisilicon Hip05-D02
 Development Board
In-Reply-To: <1441421939-6236-3-git-send-email-dingtianhong@huawei.com>
References: <1441421939-6236-1-git-send-email-dingtianhong@huawei.com>
 <1441421939-6236-3-git-send-email-dingtianhong@huawei.com>
Message-ID: <20150905102807.18941767@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 5 Sep 2015 10:58:59 +0800
Ding Tianhong <dingtianhong@huawei.com> wrote:

> Add initial dtsi file to support Hisilicon Hip05-D02 Board with
> support of CPUs in four clusters and each cluster has quard Cortex-A57.
> 
> Also add dts file to support Hip05-D02 development board.
> 
> Signed-off-by: Ding Tianhong <dingtianhong@huawei.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  arch/arm64/boot/dts/hisilicon/Makefile      |   2 +-
>  arch/arm64/boot/dts/hisilicon/hip05-d02.dts |  36 ++++
>  arch/arm64/boot/dts/hisilicon/hip05.dtsi    | 271 ++++++++++++++++++++++++++++
>  3 files changed, 308 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/boot/dts/hisilicon/hip05-d02.dts
>  create mode 100644 arch/arm64/boot/dts/hisilicon/hip05.dtsi
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/Makefile b/arch/arm64/boot/dts/hisilicon/Makefile
> index fa81a6e..cd158b8 100644
> --- a/arch/arm64/boot/dts/hisilicon/Makefile
> +++ b/arch/arm64/boot/dts/hisilicon/Makefile
> @@ -1,4 +1,4 @@
> -dtb-$(CONFIG_ARCH_HISI) += hi6220-hikey.dtb
> +dtb-$(CONFIG_ARCH_HISI) += hi6220-hikey.dtb hip05-d02.dtb
>  
>  always		:= $(dtb-y)
>  subdir-y	:= $(dts-dirs)
> diff --git a/arch/arm64/boot/dts/hisilicon/hip05-d02.dts b/arch/arm64/boot/dts/hisilicon/hip05-d02.dts
> new file mode 100644
> index 0000000..ae34e25
> --- /dev/null
> +++ b/arch/arm64/boot/dts/hisilicon/hip05-d02.dts
> @@ -0,0 +1,36 @@
> +/**
> + * dts file for Hisilicon D02 Development Board
> + *
> + * Copyright (C) 2014,2015 Hisilicon Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * publishhed by the Free Software Foundation.
> + *
> + */
> +
> +/dts-v1/;
> +
> +#include "hip05.dtsi"
> +
> +/ {
> +	model = "Hisilicon Hip05 D02 Development Board";
> +	compatible = "hisilicon,hip05-d02";
> +
> +	memory at 00000000 {
> +		device_type = "memory";
> +		reg = <0x0 0x00000000 0x0 0x80000000>;
> +	};
> +
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +};
> +
> +&uart0 {
> +	status = "ok";
> +};
> diff --git a/arch/arm64/boot/dts/hisilicon/hip05.dtsi b/arch/arm64/boot/dts/hisilicon/hip05.dtsi
> new file mode 100644
> index 0000000..92d00f4
> --- /dev/null
> +++ b/arch/arm64/boot/dts/hisilicon/hip05.dtsi
> @@ -0,0 +1,271 @@
> +/**
> + * dts file for Hisilicon D02 Development Board
> + *
> + * Copyright (C) 2014,2015 Hisilicon Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * publishhed by the Free Software Foundation.
> + *
> + */
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
> +	compatible = "hisilicon,hip05-d02";
> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	psci {
> +		compatible = "arm,psci-0.2";
> +		method = "smc";
> +	};
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu-map {
> +			cluster0 {
> +				core0 {
> +					cpu = <&cpu0>;
> +				};
> +				core1 {
> +					cpu = <&cpu1>;
> +				};
> +				core2 {
> +					cpu = <&cpu2>;
> +				};
> +				core3 {
> +					cpu = <&cpu3>;
> +				};
> +			};
> +			cluster1 {
> +				core0 {
> +					cpu = <&cpu4>;
> +				};
> +				core1 {
> +					cpu = <&cpu5>;
> +				};
> +				core2 {
> +					cpu = <&cpu6>;
> +				};
> +				core3 {
> +					cpu = <&cpu7>;
> +				};
> +			};
> +			cluster2 {
> +				core0 {
> +					cpu = <&cpu8>;
> +				};
> +				core1 {
> +					cpu = <&cpu9>;
> +				};
> +				core2 {
> +					cpu = <&cpu10>;
> +				};
> +				core3 {
> +					cpu = <&cpu11>;
> +				};
> +			};
> +			cluster3 {
> +				core0 {
> +					cpu = <&cpu12>;
> +				};
> +				core1 {
> +					cpu = <&cpu13>;
> +				};
> +				core2 {
> +					cpu = <&cpu14>;
> +				};
> +				core3 {
> +					cpu = <&cpu15>;
> +				};
> +			};
> +		};
> +
> +		cpu0: cpu at 20000 {
> +			device_type = "cpu";
> +			compatible = "hisilicon,hip05", "arm,armv8";

Your cover letter says: "Hip05-D02 Development Board is based on
Cortex-A57". So "hisilicon,hip05" has nothing to do here. This should
read "arm,cortex-a57" (the SoC name is irrelevant for a cpu node).

Apparently I'm not the first one to mention that to you, so please
address this in your next version.

[...]

> +	gic: interrupt-controller at 8d000000 {
> +		compatible = "arm,gic-v3";
> +                #interrupt-cells = <3>;
> +                #address-cells = <2>;
> +                #size-cells = <2>;
> +                ranges;
> +                interrupt-controller;
> +                #redistributor-regions = <1>;
> +                redistributor-stride = <0x0 0x30000>;

Really? You redistributors are 192kB apart?

> +		reg = <0x0 0x8d000000 0 0x10000>,	/* GICD */
> +		      <0x0 0x8d100000 0 0x300000>,	/* GICR */
> +		      <0x0 0xfe000000 0 0x10000>,	/* GICC */
> +		      <0x0 0xfe010000 0 0x10000>,       /* GICH */
> +		      <0x0 0xfe020000 0 0x10000>;       /* GICV */
> +		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +
> +		its_totems: interrupt-controller at 8c000000 {
> +			compatible = "arm,gic-v3-its";
> +			msi-controller;
> +			reg = <0x0 0x8c000000 0x0 0x1000000>;

Why is the ITS region that big? It should normally only be 128kB.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
