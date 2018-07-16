From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 16 Jul 2018 15:24:44 +0200
Subject: [PATCH v2 2/2] arm64: dts: Add Mediatek X20 Development Board
 support
In-Reply-To: <20180605163442.4812-3-manivannan.sadhasivam@linaro.org>
References: <20180605163442.4812-1-manivannan.sadhasivam@linaro.org>
 <20180605163442.4812-3-manivannan.sadhasivam@linaro.org>
Message-ID: <d88504b4-409c-c42b-f816-bedefce2a819@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Manivanna,

On 05/06/18 18:34, Manivannan Sadhasivam wrote:
> Add initial device tree support for Mediatek X20 Development Board
> based on MT6797 Deca core SoC. This board is one of the 96Boards
> Consumer Edition platform.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  arch/arm64/boot/dts/mediatek/Makefile         |  1 +
>  .../boot/dts/mediatek/mt6797-x20-dev.dts      | 33 +++++++++++++++++++
>  2 files changed, 34 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts
> 
> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
> index ac17f60f998c..5b7fd6ad96e4 100644
> --- a/arch/arm64/boot/dts/mediatek/Makefile
> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> @@ -3,5 +3,6 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt2712-evb.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt6755-evb.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt6795-evb.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-evb.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-x20-dev.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-rfb1.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-evb.dtb
> diff --git a/arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts b/arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts
> new file mode 100644
> index 000000000000..2c09ca95d9e2
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts
> @@ -0,0 +1,33 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device Tree Source for MediaTek X20 Development Board
> + *
> + * Copyright (C) 2018, Linaro Ltd.
> + *
> + */
> +
> +/dts-v1/;
> +
> +#include "mt6797.dtsi"
> +
> +/ {
> +	model = "Mediatek X20 Development Board";
> +	compatible = "archermind,mt6797-x20-dev", "mediatek,mt6797";
> +
> +	aliases {
> +		serial0 = &uart1;
> +	};

Sorry for the late answer.
Why did you use uart1 instead of uart0?
I know that uart0 is used by the bootloader, but because of their exotic flash
procedure I find it quite useful to see this messages in my serial connection.
Of course you can only use 921600 baudrate then.

> +
> +	memory at 40000000 {
> +		device_type = "memory";
> +		reg = <0 0x40000000 0 0x1e605000>;

How comes this strange number for the memory size?

BTW do you know the differences between the EVB board and the x20 one?
I used the evb dts for booting up to now.

Best regards,
Matthias

> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +};
> +
> +&uart1 {
> +	status = "okay";
> +};
> 
