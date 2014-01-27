From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 27 Jan 2014 09:51:06 +0100
Subject: [PATCH 2/2] ARM: dts: imx6: edmqmx6: remove wrong gpio in
 usb_otg_vbus regulator
In-Reply-To: <1390419567-2643-3-git-send-email-silvio.fricke@gmail.com>
References: <1390419567-2643-1-git-send-email-silvio.fricke@gmail.com>
 <1390419567-2643-3-git-send-email-silvio.fricke@gmail.com>
Message-ID: <20140127085106.GW16215@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 22, 2014 at 08:39:27PM +0100, Silvio F wrote:
> Signed-off-by: Silvio F <silvio.fricke@gmail.com>
> ---
>  arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts b/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
> index 6706d1b..de54e46 100644
> --- a/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
> +++ b/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
> @@ -46,7 +46,6 @@
>  			regulator-name = "usb_otg_vbus";
>  			regulator-min-microvolt = <5000000>;
>  			regulator-max-microvolt = <5000000>;
> -			gpio = <&gpio7 12 0>;

This gpio drives a switch between SoCs USB D+/D- lines and the external
connector, so using a regulator here is the wrong approach. The question
now is: What is the correct approach to make sure the switch is closed
when needed? How does it work now? Is the switch on by reset default?

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
