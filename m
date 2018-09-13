From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Fri, 14 Sep 2018 01:11:05 +0200
Subject: [PATCH] ARM: dts: aspeed: Adding Facebook TioagaPass BMC
In-Reply-To: <20180913195751.1833227-1-vijaykhemka@fb.com>
References: <20180913195751.1833227-1-vijaykhemka@fb.com>
Message-ID: <f71ea702-d500-aeed-a97c-6beca9818b4f@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vijay,

Am 13.09.18 um 21:57 schrieb Vijay Khemka:
> Initial introduction of Facebook TioagaPass family equipped with
> Aspeed 2500 BMC SoC. Neptune is a x86 server development kit
> with a ASPEED ast2500 BMC manufactured by Facebook.
> Specifically, This adds the tiogapass platform device tree file
> including the flash layout used by the tiogapass BMC machines.
> 
> This also adds an entry of tiogapass device tree file in Makefile
> as well an entry of Facebook in Documentation for vendor prefix
> 
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
> ---
>  .../devicetree/bindings/vendor-prefixes.txt   |   1 +
>  arch/arm/boot/dts/Makefile                    |   1 +
>  .../dts/aspeed-bmc-facebook-tiogapass.dts     | 152 ++++++++++++++++++
>  3 files changed, 154 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 2c3fc512e746..733b2d523642 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -127,6 +127,7 @@ everspin	Everspin Technologies, Inc.
>  exar	Exar Corporation
>  excito	Excito
>  ezchip	EZchip Semiconductor
> +facebook  Facebook

Indentation looks wrong?

>  fairphone	Fairphone B.V.
>  faraday	Faraday Technology Corporation
>  fastrax	Fastrax Oy

This addition should probably be in a patch with "dt-bindings:" subject
prefix, before adding the concrete .dts file using it.

> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index b5bd3de87c33..9c82c1681c38 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1206,4 +1206,5 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>  	aspeed-bmc-opp-witherspoon.dtb \
>  	aspeed-bmc-opp-zaius.dtb \
>  	aspeed-bmc-portwell-neptune.dtb \
> +	aspeed-bmc-facebook-tiogapass.dtb \
>  	aspeed-bmc-quanta-q71l.dtb
> diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
> new file mode 100644
> index 000000000000..859a00581e34
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
> @@ -0,0 +1,152 @@
> +// SPDX-License-Identifier: GPL-2.0

Note that the new SPDX name would be GPL-2.0-only to distinguish.
No "OR MIT"?

> +// Copyright (c) 2017 Facebook Inc.

No 2018?

> +/dts-v1/;
> +
> +#include "aspeed-g5.dtsi"
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +
> +/ {
> +	model = "Facebook TiogaPass BMC";
> +	compatible = "facebook,tiogapass-bmc", "aspeed,ast2500";
[snip]

There's some inconsistency between subject, commit message, filename and
compatibles of how this thing is actually called: Tioga or Tioaga?

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
