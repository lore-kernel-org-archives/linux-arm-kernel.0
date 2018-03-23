From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Fri, 23 Mar 2018 17:34:38 +0100
Subject: [PATCH 1/3] arm64: dts: marvell: armada-37xx: mark the gpio
 controllers as irq controller
In-Reply-To: <20180321105005.18426-1-u.kleine-koenig@pengutronix.de> ("Uwe
 =?utf-8?Q?Kleine-K=C3=B6nig=22's?= message of "Wed, 21 Mar 2018 11:50:03
 +0100")
References: <20180321105005.18426-1-u.kleine-koenig@pengutronix.de>
Message-ID: <87zi2yvjhd.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,
 
 On mer., mars 21 2018, Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> wrote:

> This allows to reference these gpio controller as interrupt parent. Also
> add a comment which cpu line names are managed by the controllers
> because "nb" and "sb" usually doesn't appear in schematics, but MPPX_Y
> do.
>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>


Applied on mvebu/dt-for-4.18 (I wonders why I didn't updated the dtsi
earlier...)

Thanks,

Gregory

> ---
>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> index 375026867342..6a96404e7c88 100644
> --- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> @@ -184,10 +184,13 @@
>  				compatible = "marvell,armada3710-nb-pinctrl",
>  					     "syscon", "simple-mfd";
>  				reg = <0x13800 0x100>, <0x13C00 0x20>;
> +				/* MPP1[19:0] */
>  				gpionb: gpio {
>  					#gpio-cells = <2>;
>  					gpio-ranges = <&pinctrl_nb 0 0 36>;
>  					gpio-controller;
> +					interrupt-controller;
> +					#interrupt-cells = <2>;
>  					interrupts =
>  					<GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>,
>  					<GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>,
> @@ -245,10 +248,13 @@
>  				compatible = "marvell,armada3710-sb-pinctrl",
>  					     "syscon", "simple-mfd";
>  				reg = <0x18800 0x100>, <0x18C00 0x20>;
> +				/* MPP2[23:0] */
>  				gpiosb: gpio {
>  					#gpio-cells = <2>;
>  					gpio-ranges = <&pinctrl_sb 0 0 30>;
>  					gpio-controller;
> +					interrupt-controller;
> +					#interrupt-cells = <2>;
>  					interrupts =
>  					<GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
>  					<GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>,
> -- 
> 2.16.2
>

-- 
Gregory Clement, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
