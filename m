From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 24 Apr 2012 16:43:12 +0200
Subject: [PATCH v3] Ethernut 5 board support
In-Reply-To: <4F96B985.50807@egnite.de>
References: <4F96B985.50807@egnite.de>
Message-ID: <20120424144312.GI9142@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16:32 Tue 24 Apr     , Tim Schendekehl wrote:
> Add support for the Ethernut 5 open hardware design, based
> on Atmel's AT91SAM9XE512 SoC.
> 
> Signed-off-by: Tim Schendekehl <tim.schendekehl@egnite.de>
> ---
> V3:
>  - More specific compatible property for nxp,pcf8563.
>  - Remove pmmc i2c-device.
> 
you miss the entry in arch/arm/mach-at91/Makefile.boot

>  arch/arm/boot/dts/ethernut5.dts |   84 +++++++++++++++++++++++++++++++++++++++
>  1 files changed, 84 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/boot/dts/ethernut5.dts
> 
> diff --git a/arch/arm/boot/dts/ethernut5.dts b/arch/arm/boot/dts/ethernut5.dts
> new file mode 100644
> index 0000000..35c3830
> --- /dev/null
> +++ b/arch/arm/boot/dts/ethernut5.dts
> @@ -0,0 +1,84 @@
> +/*
> + * ethernut5.dts - Device Tree file for Ethernut 5 board
> + *
> + * Copyright (C) 2012 egnite GmbH <info@egnite.de>
> + *
> + * Licensed under GPLv2.
> + */
> +/dts-v1/;
> +/include/ "at91sam9260.dtsi"
> +
> +/ {
> +	model = "Ethernut 5";
> +	compatible = "egnite,ethernut5", "atmel,at91sam9260", "atmel,at91sam9";
> +
> +	chosen {
> +		bootargs = "console=ttyS0,115200 root=/dev/mtdblock0 mtdparts=atmel_nand:128m(root),896m(data) rw rootfstype=jffs2";
descrisbe the partiction via DT

Best Regards,
J.
