From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 30 Mar 2015 21:01:45 +0800
Subject: [PATCH] ARM: dts: hummingboard: add sgtl5000 support for
 Hummingboard Pro
In-Reply-To: <E1YcYT3-0006rE-3F@rmk-PC.arm.linux.org.uk>
References: <E1YcYT3-0006rE-3F@rmk-PC.arm.linux.org.uk>
Message-ID: <20150330130108.GA5839@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 30, 2015 at 01:06:57PM +0100, Russell King wrote:
> @@ -120,6 +137,17 @@
>  		compatible = "nxp,pcf8523";
>  		reg = <0x68>;
>  	};
> +
> +	/* Pro baseboard model */
> +	sgtl5000: sgtl5000 at 0a {
> +		clocks = <&clks 201>;

Macro IMX6QDL_CLK_CKO in include/dt-bindings/clock/imx6qdl-clock.h
should make it more readable.

I fixed it up and applied the patch.

Shawn

> +		compatible = "fsl,sgtl5000";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_hummingboard_sgtl5000>;
> +		reg = <0x0a>;
> +		VDDA-supply = <&reg_3p3v>;
> +		VDDIO-supply = <&reg_3p3v>;
> +	};
>  };
>  
>  &i2c2 {
