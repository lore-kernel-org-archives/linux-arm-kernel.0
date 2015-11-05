From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 5 Nov 2015 01:23:19 +0100
Subject: [PATCH 3/4] ARM: dts: kirkwood: add Seagate GoFlex Home
In-Reply-To: <00000150d49a8745-1c2bc8d4-1333-46bb-bf0e-5508ef988c73-000000@email.amazonses.com>
References: <1446675888-24495-1-git-send-email-luka.perkov@sartura.hr>
 <00000150d49a8745-1c2bc8d4-1333-46bb-bf0e-5508ef988c73-000000@email.amazonses.com>
Message-ID: <20151105002319.GA8942@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +	chosen {
> +		bootargs = "console=ttyS0,115200n8 earlyprintk root=/dev/sda1 rootdelay=10";

It is not normal to specify the root device. Is this really required?
And rootdelay is also unusual.

> +		stdout-path = &uart0;
> +	};
> +
> +	ocp at f1000000 {
> +		pinctrl: pin-controller at 10000 {
> +			pmx_usb_power_enable: pmx-usb-power-enable {
> +				marvell,pins = "mpp29";
> +				marvell,function = "gpio";
> +			};
> +			pmx_led_white: pmx-led-white {
> +				marvell,pins = "mpp40";
> +				marvell,function = "gpio";
> +			};
> +			pmx_led_green: pmx-led_green {
> +				marvell,pins = "mpp46";

That last _ should be -..

> +				marvell,function = "gpio";
> +			};
> +			pmx_led_orange: pmx-led-orange {
> +				marvell,pins = "mpp47";
> +				marvell,function = "gpio";
> +			};
> +		};
> +		serial at 12000 {
> +			status = "ok";
> +		};
> +
> +		sata at 80000 {
> +			status = "okay";
> +			nr-ports = <2>;
> +		};
> +
> +	};
> +	gpio-leds {
> +		compatible = "gpio-leds";
> +
> +		health {
> +			label = "status:green:health";

This does not fit the naming convention. status should be the machine
name.

	Andrew
