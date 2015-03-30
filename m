From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 30 Mar 2015 16:13:50 -0700
Subject: [PATCH 1/2] sunxi: a20-LIME2 update regulator description
In-Reply-To: <55143CA1.7000606@gmail.com>
References: <55143CA1.7000606@gmail.com>
Message-ID: <20150330231350.GA23664@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Mar 26, 2015 at 05:06:41PM +0000, Iain Paton wrote:
> configure regulators as per the manufacturers recomendations from their
> 3.4.x fex file.
> 
> this is necessary to prevent operating points in the dtsi selecting
> inappropriate values and causing the board to lockup
> 
> Signed-off-by: Iain Paton <ipaton0@gmail.com>
> ---
>  arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts | 34 +++++++++++++++++--------
>  1 file changed, 24 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
> index 5e57157..704df28 100644
> --- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
> @@ -123,41 +123,55 @@
>  		ldo24in-supply = <&reg_axp_ipsout>;
>  		ldo3in-supply = <&reg_axp_ipsout>;
>  
> +		x-powers,dcdc-freq = <1500>;
> +
>  		regulators {
>  			vdd_rtc: ldo1 {
>  				regulator-min-microvolt = <1300000>;
>  				regulator-max-microvolt = <1300000>;
>  				regulator-always-on;
> +				regulator-name="vdd_rtc";
>  			};
>  
>  			avcc: ldo2 {
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <3300000>;
> +				regulator-min-microvolt = <3000000>;
> +				regulator-max-microvolt = <3000000>;
>  				regulator-always-on;
> +				regulator-name="avcc";
>  			};
>  
>  			vcc_csi0: ldo3 {
> -				regulator-min-microvolt = <700000>;
> -				regulator-max-microvolt = <3500000>;
> +				regulator-min-microvolt = <2800000>;
> +				regulator-max-microvolt = <2800000>;
>  				regulator-always-on;
> +				regulator-name="vcc_csi0";
>  			};
>  
>  			vcc_csi1: ldo4 {
> -				regulator-min-microvolt = <1250000>;
> -				regulator-max-microvolt = <3300000>;
> +				regulator-min-microvolt = <2800000>;
> +				regulator-max-microvolt = <2800000>;
>  				regulator-always-on;
> +				regulator-name="vcc_csi1";
> +			};
> +
> +			ldo5 {
> +				regulator-min-microvolt = <2800000>;
> +				regulator-max-microvolt = <2800000>;
> +				regulator-name="reg_unused";
>  			};
>  
>  			vdd_cpu: dcdc2 {
> -				regulator-min-microvolt = <700000>;
> -				regulator-max-microvolt = <2275000>;
> +				regulator-min-microvolt = <1050000>;
> +				regulator-max-microvolt = <1450000>;
>  				regulator-always-on;
> +				regulator-name="vdd_cpu";
>  			};
>  
>  			vdd_int: dcdc3 {
> -				regulator-min-microvolt = <700000>;
> -				regulator-max-microvolt = <3500000>;
> +				regulator-min-microvolt = <1300000>;
> +				regulator-max-microvolt = <1300000>;
>  				regulator-always-on;
> +				regulator-name="vdd_int";

Could you use the axp DTSI please?

That will remove most of the chunk defined in there.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150330/55a47e9b/attachment.sig>
