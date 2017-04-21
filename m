From: niklas.soderlund@ragnatech.se (Niklas =?iso-8859-1?Q?S=F6derlund?=)
Date: Fri, 21 Apr 2017 07:42:01 +0200
Subject: [PATCH 2/8] [RFC] arm64: dts: renesas: Add R-Car H3 SiP (4 x 1
 GiB) support
In-Reply-To: <1492593351-13835-3-git-send-email-geert+renesas@glider.be>
References: <1492593351-13835-1-git-send-email-geert+renesas@glider.be>
 <1492593351-13835-3-git-send-email-geert+renesas@glider.be>
Message-ID: <20170421054201.GR28868@bigcity.dyn.berto.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

Thanks for your work.

On 2017-04-19 11:15:45 +0200, Geert Uytterhoeven wrote:
> Add support for the R-Car H3 System-in-Package (r8j7795), which contains:
>   - an R-Car H3 SoC (r8a7795),
>   - 4 channels of 1 GiB of RAM (4 GiB total),
>   - HyperFlash (not yet described).
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Questions:
>   - Should this file be named r8j7795-4g.dtsi instead?
>   - Do other versions (different memory configuration) of r8j7795 exist?
>     If yes, how are they named?
> ---
>  arch/arm64/boot/dts/renesas/r8j7795-4x1g.dtsi | 36 +++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/renesas/r8j7795-4x1g.dtsi
> 
> diff --git a/arch/arm64/boot/dts/renesas/r8j7795-4x1g.dtsi b/arch/arm64/boot/dts/renesas/r8j7795-4x1g.dtsi
> new file mode 100644
> index 0000000000000000..02e0ff4a60c53704
> --- /dev/null
> +++ b/arch/arm64/boot/dts/renesas/r8j7795-4x1g.dtsi
> @@ -0,0 +1,36 @@
> +/*
> + * Device Tree Source for the r8j7795 SiP with 4 channels of 1 GiB RAM
> + *
> + * Copyright (C) 2015 Renesas Electronics Corp.

2017 right? If so same comment for patches 3 and 4.

> + *
> + * This file is licensed under the terms of the GNU General Public License
> + * version 2.  This program is licensed "as is" without any warranty of any
> + * kind, whether express or implied.
> + */
> +
> +#include "r8a7795.dtsi"
> +
> +/ {
> +	compatible = "renesas,r8j7795", "renesas,r8a7795";
> +
> +	memory at 48000000 {
> +		device_type = "memory";
> +		/* first 128MB is reserved for secure area. */
> +		reg = <0x0 0x48000000 0x0 0x38000000>;
> +	};
> +
> +	memory at 500000000 {
> +		device_type = "memory";
> +		reg = <0x5 0x00000000 0 0x40000000>;
> +	};
> +
> +	memory at 600000000 {
> +		device_type = "memory";
> +		reg = <0x6 0x00000000 0 0x40000000>;
> +	};
> +
> +	memory at 700000000 {
> +		device_type = "memory";
> +		reg = <0x7 0x00000000 0 0x40000000>;
> +	};
> +};
> -- 
> 2.7.4
> 

-- 
Regards,
Niklas S?derlund
