From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Sat, 30 Aug 2014 19:36:28 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gYXBmMjdkZXY6IGFkZCBtYXgxMDI3IGluIHRoZSBkdHM=?=
In-Reply-To: <1409404932-12532-1-git-send-email-tremyfr@gmail.com>
References: <1409404932-12532-1-git-send-email-tremyfr@gmail.com>
Message-ID: <1409412988.93020165@f362.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sat, 30 Aug 2014 15:22:12 +0200 ?? Philippe Reynes <tremyfr@gmail.com>:
> 
> Signed-off-by: Philippe Reynes <tremyfr@gmail.com>
> ---
>  arch/arm/boot/dts/imx27-apf27dev.dts |   20 ++++++++++++++++++++
>  1 files changed, 20 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx27-apf27dev.dts b/arch/arm/boot/dts/imx27-apf27dev.dts
> index b982309..25b9ecd 100644
> --- a/arch/arm/boot/dts/imx27-apf27dev.dts
> +++ b/arch/arm/boot/dts/imx27-apf27dev.dts
> @@ -82,6 +82,19 @@
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_cspi1 &pinctrl_cspi1_cs>;
>  	status = "okay";
> +
> +	adc at 0 {
> +		compatible = "maxim,max1027";
> +		reg = <0>;
> +		interrupt-parent = <&gpio5>;
> +		interrupts = <15 IRQ_TYPE_EDGE_FALLING>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_max1027>;
> +		/* SPI mode = 0 */
> +		spi-cpol = <0>;
> +		spi-cpha = <0>;

Mode0 is default.
Afaik you not need to specify SPOL & SPHA for this. Is not it?

---
