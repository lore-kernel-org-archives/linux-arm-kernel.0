From: tony@atomide.com (Tony Lindgren)
Date: Fri, 21 Nov 2014 15:53:13 -0800
Subject: [PATCH] ARM: Gumstix DuoVero: Bind vdac regulator to hdmi node
In-Reply-To: <1415901873-5304-1-git-send-email-adam.yh.lee@gmail.com>
References: <1415901873-5304-1-git-send-email-adam.yh.lee@gmail.com>
Message-ID: <20141121235312.GD7046@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Adam YH Lee <adam.yh.lee@gmail.com> [141113 10:06]:
> The HDMI node does not have a power supply attached. As a result its
> power regulator, VDAC, shuts off on boot and screen loses signal.
> This attaches VDAC (vdda_hdmi_dac) to HDMI's vdda-supply.

Applying into omap-for-v3.19/dt-v2 thanks.

Tony
 
> Signed-off-by: Adam YH Lee <adam.yh.lee@gmail.com>
> ---
>  arch/arm/boot/dts/omap4-duovero-parlor.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/omap4-duovero-parlor.dts b/arch/arm/boot/dts/omap4-duovero-parlor.dts
> index 6dc84d9..1a78f01 100644
> --- a/arch/arm/boot/dts/omap4-duovero-parlor.dts
> +++ b/arch/arm/boot/dts/omap4-duovero-parlor.dts
> @@ -177,6 +177,7 @@
>  
>  &hdmi {
>  	status = "ok";
> +	vdda-supply = <&vdac>;
>  
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&dss_hdmi_pins>;
> -- 
> 1.9.1
> 
