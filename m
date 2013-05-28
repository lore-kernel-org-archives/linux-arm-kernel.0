From: broonie@kernel.org (Mark Brown)
Date: Tue, 28 May 2013 10:19:24 -0400
Subject: [PATCH] ARM: dts: wm8994: Add wm8994 regulator support on
 smdk5250.
In-Reply-To: <1369737322-10907-1-git-send-email-padma.v@samsung.com>
References: <1369737322-10907-1-git-send-email-padma.v@samsung.com>
Message-ID: <20130528141924.GH3660@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 28, 2013 at 04:05:22PM +0530, Padmavathi Venna wrote:

> +	avdd2:fixed-regulator at 0 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "avdd2-supply";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		regulator-always-on;
> +	};

> +	cpvdd:fixed-regulator at 1 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "cpvdd-supply";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		regulator-always-on;
> +	};

Several of these look like the same supply (especially the speaker ones)
so it seems like it'd be sensible to define a single regulator for each
of them.  Not much practical difference but it might be neater.

> +
> +	dbvdd:fixed-regulator at 2 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "dbvdd-supply";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-always-on;
> +	};
> +
> +	spkvdd1:fixed-regulator at 3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "spkvdd1-supply";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-always-on;
> +	};
> +
> +	spkvdd2:fixed-regulator at 4 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "spkvdd2-supply";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-always-on;
> +	};
> +
>  	i2c at 12C70000 {
>  		samsung,i2c-sda-delay = <100>;
>  		samsung,i2c-max-bus-freq = <20000>;
> @@ -47,8 +87,17 @@
>  		};
>  
>  		wm8994: wm8994 at 1a {
> -			 compatible = "wlf,wm8994";
> -			 reg = <0x1a>;
> +			compatible = "wlf,wm8994";
> +			reg = <0x1a>;
> +
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +
> +			AVDD2-supply = <&avdd2>;
> +			CPVDD-supply = <&cpvdd>;
> +			DBVDD-supply = <&dbvdd>;
> +			SPKVDD1-supply = <&spkvdd1>;
> +			SPKVDD2-supply = <&spkvdd2>;
>  		};
>  	};
>  
> -- 
> 1.7.4.4
> 
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130528/86c4b0bf/attachment.sig>
