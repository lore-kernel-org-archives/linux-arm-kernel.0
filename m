From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 5 Mar 2014 14:22:19 +0800
Subject: [PATCH] ARM: dts: imx6qdl-sabresd.dtsi: Add heartbeat led
In-Reply-To: <1393943685-32579-1-git-send-email-vincent.stehle@freescale.com>
References: <1393943685-32579-1-git-send-email-vincent.stehle@freescale.com>
Message-ID: <20140305062216.GI8784@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 04, 2014 at 03:34:45PM +0100, Vincent Stehl? wrote:
> Use the red gpio led for heartbeat.

Some people think it's annoying to have a LED blinking all the time.
Since it's a user defined LED, let's leave it to users for their
particular use case.

Shawn

> 
> Signed-off-by: Vincent Stehl? <vincent.stehle@freescale.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> ---
> 
> Hi,
> 
> This has been tested on Sabre SD i.MX6 Quad board, with linux v3.14-rc5+ and
> imx_v6_v7_defconfig.
> 
> As a side note, checkpatch.pl complains about gpio-leds being undocumented, but
> I am not sure what to do about that.
> 
> Best regards,
> 
> V.
> 
>  arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> index e75e11b..cf4d736 100644
> --- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> @@ -88,6 +88,16 @@
>  		default-brightness-level = <7>;
>  		status = "okay";
>  	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		heartbeat-led {
> +		        label = "Heartbeat";
> +		        gpios = <&gpio1 2 0>;
> +		        linux,default-trigger = "heartbeat";
> +		};
> +	};
>  };
>  
>  &audmux {
> @@ -182,6 +192,7 @@
>  				MX6QDL_PAD_ENET_TXD1__GPIO1_IO29 0x80000000
>  				MX6QDL_PAD_EIM_D22__GPIO3_IO22  0x80000000
>  				MX6QDL_PAD_ENET_CRS_DV__GPIO1_IO25 0x80000000
> +				MX6QDL_PAD_GPIO_2__GPIO1_IO02 0x80000000
>  			>;
>  		};
>  	};
> -- 
> 1.9.0
> 
> 
