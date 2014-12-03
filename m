From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 03 Dec 2014 12:03:37 +0100
Subject: [PATCH 11/12] ARM: dts: add support for Vybrid running on
 Cortex-M4
In-Reply-To: <1417565531-4507-12-git-send-email-stefan@agner.ch>
References: <1417565531-4507-1-git-send-email-stefan@agner.ch>
 <1417565531-4507-12-git-send-email-stefan@agner.ch>
Message-ID: <2994970.DCfUQgtmcD@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 03 December 2014 01:12:10 Stefan Agner wrote:
> diff --git a/arch/arm/boot/dts/vf610m4-colibri.dts b/arch/arm/boot/dts/vf610m4-colibri.dts
> new file mode 100644
> index 0000000..051ee0f
> --- /dev/null
> +++ b/arch/arm/boot/dts/vf610m4-colibri.dts
> @@ -0,0 +1,52 @@
> +/*
> + * Device tree for Colibri VF61 Cortex-M4 support
> + *
> + * Copyright 2014 Stefan Agner
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +/dts-v1/;
> +#include "vf610m4.dtsi"
> +
> +/ {
> +       model = "VF610 Cortex-M4";
> +       compatible = "fsl,vf610m4";
> +
> +       chosen {
> +               bootargs = "console=ttyLP2,115200 ihash_entries=64 dhash_entries=64 earlyprintk clk_ignore_unused init=/linuxrc rw";
> +       };
> +

Starting with v3.19, you should be able to use the earlycon framework on
arm32, so it would be better to replace earlyprintk with earlycon here
and add a stdout-path property in chosen that points to the console
uart.

64 hash table entries sounds extremely small, doesn't that impact
performance? If you have 50MB of actual RAM available, I don't think
you need that.

	Arnd
