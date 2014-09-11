From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 11 Sep 2014 23:03:36 +0200
Subject: [PATCH v2 8/9] ARM: meson: dts: add basic
 Meson/Meson6/Meson6-atv1200 DTSI/DTS
In-Reply-To: <1410466300-19168-9-git-send-email-carlo@caione.org>
References: <1410466300-19168-1-git-send-email-carlo@caione.org>
 <1410466300-19168-9-git-send-email-carlo@caione.org>
Message-ID: <3167715.dUiYojznL5@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 11 September 2014 22:11:39 Carlo Caione wrote:
> diff --git a/arch/arm/boot/dts/meson.dtsi b/arch/arm/boot/dts/meson.dtsi
> new file mode 100644
> index 0000000..ace5db8
> --- /dev/null
> +++ b/arch/arm/boot/dts/meson.dtsi
> @@ -0,0 +1,74 @@
> +/*
> + * Copyright 2014 Carlo Caione <carlo@caione.org>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the
> + * Free Software Foundation; either version 2 of the License, or (at your
> + * option) any later version.
> + */

We recently had a discussion about licensing of dts files. Please make
these dual-licensed GPL+BSD or similar, so they can be included in
other operating systems as well.

> +/include/ "skeleton.dtsi"
> +
> +/ {
> +	interrupt-parent = <&gic>;
> +
> +	aliases {
> +		serial0 = &uart_AO;
> +		serial1 = &uart_A;
> +		serial2 = &uart_B;
> +		serial3 = &uart_C;
> +	};

I think it would be best to move these aliases into the per-board
file and only list the present ones.

	Arnd
