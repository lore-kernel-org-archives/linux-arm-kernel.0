From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 16 Apr 2015 14:31:51 +0200
Subject: [PATCH 3/4] ARM: dts: UniPhier: add support for UniPhier SoCs
 and boards
In-Reply-To: <1429170038-16757-4-git-send-email-yamada.masahiro@socionext.com>
References: <1429170038-16757-1-git-send-email-yamada.masahiro@socionext.com>
 <1429170038-16757-4-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20150416123151.GF13105@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 16, 2015 at 04:40:37PM +0900, Masahiro Yamada wrote:
> Initial device trees for UniPhier SoCs: PH1-sLD3, PH1-LD4, PH1-Pro4,
> and PH1-sLD8.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  arch/arm/boot/dts/Makefile                   |  5 ++
>  arch/arm/boot/dts/uniphier-ph1-ld4-ref.dts   | 51 +++++++++++++++++
>  arch/arm/boot/dts/uniphier-ph1-ld4.dtsi      | 78 +++++++++++++++++++++++++
>  arch/arm/boot/dts/uniphier-ph1-pro4-ref.dts  | 51 +++++++++++++++++
>  arch/arm/boot/dts/uniphier-ph1-pro4.dtsi     | 85 ++++++++++++++++++++++++++++
>  arch/arm/boot/dts/uniphier-ph1-sld3-ref.dts  | 52 +++++++++++++++++
>  arch/arm/boot/dts/uniphier-ph1-sld3.dtsi     | 85 ++++++++++++++++++++++++++++
>  arch/arm/boot/dts/uniphier-ph1-sld8-ref.dts  | 51 +++++++++++++++++
>  arch/arm/boot/dts/uniphier-ph1-sld8.dtsi     | 78 +++++++++++++++++++++++++
>  arch/arm/boot/dts/uniphier-support-card.dtsi | 39 +++++++++++++
>  10 files changed, 575 insertions(+)
>  create mode 100644 arch/arm/boot/dts/uniphier-ph1-ld4-ref.dts
>  create mode 100644 arch/arm/boot/dts/uniphier-ph1-ld4.dtsi
>  create mode 100644 arch/arm/boot/dts/uniphier-ph1-pro4-ref.dts
>  create mode 100644 arch/arm/boot/dts/uniphier-ph1-pro4.dtsi
>  create mode 100644 arch/arm/boot/dts/uniphier-ph1-sld3-ref.dts
>  create mode 100644 arch/arm/boot/dts/uniphier-ph1-sld3.dtsi
>  create mode 100644 arch/arm/boot/dts/uniphier-ph1-sld8-ref.dts
>  create mode 100644 arch/arm/boot/dts/uniphier-ph1-sld8.dtsi
>  create mode 100644 arch/arm/boot/dts/uniphier-support-card.dtsi
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index a1c776b..d639a90 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -588,6 +588,11 @@ dtb-$(CONFIG_ARCH_U8500) += \
>  	ste-hrefv60plus-tvk.dtb \
>  	ste-ccu8540.dtb \
>  	ste-ccu9540.dtb
> +dtb-$(CONFIG_ARCH_UNIPHIER) += \
> +	uniphier-ph1-sld3-ref.dtb \
> +	uniphier-ph1-ld4-ref.dtb \
> +	uniphier-ph1-pro4-ref.dtb \
> +	uniphier-ph1-sld8-ref.dtb
>  dtb-$(CONFIG_ARCH_VERSATILE) += \
>  	versatile-ab.dtb \
>  	versatile-pb.dtb
> diff --git a/arch/arm/boot/dts/uniphier-ph1-ld4-ref.dts b/arch/arm/boot/dts/uniphier-ph1-ld4-ref.dts
> new file mode 100644
> index 0000000..2e83363
> --- /dev/null
> +++ b/arch/arm/boot/dts/uniphier-ph1-ld4-ref.dts
> @@ -0,0 +1,51 @@
> +/*
> + * Device Tree Source for UniPhier PH1-LD4 Reference Board
> + *
> + * Copyright (C) 2015 Socionext Inc.
> + *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */

Hi Masahiro

There is a growing trend to license DT files dual GPL and X11. Having
the X11 license can help with bootloaders also using the device tree
files.

Please spend some time researching the issue and consider it.

Thanks
	Andrew
