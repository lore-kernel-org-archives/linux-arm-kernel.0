From: nm@ti.com (Nishanth Menon)
Date: Fri, 1 Nov 2013 16:18:15 -0500
Subject: [PATCHv9 32/43] ARM: dts: AM35xx: use DT clock data
In-Reply-To: <1382716658-6964-33-git-send-email-t-kristo@ti.com>
References: <1382716658-6964-1-git-send-email-t-kristo@ti.com>
 <1382716658-6964-33-git-send-email-t-kristo@ti.com>
Message-ID: <52741A97.3070103@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/25/2013 10:57 AM, Tero Kristo wrote:
[...]

> diff --git a/arch/arm/boot/dts/am3517.dtsi b/arch/arm/boot/dts/am3517.dtsi
> new file mode 100644
> index 0000000..c555443
> --- /dev/null
> +++ b/arch/arm/boot/dts/am3517.dtsi
> @@ -0,0 +1,31 @@
> +/*
> + * Device Tree Source for AM3517 SoC
> + *
> + * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com/
> + *
> + * This file is licensed under the terms of the GNU General Public License
> + * version 2.  This program is licensed "as is" without any warranty of any
> + * kind, whether express or implied.
> + */
> +
> +#include "omap3.dtsi"
> +
> +/ {
> +	cpus {
> +		cpu at 0 {
> +			/* OMAP343x/OMAP35xx variants OPP1-5 */

^^ you could fix the comment since this is OMAP35xx variant :)

> +			operating-points = <
> +				/* kHz    uV */
> +				125000   975000
> +				250000  1075000
> +				500000  1200000
> +				550000  1270000
> +				600000  1350000
> +			>;
> +			clock-latency = <300000>; /* From legacy driver */
> +		};
> +	};
> +};

[..]


-- 
Regards,
Nishanth Menon
