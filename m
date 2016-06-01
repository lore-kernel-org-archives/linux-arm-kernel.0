From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 1 Jun 2016 10:15:30 -0300
Subject: [PATCH] ARM: dts: imx6: add support for Auvidea H100 board
In-Reply-To: <1464785229-27330-1-git-send-email-l.stach@pengutronix.de>
References: <1464785229-27330-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <CAOMZO5CQvhJTBN7iHD5dkiTCnFy=fVe9hd6CLOrDUR4K7JqyXA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lucas,

On Wed, Jun 1, 2016 at 9:47 AM, Lucas Stach <l.stach@pengutronix.de> wrote:

> +       reg_3p3v: regulator-3p3v {
> +               compatible = "regulator-fixed";
> +               regulator-name = "3P3V";
> +               regulator-min-microvolt = <3300000>;
> +               regulator-max-microvolt = <3300000>;
> +               regulator-always-on;

"regulator-always-on" can be removed in this case.

> +       };
> +
> +       reg_hdmi: regulator-hdmi {
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&pinctrl_h100_reg_hdmi>;
> +               compatible = "regulator-fixed";
> +               gpio = <&gpio2 20 0>;

It would be better to use the gpio label like:
gpio = <&gpio2 20 GPIO_ACTIVE_HIGH>;

,and since this is active high, the "enable-active-high" property is missing.

> +       reg_usbh1_vbus: regulator-usb-h1-vbus {
> +               compatible = "regulator-fixed";
> +               enable-active-high;
> +               gpio = <&gpio1 0 0>;

GPIO_ACTIVE_HIGH

> +               pinctrl-names = "default";
> +               pinctrl-0 = <&pinctrl_h100_usbh1_vbus>;
> +               regulator-name = "USB_H1_VBUS";
> +               regulator-min-microvolt = <5000000>;
> +               regulator-max-microvolt = <5000000>;
> +       };
> +
> +       reg_usbotg_vbus: regulator-usb-otg-vbus {
> +               compatible = "regulator-fixed";
> +               enable-active-high;
> +               gpio = <&gpio3 22 0>;

GPIO_ACTIVE_HIGH

> +
> +&iomuxc {
> +       h100 {

This h100 label can be removed and then you can remove one level of
indentation below.

> +               pinctrl_h100_hdmi: h100-hdmi {
> +                       fsl,pins = <
> +                               MX6QDL_PAD_KEY_ROW2__HDMI_TX_CEC_LINE   0x1f8b0
> +                       >;
> +               };
