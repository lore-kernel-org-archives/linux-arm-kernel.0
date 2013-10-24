From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Thu, 24 Oct 2013 12:30:24 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2NCA2LzddIEFSTTogZHRzOiBpbXgyNyBwaHljb3JlIHBp?=
 =?UTF-8?B?bmN0cmw=?=
In-Reply-To: <1382601233-24253-7-git-send-email-mpa@pengutronix.de>
References: <1382601233-24253-1-git-send-email-mpa@pengutronix.de>
 <1382601233-24253-7-git-send-email-mpa@pengutronix.de>
Message-ID: <1382603424.519504719@f304.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Enable pinctrl for phycore devices.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
...
> diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-som.dts b/arch/arm/boot/dts/imx27-phytec-phycore-som.dts
> index 4ec402c..3dbdb5e 100644
> --- a/arch/arm/boot/dts/imx27-phytec-phycore-som.dts
> +++ b/arch/arm/boot/dts/imx27-phytec-phycore-som.dts
...
>  &uart1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart1_1 &pinctrl_uart1_rtscts_1>;
>  	status = "okay";
>  };

No. Please put RTS & CTS pins into RDK. There are no hardware dependencies for SOM.

---
