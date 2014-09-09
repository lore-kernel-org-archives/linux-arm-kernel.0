From: kgene@kernel.org (kgene at kernel.org)
Date: Tue, 09 Sep 2014 12:28:37 +0900
Subject: [PATCH v2 5/7] arm64: dts: Add initial device tree support for
 EXYNOS7
In-Reply-To: <1409672143-8574-6-git-send-email-ch.naveen@samsung.com>
References: <1409672143-8574-1-git-send-email-ch.naveen@samsung.com>
 <1409672143-8574-6-git-send-email-ch.naveen@samsung.com>
Message-ID: <02f801cfcbde$24a40160$6dec0420$@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Naveen Krishna Chatradhi wrote:
> 
> Add initial device tree nodes for EXYNOS7 SoC and board dts file
> to support Espresso board based on Exynos7 SoC.
> 
> Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  arch/arm64/boot/dts/Makefile                    |    1 +
>  arch/arm64/boot/dts/exynos/exynos7-espresso.dts |   31 +++++
>  arch/arm64/boot/dts/exynos/exynos7.dtsi         |  168 +++++++++++++++++++++++
>  3 files changed, 200 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/exynos/exynos7-espresso.dts
>  create mode 100644 arch/arm64/boot/dts/exynos/exynos7.dtsi

[...]

> diff --git a/arch/arm64/boot/dts/exynos/exynos7.dtsi b/arch/arm64/boot/dts/exynos/exynos7.dtsi
> new file mode 100644
> index 0000000..e593af55
> --- /dev/null
> +++ b/arch/arm64/boot/dts/exynos/exynos7.dtsi
> @@ -0,0 +1,168 @@
> +/*
> + * SAMSUNG EXYNOS7 SoC device tree source
> + *
> + * Copyright (c) 2014 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <dt-bindings/clock/exynos7-clk.h>
> +
> +/ {
> +	compatible = "samsung,exynos7";
> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;

+	#address-cells = <1>; ?

Hmm...I can't see any 64-bit address here.

> +	#size-cells = <2>;
> +

[...]

> +
> +	soc: soc {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0 0 0 0x18000000>;
> +
> +		chipid at 10000000 {
> +			compatible = "samsung,exynos4210-chipid";
> +			reg = <0x10000000 0x100>;
> +		};

Maybe this is not required? There is no check chipid in arm/arm64.

[...]

> +		timer {
> +			compatible = "arm,armv8-timer";
> +			interrupts = <1 13 0xff01>,
> +				     <1 14 0xff01>,
> +				     <1 11 0xff01>,
> +				     <1 10 0xff01>;

clock-frequency ?

[...]

- Kukjin
