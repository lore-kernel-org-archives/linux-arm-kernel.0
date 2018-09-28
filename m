From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 28 Sep 2018 17:00:32 +0800
Subject: [PATCH] arm64: dts: add LX2160AQDS board support
In-Reply-To: <20180921141720.19159-1-pankaj.bansal@nxp.com>
References: <20180921141720.19159-1-pankaj.bansal@nxp.com>
Message-ID: <20180928090030.GI26692@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 21, 2018 at 07:47:20PM +0530, Pankaj Bansal wrote:
> The LX2160A QorIQ Development System (QDS) is a test, evaluation, and
> development platform, supporting QorIQ LX2160A processor.
> 
> Signed-off-by: Sriram Dash <sriram.dash@nxp.com>
> Signed-off-by: Pankaj Bansal <pankaj.bansal@nxp.com>
> ---
> 
> Notes:
>     This patch is dependent on [1] and [2]
>      [1] https://lore.kernel.org/patchwork/patch/985935/
>      [2] https://lore.kernel.org/patchwork/patch/985938/

I did not receive these.

> 
>  arch/arm64/boot/dts/freescale/Makefile       |  1 +
>  .../boot/dts/freescale/fsl-lx2160a-qds.dts   | 88 ++++++++++++++++++
>  2 files changed, 89 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 445b72bd5a36..ae80fc5c45f7 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -14,3 +14,4 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-simu.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2088a-qds.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2088a-rdb.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-rdb.dtb
> +dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-qds.dtb

Please keep them in alphabetic order.

> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> new file mode 100644
> index 000000000000..5cf2fe279f73
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> @@ -0,0 +1,88 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +//
> +// Device Tree file for LX2160AQDS
> +//
> +// Copyright 2018 NXP
> +
> +/dts-v1/;
> +
> +#include "fsl-lx2160a.dtsi"
> +
> +/ {
> +	model = "NXP Layerscape LX2160AQDS";
> +	compatible = "fsl,lx2160a-qds", "fsl,lx2160a";
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +};
> +
> +&uart0 {
> +	status = "okay";
> +};
> +
> +&uart1 {
> +	status = "okay";
> +};
> +
> +&i2c0 {

Sort these labeled nodes alphabetically, so that new additions can find
their place easier.

> +	status = "okay";

Have a newline between property list and child node.

Shawn

> +	i2c-mux at 77 {
> +		compatible = "nxp,pca9547";
> +		reg = <0x77>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		i2c at 2 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x2>;
> +
> +			power-monitor at 40 {
> +				compatible = "ti,ina220";
> +				reg = <0x40>;
> +				shunt-resistor = <500>;
> +			};
> +
> +			power-monitor at 41 {
> +				compatible = "ti,ina220";
> +				reg = <0x41>;
> +				shunt-resistor = <1000>;
> +			};
> +		};
> +
> +		i2c at 3 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x3>;
> +
> +			temperature-sensor at 4c {
> +				compatible = "nxp,sa56004";
> +				reg = <0x4c>;
> +			};
> +
> +			temperature-sensor at 4d {
> +				compatible = "nxp,sa56004";
> +				reg = <0x4d>;
> +			};
> +
> +			rtc at 51 {
> +				compatible = "nxp,pcf2129";
> +				reg = <0x51>;
> +			};
> +		};
> +	};
> +};
> +
> +&usb0 {
> +	status = "okay";
> +};
> +
> +&usb1 {
> +	status = "okay";
> +};
> +
> +&crypto {
> +	status = "okay";
> +};
> +
> -- 
> 2.17.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
