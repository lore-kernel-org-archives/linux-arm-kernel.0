From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 14 Apr 2016 16:32:38 +0300
Subject: [PATCH] ARM: dts: imx: ventana: add RS485 txen gpio support
In-Reply-To: <1460639949-26392-1-git-send-email-tharvey@gateworks.com>
References: <1460639949-26392-1-git-send-email-tharvey@gateworks.com>
Message-ID: <20160414133237.GE2092@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tim,

On Thu, Apr 14, 2016 at 06:19:09AM -0700, Tim Harvey wrote:
> The GW52xx/GW53xx/GW54xx have an on-board RS485 transceiver for half-duplex
> RS485 using uart1. The active-high TXEN is GPIO7__IO1 which we can configure
> as the rts-gpio as long as we specify it as active-low to invert the polarity
> managed by mctrl_gpio helpers. This allows for RS485 to be used from
> userspace by setting flags to SER_RS485_RTS_ON_SEND in the serial_rs485
> struct when using the TIOCGRS485 ioctl.

Do you use http://article.gmane.org/gmane.linux.ports.arm.kernel/482641 for 
that?

> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  arch/arm/boot/dts/imx6qdl-gw52xx.dtsi | 3 +++
>  arch/arm/boot/dts/imx6qdl-gw53xx.dtsi | 3 +++
>  arch/arm/boot/dts/imx6qdl-gw54xx.dtsi | 3 +++
>  3 files changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
> index 8cccc4a..50d6039 100644
> --- a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
> @@ -315,6 +315,8 @@
>  &uart1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_uart1>;
> +	fsl,uart-has-rtscts;
> +	rts-gpio = <&gpio7 1 GPIO_ACTIVE_LOW>;

See http://marc.info/?l=linux-serial&m=146063601520851&w=2.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
