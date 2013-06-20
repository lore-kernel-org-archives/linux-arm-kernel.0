From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Thu, 20 Jun 2013 19:17:34 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCA0LzZdIEFSTTogZHRzOiBpbXgyNzogQWRkIDEtd2lyZQ==?=
In-Reply-To: <1371739815-6666-5-git-send-email-mpa@pengutronix.de>
References: <1371739815-6666-1-git-send-email-mpa@pengutronix.de>
 <1371739815-6666-5-git-send-email-mpa@pengutronix.de>
Message-ID: <1371741454.488712140@f66.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>  arch/arm/boot/dts/imx27.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
> index 044004a..e883e77 100644
> --- a/arch/arm/boot/dts/imx27.dtsi
> +++ b/arch/arm/boot/dts/imx27.dtsi
> @@ -110,6 +110,14 @@
>  				clock-names = "ipg", "per";
>  			};
>  
> +			owire: owire at 10009000 {
> +				compatible = "fsl,imx21-owire";

I think you should use "fsl,imx27-owire", "fsl,imx21-owire" here.

> +				reg = <0x10009000 0x1000>;
> +				clocks = <&clks 35>;
> +				clock-names = "ipg";
> +				status = "disabled";
> +			};
> +
>  			uart1: serial at 1000a000 {
>  				compatible = "fsl,imx27-uart", "fsl,imx21-uart";
>  				reg = <0x1000a000 0x1000>;
> -- 


---
