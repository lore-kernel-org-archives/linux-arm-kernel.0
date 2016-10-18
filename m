From: robh@kernel.org (Rob Herring)
Date: Tue, 18 Oct 2016 11:03:17 -0500
Subject: [RFC PATCH 1/3] ARM: dts: Add support for OX820 and Pogoplug V3
In-Reply-To: <20161017124001.23820-2-narmstrong@baylibre.com>
References: <20161017124001.23820-1-narmstrong@baylibre.com>
 <20161017124001.23820-2-narmstrong@baylibre.com>
Message-ID: <20161018160317.dscfcbhkywmy3c37@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 17, 2016 at 02:39:59PM +0200, Neil Armstrong wrote:
> Add device tree for the Oxford Seminconductor OX820 SoC and the
> Cloud Engines PogoPlug v3 board.
> Add the SoC and board compatible strings to oxnas bindings.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  Documentation/devicetree/bindings/arm/oxnas.txt    |   5 +
>  arch/arm/boot/dts/Makefile                         |   3 +-
>  .../boot/dts/cloudengines-pogoplug-series-3.dts    |  60 +++++
>  arch/arm/boot/dts/ox820.dtsi                       | 259 +++++++++++++++++++++
>  4 files changed, 326 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/cloudengines-pogoplug-series-3.dts
>  create mode 100644 arch/arm/boot/dts/ox820.dtsi
> 
> diff --git a/Documentation/devicetree/bindings/arm/oxnas.txt b/Documentation/devicetree/bindings/arm/oxnas.txt
> index b9e4971..ac64e60 100644
> --- a/Documentation/devicetree/bindings/arm/oxnas.txt
> +++ b/Documentation/devicetree/bindings/arm/oxnas.txt
> @@ -5,5 +5,10 @@ Boards with the OX810SE SoC shall have the following properties:
>    Required root node property:
>      compatible: "oxsemi,ox810se"
>  
> +Boards with the OX820 SoC shall have the following properties:
> +  Required root node property:
> +    compatible: "oxsemi,ox820"
> +
>  Board compatible values:
>    - "wd,mbwe" (OX810SE)
> +  - "cloudengines,pogoplugv3" (OX820)
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index faacd52..5d9e8d5 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -588,7 +588,8 @@ dtb-$(CONFIG_ARCH_ORION5X) += \
>  dtb-$(CONFIG_ARCH_PRIMA2) += \
>  	prima2-evb.dtb
>  dtb-$(CONFIG_ARCH_OXNAS) += \
> -	wd-mbwe.dtb
> +	wd-mbwe.dtb \
> +	cloudengines-pogoplug-series-3.dtb
>  dtb-$(CONFIG_ARCH_QCOM) += \
>  	qcom-apq8060-dragonboard.dtb \
>  	qcom-apq8064-arrow-sd-600eval.dtb \
> diff --git a/arch/arm/boot/dts/cloudengines-pogoplug-series-3.dts b/arch/arm/boot/dts/cloudengines-pogoplug-series-3.dts
> new file mode 100644
> index 0000000..78d9149
> --- /dev/null
> +++ b/arch/arm/boot/dts/cloudengines-pogoplug-series-3.dts
> @@ -0,0 +1,60 @@
> +/*
> + * cloudengines-pogoplug-series-3.dtsi - Device tree file for Cloud Engines PogoPlug Series 3
> + *
> + * Copyright (C) 2016 Neil Armstrong <narmstrong@baylibre.com>
> + *
> + * Licensed under GPLv2 or later
> + */
> +
> +/dts-v1/;
> +#include "ox820.dtsi"
> +
> +/ {
> +	model = "Cloud Engines PogoPlug Series 3";
> +
> +	compatible = "cloudengines,pogoplugv3", "oxsemi,ox820";
> +
> +	chosen {
> +		bootargs = "console=ttyS0,115200n8 earlyprintk=serial";

Use stdout-path and I don't think "earlyprintk=serial" is valid.

With that,

Acked-by: Rob Herring <robh@kernel.org>
