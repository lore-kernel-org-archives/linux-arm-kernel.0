From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Tue, 02 Jul 2013 20:27:49 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2MyA1LzVdIEFSTTogZHRzOiBBZGQgZGV2aWNlIHRyZWUg?=
 =?UTF-8?B?c3VwcG9ydCBmb3IgcGh5Y2FyZCBwY2ExMDA=?=
In-Reply-To: <1372431037-13519-6-git-send-email-mpa@pengutronix.de>
References: <1372431037-13519-1-git-send-email-mpa@pengutronix.de>
 <1372431037-13519-6-git-send-email-mpa@pengutronix.de>
Message-ID: <1372782469.486055292@f129.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Board files for Phytec phyCARD-S "System on Module" and "Rapid
> Development Kit".
> 
> Based on patches from:
> 
> Steffen Trumtrar <s.trumtrar@pengutronix.de>:
>  - Original patch
>  - ARM: dts: Set partition offsets for phycard
>  - ARM: dts: Use CSPI1 instead of CSPI2 on phycard pca100
>  - ARM: imx27-phytec-phycard-S.dts: resize nand partitions
...
> diff --git a/arch/arm/boot/dts/imx27-phytec-phycard-s-som.dts b/arch/arm/boot/dts/imx27-phytec-phycard-s-som.dts
...
> +&i2c1 {
> +	status = "okay";
> +
> +	ioexpander at 41 {
> +		compatible = "nxp,pca9536";
> +		reg = <0x41>;
> +	};
> +
> +	rtc at 51 {
> +		compatible = "nxp,pcf8563";
> +		reg = <0x51>;
> +	};
> +};
> +
> +&i2c2 {
> +	status = "okay";
> +
> +	lm75 at 4a {
> +		compatible = "national,lm75";
> +		reg = <0x4a>;
> +	};
> +
> +	rtc at 51 {
> +		compatible = "nxp,pcf8563";
> +		reg = <0x51>;
> +	};

Really two identical RTC on I2C1 & I2C2 or it is typo?

---
