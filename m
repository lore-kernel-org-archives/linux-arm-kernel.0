From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 3 May 2016 20:52:22 +0800
Subject: [PATCH] ARM: dts: imx6ul-14x14-evk: Add audio support
In-Reply-To: <1462233386-23185-1-git-send-email-festevam@gmail.com>
References: <1462233386-23185-1-git-send-email-festevam@gmail.com>
Message-ID: <20160503125222.GK5874@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 02, 2016 at 08:56:26PM -0300, Fabio Estevam wrote:
> @@ -86,6 +139,17 @@
>  	};
>  };
>  
> +&sai2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_sai2>;
> +

Forgot to mention that I dropped this newline when applying.

Shawn

> +	assigned-clocks = <&clks IMX6UL_CLK_SAI2_SEL>,
> +			  <&clks IMX6UL_CLK_SAI2>;
> +	assigned-clock-parents = <&clks IMX6UL_CLK_PLL4_AUDIO_DIV>;
> +	assigned-clock-rates = <0>, <12288000>;
> +	status = "okay";
> +};
> +
>  &snvs_poweroff {
>  	status = "okay";
>  };
> @@ -272,6 +336,17 @@
>  		>;
>  	};
>  
> +	pinctrl_sai2: sai2grp {
> +		fsl,pins = <
> +			MX6UL_PAD_JTAG_TDI__SAI2_TX_BCLK	0x17088
> +			MX6UL_PAD_JTAG_TDO__SAI2_TX_SYNC	0x17088
> +			MX6UL_PAD_JTAG_TRST_B__SAI2_TX_DATA	0x11088
> +			MX6UL_PAD_JTAG_TCK__SAI2_RX_DATA	0x11088
> +			MX6UL_PAD_JTAG_TMS__SAI2_MCLK		0x17088
> +			MX6UL_PAD_SNVS_TAMPER4__GPIO5_IO04	0x17059
> +		>;
> +	};
> +
>  	pinctrl_pwm1: pwm1grp {
>  		fsl,pins = <
>  			MX6UL_PAD_GPIO1_IO08__PWM1_OUT   0x110b0
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
