From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 20 Jun 2017 16:34:06 +0200
Subject: [PATCH v3 7/9] arm64: dts: marvell: add pinctrl support for
 Armada 7K/8K
In-Reply-To: <f8504294967e4cbda36963c9754a6703b769e99d.1497281623.git-series.gregory.clement@free-electrons.com>
 (Gregory CLEMENT's message of "Mon, 12 Jun 2017 17:34:58 +0200")
References: <cover.d003a5e862e6d732d901a61d1765a349c9a89eef.1497281623.git-series.gregory.clement@free-electrons.com>
 <cover.d003a5e862e6d732d901a61d1765a349c9a89eef.1497281623.git-series.gregory.clement@free-electrons.com>
 <f8504294967e4cbda36963c9754a6703b769e99d.1497281623.git-series.gregory.clement@free-electrons.com>
Message-ID: <8760fq4tk1.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
 
 On lun., juin 12 2017, Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:

> Enable pinctrl support for CP and AP on the Armada 7K/8K SoCs.
>
> The CP master being different between Armada 7k and Armada 8k. This
> commit introduces the intermediates files armada-70x0.dtsi and
> armada-80x0.dtsi.
>
> These new files will provide different compatible strings depending of
> the SoC family. They will also be the location for the pinmux
> configuration at the SoC level.
>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Applied on mvebu/dt64

Thanks,

Gregory

> ---
>  arch/arm64/boot/dts/marvell/armada-7020.dtsi  |  2 +-
>  arch/arm64/boot/dts/marvell/armada-7040.dtsi  |  2 +-
>  arch/arm64/boot/dts/marvell/armada-70x0.dtsi  | 53 ++++++++++++++++++-
>  arch/arm64/boot/dts/marvell/armada-8020.dtsi  |  3 +-
>  arch/arm64/boot/dts/marvell/armada-8040.dtsi  |  3 +-
>  arch/arm64/boot/dts/marvell/armada-80x0.dtsi  | 60 ++++++++++++++++++++-
>  arch/arm64/boot/dts/marvell/armada-ap806.dtsi |  4 +-
>  7 files changed, 121 insertions(+), 6 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/marvell/armada-70x0.dtsi
>  create mode 100644 arch/arm64/boot/dts/marvell/armada-80x0.dtsi
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-7020.dtsi b/arch/arm64/boot/dts/marvell/armada-7020.dtsi
> index 975e73302753..4ab012991d9d 100644
> --- a/arch/arm64/boot/dts/marvell/armada-7020.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-7020.dtsi
> @@ -46,7 +46,7 @@
>   */
>  
>  #include "armada-ap806-dual.dtsi"
> -#include "armada-cp110-master.dtsi"
> +#include "armada-70x0.dtsi"
>  
>  / {
>  	model = "Marvell Armada 7020";
> diff --git a/arch/arm64/boot/dts/marvell/armada-7040.dtsi b/arch/arm64/boot/dts/marvell/armada-7040.dtsi
> index 78d995d62707..cbe460b8fc00 100644
> --- a/arch/arm64/boot/dts/marvell/armada-7040.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-7040.dtsi
> @@ -46,7 +46,7 @@
>   */
>  
>  #include "armada-ap806-quad.dtsi"
> -#include "armada-cp110-master.dtsi"
> +#include "armada-70x0.dtsi"
>  
>  / {
>  	model = "Marvell Armada 7040";
> diff --git a/arch/arm64/boot/dts/marvell/armada-70x0.dtsi b/arch/arm64/boot/dts/marvell/armada-70x0.dtsi
> new file mode 100644
> index 000000000000..f6c22665d091
> --- /dev/null
> +++ b/arch/arm64/boot/dts/marvell/armada-70x0.dtsi
> @@ -0,0 +1,53 @@
> +/*
> + * Copyright (C) 2017 Marvell Technology Group Ltd.
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPLv2 or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This library is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License as
> + *     published by the Free Software Foundation; either version 2 of the
> + *     License, or (at your option) any later version.
> + *
> + *     This library is distributed in the hope that it will be useful,
> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *     GNU General Public License for more details.
> + *
> + * Or, alternatively,
> + *
> + *  b) Permission is hereby granted, free of charge, to any person
> + *     obtaining a copy of this software and associated documentation
> + *     files (the "Software"), to deal in the Software without
> + *     restriction, including without limitation the rights to use,
> + *     copy, modify, merge, publish, distribute, sublicense, and/or
> + *     sell copies of the Software, and to permit persons to whom the
> + *     Software is furnished to do so, subject to the following
> + *     conditions:
> + *
> + *     The above copyright notice and this permission notice shall be
> + *     included in all copies or substantial portions of the Software.
> + *
> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + *     OTHER DEALINGS IN THE SOFTWARE.
> + */
> +
> +/*
> + * Device Tree file for the Armada 70x0 SoC
> + */
> +
> +#include "armada-cp110-master.dtsi"
> +
> +&cpm_syscon0 {
> +	cpm_pinctrl: pinctrl {
> +		compatible = "marvell,armada-7k-pinctrl";
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/marvell/armada-8020.dtsi b/arch/arm64/boot/dts/marvell/armada-8020.dtsi
> index 7c08f1f28d9e..0ba0bc942598 100644
> --- a/arch/arm64/boot/dts/marvell/armada-8020.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-8020.dtsi
> @@ -46,8 +46,7 @@
>   */
>  
>  #include "armada-ap806-dual.dtsi"
> -#include "armada-cp110-master.dtsi"
> -#include "armada-cp110-slave.dtsi"
> +#include "armada-80x0.dtsi"
>  
>  / {
>  	model = "Marvell Armada 8020";
> diff --git a/arch/arm64/boot/dts/marvell/armada-8040.dtsi b/arch/arm64/boot/dts/marvell/armada-8040.dtsi
> index 33813a75bc30..60fe84f5cbcc 100644
> --- a/arch/arm64/boot/dts/marvell/armada-8040.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-8040.dtsi
> @@ -46,8 +46,7 @@
>   */
>  
>  #include "armada-ap806-quad.dtsi"
> -#include "armada-cp110-master.dtsi"
> -#include "armada-cp110-slave.dtsi"
> +#include "armada-80x0.dtsi"
>  
>  / {
>  	model = "Marvell Armada 8040";
> diff --git a/arch/arm64/boot/dts/marvell/armada-80x0.dtsi b/arch/arm64/boot/dts/marvell/armada-80x0.dtsi
> new file mode 100644
> index 000000000000..93d1de03b39a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/marvell/armada-80x0.dtsi
> @@ -0,0 +1,60 @@
> +/*
> + * Copyright (C) 2017 Marvell Technology Group Ltd.
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPLv2 or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This library is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License as
> + *     published by the Free Software Foundation; either version 2 of the
> + *     License, or (at your option) any later version.
> + *
> + *     This library is distributed in the hope that it will be useful,
> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *     GNU General Public License for more details.
> + *
> + * Or, alternatively,
> + *
> + *  b) Permission is hereby granted, free of charge, to any person
> + *     obtaining a copy of this software and associated documentation
> + *     files (the "Software"), to deal in the Software without
> + *     restriction, including without limitation the rights to use,
> + *     copy, modify, merge, publish, distribute, sublicense, and/or
> + *     sell copies of the Software, and to permit persons to whom the
> + *     Software is furnished to do so, subject to the following
> + *     conditions:
> + *
> + *     The above copyright notice and this permission notice shall be
> + *     included in all copies or substantial portions of the Software.
> + *
> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + *     OTHER DEALINGS IN THE SOFTWARE.
> + */
> +
> +/*
> + * Device Tree file for the Armada 80x0 SoC family
> + */
> +
> +#include "armada-cp110-master.dtsi"
> +#include "armada-cp110-slave.dtsi"
> +
> +&cpm_syscon0 {
> +	cpm_pinctrl: pinctrl {
> +		compatible = "marvell,armada-8k-cpm-pinctrl";
> +	};
> +};
> +
> +&cps_syscon0 {
> +	cps_pinctrl: pinctrl {
> +		compatible = "marvell,armada-8k-cps-pinctrl";
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> index 205037e3e7dc..4a1b6e0a604a 100644
> --- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> @@ -248,6 +248,10 @@
>  					compatible = "marvell,ap806-clock";
>  					#clock-cells = <1>;
>  				};
> +
> +				ap_pinctrl: pinctrl {
> +					compatible = "marvell,ap806-pinctrl";
> +				};
>  			};
>  		};
>  	};
> -- 
> git-series 0.9.1
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
