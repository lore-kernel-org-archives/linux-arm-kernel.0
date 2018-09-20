From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 20 Sep 2018 09:54:35 +0200
Subject: [PATCH v4 2/2] arm64: dts: meson-g12a: add initial g12a s905d2
 SoC DT support
In-Reply-To: <1537427368-11104-3-git-send-email-jianxin.pan@amlogic.com>
References: <1537427368-11104-1-git-send-email-jianxin.pan@amlogic.com>
 <1537427368-11104-3-git-send-email-jianxin.pan@amlogic.com>
Message-ID: <c16ae8cf-5802-778b-1fd8-494dfb2d8d1b@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/09/2018 09:09, Jianxin Pan wrote:
> Try to add basic DT support for the Amlogic's Meson-G12A S905D2 SoC,
> which describe components as follows: Reserve Memory, CPU, GIC, IRQ,
> Timer, UART. It's capable of booting up into the serial console.
> 
> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
> Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  arch/arm64/boot/dts/amlogic/Makefile            |   1 +
>  arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts |  22 +++
>  arch/arm64/boot/dts/amlogic/meson-g12a.dtsi     | 172 ++++++++++++++++++++++++
>  3 files changed, 195 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
> 
> diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
> index a97c0e2..c31f29d6 100644
> --- a/arch/arm64/boot/dts/amlogic/Makefile
> +++ b/arch/arm64/boot/dts/amlogic/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  dtb-$(CONFIG_ARCH_MESON) += meson-axg-s400.dtb
> +dtb-$(CONFIG_ARCH_MESON) += meson-g12a-u200.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-nanopi-k2.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-nexbox-a95x.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-odroidc2.dtb
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
> new file mode 100644
> index 0000000..d267a37
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2018 Amlogic, Inc. All rights reserved.
> + */
> +
> +/dts-v1/;
> +
> +#include "meson-g12a.dtsi"
> +
> +/ {
> +	compatible = "amlogic,u200", "amlogic,g12a";
> +	model = "Amlogic Meson G12A U200 Development Board";
> +
> +	aliases {
> +		serial0 = &uart_AO;
> +	};

Hi Jianxin,

Please add the /memory and /chosen nodes.

+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory at 0 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x40000000>;
+	};

Thanks,
Neil


> +};
> +
> +&uart_AO {
> +	status = "okay";
> +};
> +
[...]
