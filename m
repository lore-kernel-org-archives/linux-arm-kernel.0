From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri, 16 Nov 2018 09:53:42 +0100
Subject: [PATCH v5 1/3] arm64: dts: meson-gxl: add support for phicomm n1
In-Reply-To: <20181110033904.4207-2-yangxuan8282@gmail.com>
References: <20181110033904.4207-1-yangxuan8282@gmail.com>
 <20181110033904.4207-2-yangxuan8282@gmail.com>
Message-ID: <5974964f-e81a-8edd-23d1-f6a80185f9cc@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/11/2018 04:39, He Yangxuan wrote:
> This patch adds support for the Phicomm N1. This device based on P230 reference design.
> And this box doesn't have cvbs, so disable related section in device tree.
> 
> Signed-off-by: He Yangxuan <yangxuan8282@gmail.com>
> ---
>  arch/arm64/boot/dts/amlogic/Makefile                |  1 +
>  .../boot/dts/amlogic/meson-gxl-s905d-phicomm-n1.dts | 21 +++++++++++++++++++++
>  2 files changed, 22 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-phicomm-n1.dts
> 
> diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
> index c31f29d66..49f3ac5d8 100644
> --- a/arch/arm64/boot/dts/amlogic/Makefile
> +++ b/arch/arm64/boot/dts/amlogic/Makefile
> @@ -18,6 +18,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-nexbox-a95x.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-p212.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-p230.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-p231.dtb
> +dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-phicomm-n1.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s805x-p241.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905w-p281.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905w-tx3-mini.dtb
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-phicomm-n1.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-phicomm-n1.dts
> new file mode 100644
> index 000000000..9a8a8a7e4
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-phicomm-n1.dts
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2018 He Yangxuan
> + */
> +
> +/dts-v1/;
> +
> +#include "meson-gxl-s905d-p230.dts"
> +
> +/ {
> +	compatible = "phicomm,n1", "amlogic,s905d", "amlogic,meson-gxl";
> +	model = "Phicomm N1";
> +
> +	cvbs-connector {
> +		status = "disabled";
> +	};
> +};
> +
> +&cvbs_vdac_port {
> +	status = "disabled";
> +};
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
