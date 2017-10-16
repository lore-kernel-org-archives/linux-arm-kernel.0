From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 16 Oct 2017 09:17:26 +0200
Subject: [PATCH 3/4] ARM: dts: imx28-tx28: fix interrupt flags and use
 interrupts-extended property
In-Reply-To: <1507719939-27250-4-git-send-email-LW@KARO-electronics.de>
References: <1507719939-27250-1-git-send-email-LW@KARO-electronics.de>
 <1507719939-27250-4-git-send-email-LW@KARO-electronics.de>
Message-ID: <20171016071726.gyzvalxzk4o3jsuz@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Oct 11, 2017 at 01:05:38PM +0200, Lothar Wa?mann wrote:
> diff --git a/arch/arm/boot/dts/imx28-tx28.dts b/arch/arm/boot/dts/imx28-tx28.dts
> index 211e67d..3c852f7 100644
> --- a/arch/arm/boot/dts/imx28-tx28.dts
> +++ b/arch/arm/boot/dts/imx28-tx28.dts
> @@ -328,8 +328,7 @@
>  		reg = <0x20>;
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&tx28_pca9554_pins>;
> -		interrupt-parent = <&gpio3>;
> -		interrupts = <28 0>;
> +		interrupts-extended = <&gpio3 28 IRQ_TYPE_NONE>;
>  		gpio-controller;
>  		#gpio-cells = <2>;
>  		interrupt-controller;

While interrupts-extended looks nice,
Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
has:

	"interrupts-extended" should only be used when a device has
	multiple interrupt parents.

If this is still true, this patch is wrong.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
