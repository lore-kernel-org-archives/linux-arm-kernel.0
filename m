From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Thu, 23 May 2013 16:01:14 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gQVJNOiBkdHM6IGlteDogZml4IGNsb2NrcyBmb3IgY3Nw?=
 =?UTF-8?B?aQ==?=
In-Reply-To: <1369309085-31146-1-git-send-email-jonas@microbit.se>
References: <1369309085-31146-1-git-send-email-jonas@microbit.se>
Message-ID: <1369310474.965158503@f320.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> The CSPI controller has only one clock, but the driver spi-imx.c needs clock "per" to calculate bitrate divisor.
> 
> Signed-off-by: Jonas Andersson <jonas@microbit.se>
> ---
>  arch/arm/boot/dts/imx25.dtsi | 12 ++++++------
>  arch/arm/boot/dts/imx27.dtsi |  6 +++---
>  arch/arm/boot/dts/imx51.dtsi |  2 +-
>  arch/arm/boot/dts/imx53.dtsi |  2 +-
>  4 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
> index d2550e0..7011539 100644
> --- a/arch/arm/boot/dts/imx25.dtsi
> +++ b/arch/arm/boot/dts/imx25.dtsi
> @@ -141,8 +141,8 @@
>  				#size-cells = <0>;
>  				compatible = "fsl,imx25-cspi", "fsl,imx35-cspi";
>  				reg = <0x43fa4000 0x4000>;
> -				clocks = <&clks 62>;
> -				clock-names = "ipg";
> +				clocks = <&clks 62>, <&clks 62>;
> +				clock-names = "ipg", "per";
>  				interrupts = <14>;
>  				status = "disabled";
>  			};

Why you do not use "dummy" clock for "per" here?
This variant will request/enable one clock two times.

---
