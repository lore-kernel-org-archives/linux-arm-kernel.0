From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 29 Nov 2016 15:51:29 +0100
Subject: [PATCH 4/5] arm64: dts: marvell: Add definition of SPI
 controller for Armada 3700
In-Reply-To: <20161129143939.3191-5-romain.perier@free-electrons.com>
References: <20161129143939.3191-1-romain.perier@free-electrons.com>
 <20161129143939.3191-5-romain.perier@free-electrons.com>
Message-ID: <20161129155129.6f3c76b6@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, 29 Nov 2016 15:39:38 +0100, Romain Perier wrote:

> diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> index e9bd587..84e4f57 100644
> --- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> @@ -98,6 +98,19 @@
>  			/* 32M internal register @ 0xd000_0000 */
>  			ranges = <0x0 0x0 0xd0000000 0x2000000>;
>  
> +			spi0: spi at 10600 {
> +				compatible = "marvell,armada-3700-spi";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				reg = <0x10600 0x5d>;
> +				clocks = <&nb_periph_clk 7>;
> +				clock-frequency = <200000000>;

This property.

> +				interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
> +				max-frequency = <66000000>;

And this one no longer exist in your DT binding, so I guess they should
be removed from here as well.

(Please wait for other reviews, don't respin just for that issue.)

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
