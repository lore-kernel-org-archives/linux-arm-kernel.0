From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 19 Jan 2017 15:42:09 +0100
Subject: [PATCH 2/2] ARM: imx6: fix regulator constraints on anatop 1p1
 and 2p5
In-Reply-To: <20170119142134.8572-2-l.stach@pengutronix.de>
References: <20170119142134.8572-1-l.stach@pengutronix.de>
 <20170119142134.8572-2-l.stach@pengutronix.de>
Message-ID: <1484836929.2989.22.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2017-01-19 at 15:21 +0100, Lucas Stach wrote:
> Fix the min/max voltage constraints for the anatop 1p1 and 2p5
> regulator to match the typical operating range mentioned in the
> datasheet.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  arch/arm/boot/dts/imx6qdl.dtsi | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> index 9313b9af2da8..e9ba244cda54 100644
> --- a/arch/arm/boot/dts/imx6qdl.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> @@ -626,8 +626,8 @@
>  				regulator-1p1 {
>  					compatible = "fsl,anatop-regulator";
>  					regulator-name = "vdd1p1";
> -					regulator-min-microvolt = <800000>;
> -					regulator-max-microvolt = <1375000>;
> +					regulator-min-microvolt = <1000000>;
> +					regulator-max-microvolt = <1200000>;
>  					regulator-always-on;
>  					anatop-reg-offset = <0x110>;
>  					anatop-vol-bit-shift = <8>;
> @@ -654,7 +654,7 @@
>  				regulator-2p5 {
>  					compatible = "fsl,anatop-regulator";
>  					regulator-name = "vdd2p5";
> -					regulator-min-microvolt = <2000000>;
> +					regulator-min-microvolt = <2250000>;
>  					regulator-max-microvolt = <2750000>;
>  					regulator-always-on;
>  					anatop-reg-offset = <0x130>;

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
