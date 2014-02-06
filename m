From: nm@ti.com (Nishanth Menon)
Date: Thu, 6 Feb 2014 08:35:56 -0600
Subject: [PATCH 3/3] ARM: dts: Add support for both OMAP35xx and OMAP36xx
 Overo/Tobi
In-Reply-To: <1391677818-21154-4-git-send-email-florian.vaussard@epfl.ch>
References: <1391677818-21154-1-git-send-email-florian.vaussard@epfl.ch>
 <1391677818-21154-4-git-send-email-florian.vaussard@epfl.ch>
Message-ID: <52F39DCC.8000006@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/06/2014 03:10 AM, Florian Vaussard wrote:
> Unfortunatly the device tree for older OMAP35xx Overo cannot be used
Unfortunately ?
> with newer OMAP36xx and vice-versa. To address this issue, move most of
> the Tobi DTS to a common include file, and create model-specific Tobi
> DTS.
> 
[...]
> diff --git a/arch/arm/boot/dts/omap3-overo-tobi.dts b/arch/arm/boot/dts/omap3-overo-tobi.dts
> new file mode 100644
> index 0000000..2f82192
> --- /dev/null
> +++ b/arch/arm/boot/dts/omap3-overo-tobi.dts
> @@ -0,0 +1,22 @@
> +/*
> + * Copyright (C) 2012 Florian Vaussard, EPFL Mobots group
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +/*
> + * Tobi expansion board is manufactured by Gumstix Inc.
> + */
> +
> +/dts-v1/;
> +
> +#include "omap34xx.dtsi"
> +#include "omap3-overo-tobi-common.dtsi"
> +
> +/ {
> +	model = "OMAP35xx Gumstix Overo on Tobi";
> +	compatible = "gumstix,omap3-overo-tobi", "gumstix,omap3-overo", "ti,omap3";
To reduce any future problems, I suggest:
compatible = "gumstix,omap3-overo-tobi", "gumstix,omap3-overo",
"ti,omap3430", "ti,omap3";

> +};
> +
> 


-- 
Regards,
Nishanth Menon
