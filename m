From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 26 Apr 2017 12:27:48 +0200
Subject: [PATCH v4 6/7] ARM64: dts: marvell: Add pinctrl nodes for Armada
 3700
In-Reply-To: <1defc5c1925e819b28f2b3802aadc9a8e7be224a.1491405475.git-series.gregory.clement@free-electrons.com>
 (Gregory CLEMENT's message of "Wed, 5 Apr 2017 17:18:07 +0200")
References: <cover.65d0e6796fecf1fe6c5d07b981160b54dc9b4acd.1491405475.git-series.gregory.clement@free-electrons.com>
 <cover.65d0e6796fecf1fe6c5d07b981160b54dc9b4acd.1491405475.git-series.gregory.clement@free-electrons.com>
 <1defc5c1925e819b28f2b3802aadc9a8e7be224a.1491405475.git-series.gregory.clement@free-electrons.com>
Message-ID: <87r30f8nvf.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
 
 On mer., avril 05 2017, Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:

> Add the nodes for the two pin controller present in the Armada 37xx SoCs.
>
> Initially the node was named gpio1 using the same name that for the
> register range in the datasheet. However renaming it pinctr_nb (nb for
> North Bridge) makes more sens.
>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Applied on mvebu/dt64

Thanks,

Gregory

> ---
>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 42 +++++++++++++++++++--
>  1 file changed, 39 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> index b48d668a6ab6..c02b13479458 100644
> --- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> @@ -157,10 +157,29 @@
>  				#clock-cells = <1>;
>  			};
>  
> -			gpio1: gpio at 13800 {
> -				compatible = "marvell,mvebu-gpio-3700",
> +			pinctrl_nb: pinctrl-nb at 13800 {
> +				compatible = "marvell,armada3710-nb-pinctrl",
>  				"syscon", "simple-mfd";
> -				reg = <0x13800 0x500>;
> +				reg = <0x13800 0x100>, <0x13C00 0x20>;
> +				gpionb: gpionb {
> +					#gpio-cells = <2>;
> +					gpio-ranges = <&pinctrl_nb 0 0 36>;
> +					gpio-controller;
> +					interrupts =
> +					<GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
> +
> +				};
>  
>  				xtalclk: xtal-clk {
>  					compatible = "marvell,armada-3700-xtal-clock";
> @@ -169,6 +188,23 @@
>  				};
>  			};
>  
> +			pinctrl_sb: pinctrl-sb at 18800 {
> +				compatible = "marvell,armada3710-sb-pinctrl",
> +				"syscon", "simple-mfd";
> +				reg = <0x18800 0x100>, <0x18C00 0x20>;
> +				gpiosb: gpiosb {
> +					#gpio-cells = <2>;
> +					gpio-ranges = <&pinctrl_sb 0 0 29>;
> +					gpio-controller;
> +					interrupts =
> +					<GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
> +				};
> +			};
> +
>  			eth0: ethernet at 30000 {
>  				   compatible = "marvell,armada-3700-neta";
>  				   reg = <0x30000 0x4000>;
> -- 
> git-series 0.9.1

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
