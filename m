From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Fri, 28 Jun 2013 19:10:06 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2MyAyLzVdIEFSTTogZHRzOiBpbXgyNzogQWRkIGlteCBm?=
 =?UTF-8?B?cmFtZWJ1ZmZlciBkZXZpY2U=?=
In-Reply-To: <1372431037-13519-3-git-send-email-mpa@pengutronix.de>
References: <1372431037-13519-1-git-send-email-mpa@pengutronix.de>
 <1372431037-13519-3-git-send-email-mpa@pengutronix.de>
Message-ID: <1372432206.785926201@f326.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>  arch/arm/boot/dts/imx27.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
> index 8603886..10dcbd3 100644
> --- a/arch/arm/boot/dts/imx27.dtsi
> +++ b/arch/arm/boot/dts/imx27.dtsi
> @@ -342,6 +342,15 @@
>  			reg = <0x10020000 0x20000>;
>  			ranges;
>  
> +			imxfb: fb at 10021000 {

If it can be fixed while applying, it would be right to use just "fb" here.
We now use a lot of devices without "imx"-prefix, so I do not see any need to use it here.

> +				compatible = "fsl,imx27-fb", "fsl,imx21-fb";
> +				interrupts = <61>;
> +				reg = <0x10021000 0x1000>;
> +				clocks = <&clks 36>, <&clks 65>, <&clks 59>;
> +				clock-names = "ipg", "ahb", "per";
> +				status = "disabled";
> +			};
> +

---
