From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 02 Dec 2014 18:01:36 +0100
Subject: [PATCH] ARM: dts: rockchip: Add input voltage supply regulators
 in pmic for Marsboard
In-Reply-To: <1417459046-13725-1-git-send-email-romain.perier@gmail.com>
References: <1417459046-13725-1-git-send-email-romain.perier@gmail.com>
Message-ID: <3330015.f3st3aFmak@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 1. Dezember 2014, 18:37:26 schrieb Romain Perier:
> Signed-off-by: Romain Perier <romain.perier@gmail.com>

applied to my dts branch, after adding a oneline commit message.
It's always nice to provide some sort of commit message instead of leaving it 
empty.


> ---
>  arch/arm/boot/dts/rk3066a-marsboard.dts | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/rk3066a-marsboard.dts
> b/arch/arm/boot/dts/rk3066a-marsboard.dts index f766024..5999708 100644
> --- a/arch/arm/boot/dts/rk3066a-marsboard.dts
> +++ b/arch/arm/boot/dts/rk3066a-marsboard.dts
> @@ -60,6 +60,14 @@
>  		startup-delay-us = <100000>;
>  		vin-supply = <&vcc_io>;
>  	};
> +
> +	vsys: vsys-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vsys";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-boot-on;
> +	};
>  };
> 
>  &i2c1 {
> @@ -72,8 +80,14 @@
>  		interrupt-parent = <&gpio6>;
>  		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
> 
> +		vcc1-supply = <&vsys>;
> +		vcc2-supply = <&vsys>;
> +		vcc3-supply = <&vsys>;
> +		vcc4-supply = <&vsys>;
>  		vcc5-supply = <&vcc_io>;
>  		vcc6-supply = <&vcc_io>;
> +		vcc7-supply = <&vsys>;
> +		vccio-supply = <&vsys>;
> 
>  		regulators {
>  			vcc_rtc: regulator at 0 {
