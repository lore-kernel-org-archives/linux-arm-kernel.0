From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 23 Jan 2017 15:27:18 +0800
Subject: [PATCH v4 3/3] arm64: dts: freescale: ls2088a: Add DTS support
 for FSL's LS2088A SoC
In-Reply-To: <1484114979-4664-4-git-send-email-abhimanyu.saini@nxp.com>
References: <1484114979-4664-1-git-send-email-abhimanyu.saini@nxp.com>
 <1484114979-4664-4-git-send-email-abhimanyu.saini@nxp.com>
Message-ID: <20170123072715.GJ5662@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 11, 2017 at 11:39:39AM +0530, Abhimanyu Saini wrote:
> This patch adds the device tree support for FSL LS2088A SoC based on
> ARMv8 architecture.
> 
> Following levels of DTSI/DTS files have been created for the LS2088A
> SoC family:
> 
>      - fsl-ls2088a.dtsi:
>             DTS-Include file for FSL LS2088A SoC.
> 
>      - fsl-ls2088a-qds.dts:
>             DTS file for FSL LS2088A QDS board.
> 
>      - fsl-ls2088a-rdb.dts:
>             DTS file for FSL LS2088A RDB board.
> 
> Signed-off-by: Priyanka Jain <priyanka.jain@nxp.com>
> Signed-off-by: Ashish Kumar <ashish.kumar@nxp.com>
> Signed-off-by: Abhimanyu Saini <abhimanyu.saini@nxp.com>
> ---
> Changes for v4:
> 	- Incorporated Shawn's comments by reorganizing
>           DTSI, moving all include definations to the top
> 	- add missing files
> Changes for v2:
> 	- reorganize LS2088A device tree to use common
> 	  nodes from LS2080A device trees.
> 
>  arch/arm64/boot/dts/freescale/Makefile            |   2 +
>  arch/arm64/boot/dts/freescale/fsl-ls2088a-qds.dts |  65 +++++++++
>  arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dts |  65 +++++++++
>  arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi    | 153 ++++++++++++++++++++++
>  4 files changed, 285 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls2088a-qds.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 6602718..854868e 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -5,6 +5,8 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1046a-rdb.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-qds.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-rdb.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-simu.dtb
> +dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2088a-qds.dtb
> +dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2088a-rdb.dtb
>   
>  always		:= $(dtb-y)
>  subdir-y	:= $(dts-dirs)
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2088a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls2088a-qds.dts
> new file mode 100644
> index 0000000..a48145a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls2088a-qds.dts
> @@ -0,0 +1,65 @@
> +/*
> + * Device Tree file for Freescale LS2088A QDS Board.
> + *
> + * Copyright (C) 2016-17, Freescale Semiconductor
> + *
> + * Abhimanyu Saini <abhimanyu.saini@nxp.com>
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
> +/dts-v1/;
> +
> +#include "fsl-ls2088a.dtsi"

Shouldn't you include fsl-ls208xa-qds.dtsi here as well?

Shawn

> +
> +/ {
> +	model = "Freescale Layerscape 2088A QDS Board";
> +	compatible = "fsl,ls2088a-qds", "fsl,ls2088a";
> +
> +	aliases {
> +		serial0 = &serial0;
> +		serial1 = &serial1;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +};
> +
> +#include "fsl-ls208xa-qds.dtsi"
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dts
> new file mode 100644
> index 0000000..cc8c068
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dts
> @@ -0,0 +1,65 @@
> +/*
> + * Device Tree file for Freescale LS2088A RDB Board.
> + *
> + * Copyright (C) 2016-17, Freescale Semiconductor
> + *
> + * Abhimanyu Saini <abhimanyu.saini@nxp.com>
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
> +/dts-v1/;
> +
> +#include "fsl-ls2088a.dtsi"
> +
> +/ {
> +	model = "Freescale Layerscape 2088A RDB Board";
> +	compatible = "fsl,ls2088a-rdb", "fsl,ls2088a";
> +
> +	aliases {
> +		serial0 = &serial0;
> +		serial1 = &serial1;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial1:115200n8";
> +	};
> +};
> +
> +#include "fsl-ls208xa-rdb.dtsi"
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi
> new file mode 100644
> index 0000000..b418fca
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi
> @@ -0,0 +1,153 @@
> +/*
> + * Device Tree Include file for Freescale Layerscape-2088A family SoC.
> + *
> + * Copyright (C) 2016-17, Freescale Semiconductor
> + *
> + * Abhimanyu Saini <abhimanyu.saini@nxp.com>
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
> +#include "fsl-ls208xa.dtsi"
> +
> +&cpu {
> +	cpu0: cpu at 0 {
> +		device_type = "cpu";
> +		compatible = "arm,cortex-a72";
> +		reg = <0x0>;
> +		clocks = <&clockgen 1 0>;
> +		next-level-cache = <&cluster0_l2>;
> +		#cooling-cells = <2>;
> +	};
> +
> +	cpu1: cpu at 1 {
> +		device_type = "cpu";
> +		compatible = "arm,cortex-a72";
> +		reg = <0x1>;
> +		clocks = <&clockgen 1 0>;
> +		next-level-cache = <&cluster0_l2>;
> +	};
> +
> +	cpu2: cpu at 100 {
> +		device_type = "cpu";
> +		compatible = "arm,cortex-a72";
> +		reg = <0x100>;
> +		clocks = <&clockgen 1 1>;
> +		next-level-cache = <&cluster1_l2>;
> +		#cooling-cells = <2>;
> +	};
> +
> +	cpu3: cpu at 101 {
> +		device_type = "cpu";
> +		compatible = "arm,cortex-a72";
> +		reg = <0x101>;
> +		clocks = <&clockgen 1 1>;
> +		next-level-cache = <&cluster1_l2>;
> +	};
> +
> +	cpu4: cpu at 200 {
> +		device_type = "cpu";
> +		compatible = "arm,cortex-a72";
> +		reg = <0x200>;
> +		clocks = <&clockgen 1 2>;
> +		next-level-cache = <&cluster2_l2>;
> +		#cooling-cells = <2>;
> +	};
> +
> +	cpu5: cpu at 201 {
> +		device_type = "cpu";
> +		compatible = "arm,cortex-a72";
> +		reg = <0x201>;
> +		clocks = <&clockgen 1 2>;
> +		next-level-cache = <&cluster2_l2>;
> +	};
> +
> +	cpu6: cpu at 300 {
> +		device_type = "cpu";
> +		compatible = "arm,cortex-a72";
> +		reg = <0x300>;
> +		clocks = <&clockgen 1 3>;
> +		next-level-cache = <&cluster3_l2>;
> +		#cooling-cells = <2>;
> +	};
> +
> +	cpu7: cpu at 301 {
> +		device_type = "cpu";
> +		compatible = "arm,cortex-a72";
> +		reg = <0x301>;
> +		clocks = <&clockgen 1 3>;
> +		next-level-cache = <&cluster3_l2>;
> +	};
> +
> +	cluster0_l2: l2-cache0 {
> +		compatible = "cache";
> +	};
> +
> +	cluster1_l2: l2-cache1 {
> +		compatible = "cache";
> +	};
> +
> +	cluster2_l2: l2-cache2 {
> +		compatible = "cache";
> +	};
> +
> +	cluster3_l2: l2-cache3 {
> +		compatible = "cache";
> +	};
> +};
> +
> +&pcie1 {
> +	ranges = <0x81000000 0x0 0x00000000 0x20 0x00010000 0x0 0x00010000
> +		  0x82000000 0x0 0x40000000 0x20 0x40000000 0x0 0x40000000>;
> +};
> +
> +&pcie2 {
> +	ranges = <0x81000000 0x0 0x00000000 0x28 0x00010000 0x0 0x00010000
> +		  0x82000000 0x0 0x40000000 0x28 0x40000000 0x0 0x40000000>;
> +};
> +
> +&pcie3 {
> +	ranges = <0x81000000 0x0 0x00000000 0x30 0x00010000 0x0 0x00010000
> +		  0x82000000 0x0 0x40000000 0x30 0x40000000 0x0 0x40000000>;
> +};
> +
> +&pcie4 {
> +	ranges = <0x81000000 0x0 0x00000000 0x38 0x00010000 0x0 0x00010000
> +		  0x82000000 0x0 0x40000000 0x38 0x40000000 0x0 0x40000000>;
> +};
> -- 
> 1.9.1
> 
