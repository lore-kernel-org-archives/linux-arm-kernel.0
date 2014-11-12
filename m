From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Wed, 12 Nov 2014 12:41:47 +0100
Subject: [PATCH v5 2/3] ARM: mediatek: add dts for mt6592-evb
In-Reply-To: <1415678111-29914-2-git-send-email-ibanezchen@gmail.com>
References: <1415678111-29914-1-git-send-email-ibanezchen@gmail.com>
 <1415678111-29914-2-git-send-email-ibanezchen@gmail.com>
Message-ID: <CABuKBeKTA1Ugf50ZhLOanXFs_cFbsUrgraEtb4UwovKECMwCPQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-11-11 4:55 GMT+01:00 Howard Chen <ibanezchen@gmail.com>:
> The mt6592-evb is an evaluation board based on the MT6592 SoC.
>
> Signed-off-by: Howard Chen <ibanezchen@gmail.com>
> ---
>  arch/arm/boot/dts/Makefile       |  3 ++-
>  arch/arm/boot/dts/mt6592-evb.dts | 29 +++++++++++++++++++++++++++++
>  2 files changed, 31 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/mt6592-evb.dts
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index ab63751..0ce0d9e 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -532,7 +532,8 @@ dtb-$(CONFIG_MACH_DOVE) += dove-cm-a510.dtb \
>         dove-d2plug.dtb \
>         dove-d3plug.dtb \
>         dove-dove-db.dtb
> -dtb-$(CONFIG_ARCH_MEDIATEK) += mt6589-aquaris5.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt6589-aquaris5.dtb \
> +       mt6592-evb.dtb
>
>  endif
>
> diff --git a/arch/arm/boot/dts/mt6592-evb.dts b/arch/arm/boot/dts/mt6592-evb.dts
> new file mode 100644
> index 0000000..d7294d9
> --- /dev/null
> +++ b/arch/arm/boot/dts/mt6592-evb.dts
> @@ -0,0 +1,29 @@
> +/*
> + * Copyright (c) 2014 MediaTek Inc.
> + * Author: Howard Chen <ibanezchen@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +/dts-v1/;
> +#include "mt6592.dtsi"
> +
> +/ {
> +       model = "mt6592 evb";
> +       compatible = "mediatek,mt6592-evb", "mediatek,mt6592";
> +
> +       chosen {
> +               bootargs = "console=ttyS0,921600n8";
> +       };

Please delte this, we don't have a serial console at the moment.

> +
> +       memory {
> +               reg = <0x80000000 0x08000000>;
> +       };
> +};
> --
> 1.9.1
>



-- 
motzblog.wordpress.com
