From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 15 Jan 2014 13:58:32 +0800
Subject: [PATCH] ARM: dts: imx28-apf28dev: add user button
In-Reply-To: <1389709287-25742-1-git-send-email-sebastien.szymanski@armadeus.com>
References: <1389709287-25742-1-git-send-email-sebastien.szymanski@armadeus.com>
Message-ID: <20140115055830.GF1896@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 14, 2014 at 03:21:27PM +0100, S?bastien Szymanski wrote:
> Signed-off-by: S?bastien Szymanski <sebastien.szymanski@armadeus.com>
> ---
>  arch/arm/boot/dts/imx28-apf28dev.dts | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Applied, thanks.

Shawn

> 
> diff --git a/arch/arm/boot/dts/imx28-apf28dev.dts b/arch/arm/boot/dts/imx28-apf28dev.dts
> index 334dea5..221cac4 100644
> --- a/arch/arm/boot/dts/imx28-apf28dev.dts
> +++ b/arch/arm/boot/dts/imx28-apf28dev.dts
> @@ -48,6 +48,7 @@
>  						MX28_PAD_LCD_D20__GPIO_1_20
>  						MX28_PAD_LCD_D21__GPIO_1_21
>  						MX28_PAD_LCD_D22__GPIO_1_22
> +						MX28_PAD_GPMI_CE1N__GPIO_0_17
>  					>;
>  					fsl,drive-strength = <MXS_DRIVE_4mA>;
>  					fsl,voltage = <MXS_VOLTAGE_HIGH>;
> @@ -193,4 +194,14 @@
>  		brightness-levels = <0 4 8 16 32 64 128 255>;
>  		default-brightness-level = <6>;
>  	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		user-button {
> +			label = "User button";
> +			gpios = <&gpio0 17 0>;
> +			linux,code = <0x100>;
> +		};
> +	};
>  };
> -- 
> 1.8.3.2
> 
