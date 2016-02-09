From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Tue, 9 Feb 2016 04:08:23 +0100
Subject: [PATCH v2 06/10] ARM64: dts: rockchip: Add IR receiver to GeekBox
In-Reply-To: <1454897859-7601-7-git-send-email-afaerber@suse.de>
References: <1454897859-7601-1-git-send-email-afaerber@suse.de>
 <1454897859-7601-7-git-send-email-afaerber@suse.de>
Message-ID: <56B95827.7060204@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 08.02.2016 um 03:17 schrieb Andreas F?rber:
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  v2: New
>  
>  arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts b/arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts
> index e4523a74050f..e84383fd6f10 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts
> @@ -63,6 +63,13 @@
>  		#clock-cells = <0>;
>  	};
>  
> +	ir: ir-receiver {
> +		compatible = "gpio-ir-receiver";
> +		gpios = <&gpio3 30 GPIO_ACTIVE_LOW>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&ir_int>;

		status = "disabled";

Should only be enabled in the new Landingship config. Will fix.

Andreas

P.S. See Heiko, two bugs in the new nodes already, glad I have them
separate. :)

> +	};
> +
>  	leds: gpio-leds {
>  		compatible = "gpio-leds";
>  
[snip]

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton; HRB 21284 (AG N?rnberg)
