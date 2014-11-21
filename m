From: afaerber@suse.de (=?ISO-8859-15?Q?Andreas_F=E4rber?=)
Date: Fri, 21 Nov 2014 15:11:11 +0100
Subject: [PATCH v12 3/6] ARM: dts: Exynos: add CPU OPP and regulator supply
 property
In-Reply-To: <1416576682-5255-4-git-send-email-thomas.ab@samsung.com>
References: <1416576682-5255-1-git-send-email-thomas.ab@samsung.com>
 <1416576682-5255-2-git-send-email-thomas.ab@samsung.com>
 <1416576682-5255-3-git-send-email-thomas.ab@samsung.com>
 <1416576682-5255-4-git-send-email-thomas.ab@samsung.com>
Message-ID: <546F47FF.2030608@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Javier, Doug,

Am 21.11.2014 um 14:31 schrieb Thomas Abraham:
> diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
> index 3acd97e..da2b3e1 100644
> --- a/arch/arm/boot/dts/exynos5250-arndale.dts
> +++ b/arch/arm/boot/dts/exynos5250-arndale.dts
> @@ -563,3 +563,7 @@
>  		};
>  	};
>  };
> +
> +&cpu0 {
> +	cpu0-supply = <&buck2_reg>;
> +};
> diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
> index 6a0f4c0..0eedb88 100644
> --- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
> +++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
> @@ -406,3 +406,7 @@
>  		};
>  	};
>  };
> +
> +&cpu0 {
> +	cpu0-supply = <&buck2_reg>;
> +};
> diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
> index e51fcef..865f68a 100644
> --- a/arch/arm/boot/dts/exynos5250-snow.dts
> +++ b/arch/arm/boot/dts/exynos5250-snow.dts
> @@ -345,6 +345,10 @@
>  	};
>  };
>  
> +&cpu0 {
> +	cpu0-supply = <&buck2_reg>;
> +};
> +
>  &i2c_0 {
>  	status = "okay";
>  	samsung,i2c-sda-delay = <100>;

Not sure whether I've asked before... Do you know what needs to be
specified for exynos5250-spring.dts, which has in the meantime landed in
kgene/for-next?

Regards,
Andreas

> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
> index f21b9aa..d4b418e 100644
> --- a/arch/arm/boot/dts/exynos5250.dtsi
> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> @@ -58,11 +58,34 @@
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  
> -		cpu at 0 {
> +		cpu0: cpu at 0 {
>  			device_type = "cpu";
>  			compatible = "arm,cortex-a15";
>  			reg = <0>;
>  			clock-frequency = <1700000000>;
> +
> +			clocks = <&clock CLK_ARM_CLK>;
> +			clock-names = "cpu";
> +			clock-latency = <140000>;
> +
> +			operating-points = <
> +				1700000 1300000
> +				1600000 1250000
> +				1500000 1225000
> +				1400000 1200000
> +				1300000 1150000
> +				1200000 1125000
> +				1100000 1100000
> +				1000000 1075000
> +				 900000 1050000
> +				 800000 1025000
> +				 700000 1012500
> +				 600000 1000000
> +				 500000  975000
> +				 400000  950000
> +				 300000  937500
> +				 200000  925000
> +			>;
>  		};
>  		cpu at 1 {
>  			device_type = "cpu";
[snip]

-- 
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 21284 AG N?rnberg
