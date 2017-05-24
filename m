From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 24 May 2017 10:17:03 +0200
Subject: [PATCH] ARM: dts: rockchip: correct regular setting for act8846
In-Reply-To: <1495611221-6749-1-git-send-email-eddie.cai.linux@gmail.com>
References: <1495611221-6749-1-git-send-email-eddie.cai.linux@gmail.com>
Message-ID: <5352430.FzU3E8oYou@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eddie,

Am Mittwoch, 24. Mai 2017, 15:33:41 CEST schrieb Eddie Cai:
> the previous setting of act8846 is just copy from firefly board. but
> the reload board is a little different from firefly board. let's correct
> it.
> 
> Signed-off-by: Eddie Cai <eddie.cai.linux@gmail.com>
> ---
>  arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi b/arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi
> index 8134966..4cfa109 100644
> --- a/arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi
> +++ b/arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi
> @@ -179,6 +179,7 @@
>  				regulator-name = "vccio_sd";
>  				regulator-min-microvolt = <3300000>;
>  				regulator-max-microvolt = <3300000>;
> +				regulator-always-on;

the rest below looks pretty straight forward, but why does vccio_sd
need to be always on?

I've checked the reload's schematics but did not find any further users
of vccio_sd that may warant this attribute.


Heiko


>  			};
>  
>  			vdd10_lcd: REG6 {
> @@ -187,24 +188,23 @@
>  				regulator-max-microvolt = <1000000>;
>  			};
>  
> -			vcca_18: REG7  {
> -				regulator-name = "vcca_18";
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-always-on;
> +			vcca_33: REG7  {
> +				regulator-name = "vcca_33";
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
>  			};
>  
> -			vcca_33: REG8 {
> -				regulator-name = "vcca_33";
> +			vcc_lan: REG8 {
> +				regulator-name = "vcc_lan";
>  				regulator-min-microvolt = <3300000>;
>  				regulator-max-microvolt = <3300000>;
> -				regulator-always-on;
>  			};
>  
> -			vcc_lan: REG9 {
> -				regulator-name = "vcca_lan";
> +			vccio_pmu: REG9 {
> +				regulator-name = "vccio_pmu";
>  				regulator-min-microvolt = <3300000>;
>  				regulator-max-microvolt = <3300000>;
> +				regulator-always-on;
>  			};
>  
>  			vdd_10: REG10 {
> @@ -218,6 +218,7 @@
>  				regulator-name = "vcc_18";
>  				regulator-min-microvolt = <1800000>;
>  				regulator-max-microvolt = <1800000>;
> +				regulator-always-on;
>  			};
>  
>  			vcc18_lcd: REG12 {
> 
