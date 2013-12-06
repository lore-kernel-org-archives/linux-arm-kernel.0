From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Fri, 06 Dec 2013 14:11:45 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSHYyXVsgMi8yXSBBUk06IGR0czogQWRkIHN1cHBvcnQgZm9y?=
 =?UTF-8?B?IHRoZSBjcHVpbXg1MyBib2FyZCBmcm9tIEV1a3JlYSBhbmQgaXRzIGJhc2Vi?=
 =?UTF-8?B?b2FyZC4=?=
In-Reply-To: <1386323958-783-2-git-send-email-denis@eukrea.com>
References: <1386323958-783-1-git-send-email-denis@eukrea.com>
 <1386323958-783-2-git-send-email-denis@eukrea.com>
Message-ID: <1386324705.359638944@f208.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

> The following devices/functionalities were added:
>  * Main and secondary UARTs.
>  * i2c and the pcf8563 device.
>  * Ethernet.
>  * NAND.
>  * The BP1 button.
>  * The LED.
>  * Watchdog.
>  * SD.
>  * USB host.
...

> +		reg_3p3v: regulator at 0 {
> +			reg = <0>;
> +			compatible = "regulator-fixed";
> +			regulator-name = "3P3V";
> +			regulator-min-microvolt = <3300000>;
> +			regulator-max-microvolt = <3300000>;
> +			regulator-always-on;

"regulator-always-on" make no sense for virtual supplies.

...
> +		pinctrl_uart1: uart1grp {
> +			fsl,pins = <MX53_UART1_PINGRP2>;
> +		};
> +
> +		pinctrl_uart2: uart2grp {
> +			fsl,pins = <MX53_UART2_PINGRP2>;
> +		};
> +	};
> +};
> +
> +&uart1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart1>;
> +	fsl,uart-has-rtscts;

So if you use "fsl,uart-has-rtscts", should you add MX53_UART1_PINGRP3
into pinctls too?

---
