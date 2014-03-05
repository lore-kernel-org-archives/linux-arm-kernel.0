From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 5 Mar 2014 19:42:28 +0800
Subject: [PATCH v2] ARM: dts: imx6qdl-sabresd.dtsi: Add red led
In-Reply-To: <1394007383-21874-1-git-send-email-vincent.stehle@freescale.com>
References: <20140305062216.GI8784@S2101-09.ap.freescale.net>
 <1394007383-21874-1-git-send-email-vincent.stehle@freescale.com>
Message-ID: <20140305114223.GN8784@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 05, 2014 at 09:16:23AM +0100, Vincent Stehl? wrote:
> Make the red gpio led available to the user.
> 
> This can be toggled with the sysfs for example, or used as a heartbeat or mmc
> activity light by changing the trigger.
> 
> Signed-off-by: Vincent Stehl? <vincent.stehle@freescale.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> 
> ---
> 
> Hi Shawn,
> 
> Thanks for your feedback.
> 
> If you don't want to make the led a heartbeat by default, here is v2 of the
> patch, which only makes the led available to the user. One is then free to use
> it as a heartbeat, or something else. Do you prefer it this way?
> 
> Best regards,
> 
> V.
> 
> 
> Changes since v1:
> - Do not make it a heartbeat by default.
> 
>  arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> index e75e11b..210a8df 100644
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
> +		red {
> +		        gpios = <&gpio1 2 0>;
> +		        linux,default-trigger = "none";

Per Documentation/devicetree/bindings/leds/common.txt, 'none' is not a
valid value of property 'linux,default-trigger'.  I suggest you simply
drop the property.

> +		        default-state = "on";
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

It's not a hog pin, so shouldn't be added here.  (Right, most of the
existing pins shouldn't be here from the beginning)

The patch from Liu Ying [1] could be a good example on this regard.

Shawn

[1] http://www.spinics.net/lists/arm-kernel/msg308999.html

>  			>;
>  		};
>  	};
> -- 
> 1.9.0
> 
> 
