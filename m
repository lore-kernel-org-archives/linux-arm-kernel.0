From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Thu, 20 Jun 2013 19:28:08 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAxLzZdIEFSTTogbXgyNzogUmVwbGFjZSBjbGtfcmVnaXN0?=
 =?UTF-8?B?ZXJfY2xrZGV2IHdpdGggY2xvY2sgRFQgbG9va3Vw?=
In-Reply-To: <1371739815-6666-2-git-send-email-mpa@pengutronix.de>
References: <1371739815-6666-1-git-send-email-mpa@pengutronix.de>
 <1371739815-6666-2-git-send-email-mpa@pengutronix.de>
Message-ID: <1371742088.528552668@f66.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Similarly as it was done for mx6q, use a DT lookup in order to make maintainance
> task for the clock devices easier.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> [Markus Pargmann: Add gpio clocks]
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>  arch/arm/boot/dts/imx27.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
> index 0695264..48c263c 100644
> --- a/arch/arm/boot/dts/imx27.dtsi
> +++ b/arch/arm/boot/dts/imx27.dtsi
> @@ -208,6 +208,8 @@
>  				#gpio-cells = <2>;
>  				interrupt-controller;
>  				#interrupt-cells = <2>;
> +				clocks = <&clks 47>;
> +				clock-names = "ipg";

Clock is not used in the gpio driver, so I doubt the usefulness of this patch.

---
