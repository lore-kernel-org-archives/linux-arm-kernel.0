From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Wed, 16 Apr 2014 10:37:31 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gQVJNOiBkdHM6IGlteDI3LXBkazogQWRkIFBNSUMgc3Vw?=
 =?UTF-8?B?cG9ydA==?=
In-Reply-To: <1397598912-5464-1-git-send-email-festevam@gmail.com>
References: <1397598912-5464-1-git-send-email-festevam@gmail.com>
Message-ID: <1397630251.213119658@f389.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tue, 15 Apr 2014 18:55:12 -0300 ?? Fabio Estevam <festevam@gmail.com>:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> imx27-pdk has a MC13783 PMIC connected to CSPI2 port.
> 
> Add support for it.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
...
>  &iomuxc {
>  	imx27-pdk {
> +		pinctrl_cspi2: cspi2grp {
> +			fsl,pins = <
> +				MX27_PAD_CSPI2_MISO__CSPI2_MISO 0x0
> +				MX27_PAD_CSPI2_MOSI__CSPI2_MOSI 0x0
> +				MX27_PAD_CSPI2_SCLK__CSPI2_SCLK 0x0
> +				MX27_PAD_CSPI2_SS0__GPIO4_21	0x0 /* SPI2 CS0 */
> +				MX27_PAD_TOUT__GPIO3_14		0x0 /* PMIC IRQ */
> +			>;
> +		};

IRQ GPIO should be in a separate pingroup for PMIC.

---
