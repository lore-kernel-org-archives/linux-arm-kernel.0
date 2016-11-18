From: l.stach@pengutronix.de (Lucas Stach)
Date: Fri, 18 Nov 2016 11:59:01 +0100
Subject: [RFC 4/6] ARM: dts: dra7: add entry for bb2d module
In-Reply-To: <20161118024436.13447-4-robertcnelson@gmail.com>
References: <20161118024436.13447-1-robertcnelson@gmail.com>
 <20161118024436.13447-4-robertcnelson@gmail.com>
Message-ID: <1479466741.20533.5.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, den 17.11.2016, 20:44 -0600 schrieb Robert Nelson:
> From: Gowtham Tammana <g-tammana@ti.com>
> 
> BB2D entry is added to the dts file. Crossbar index number is used
> for interrupt mapping.
> 
> Signed-off-by: Gowtham Tammana <g-tammana@ti.com>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>  arch/arm/boot/dts/dra7.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> index addb753..43488b6 100644
> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -959,6 +959,16 @@
>  			ti,hwmods = "dmm";
>  		};
>  
> +		bb2d: bb2d at 59000000 {
> +			compatible = "ti,dra7-bb2d";
> +			reg = <0x59000000 0x0700>;
> +			interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
> +			ti,hwmods = "bb2d";
> +			clocks = <&dpll_core_h24x2_ck>;
> +			clock-names = "fclk";

"fclk" is not an accepted clock name for the etnaviv driver. It supports
up to 3 clocks: "bus", "core" and "shader". If there is only one clock
required in your design it would probably be the "core" clock.

Regards,
Lucas
