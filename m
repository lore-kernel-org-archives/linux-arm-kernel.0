From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Sun, 23 Jun 2013 20:59:52 +0200
Subject: [patch 1/1] imx53-qsb: enable usb power
In-Reply-To: <20130620212939.018670789@rtp-net.org>
References: <20130620212939.018670789@rtp-net.org>
Message-ID: <20130623185952.GA26397@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 20, 2013 at 11:29:30PM +0200, Arnaud Patard wrote:
> Enable usb power pin by using a fixed regulator. With this and the usb clock
> patch is making usb working on my loco.
> 
> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
> Index: linux-next/arch/arm/boot/dts/imx53-qsb.dts
> ===================================================================
> --- linux-next.orig/arch/arm/boot/dts/imx53-qsb.dts	2013-06-20 23:25:46.049428530 +0200
> +++ linux-next/arch/arm/boot/dts/imx53-qsb.dts	2013-06-20 23:26:34.293425920 +0200
> @@ -93,6 +93,15 @@
>  			regulator-max-microvolt = <3200000>;
>  			regulator-always-on;
>  		};
> +
> +		reg_usbpwr: usbpwr {
> +			compatible = "regulator-fixed";
> +			regulator-name = "usbpwr";
> +			regulator-min-microvolt = <5000000>;
> +			regulator-max-microvolt = <5000000>;
> +			gpio = <&gpio7 8 0>;
> +			regulator-always-on;
> +		};

Shouldn't this be provided to the chipidea driver as vbus?

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
