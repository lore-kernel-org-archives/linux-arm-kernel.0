From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 16 Jun 2017 00:41:48 -0300
Subject: [PATCH] ARM: dts: imx6qdl-wandboard: enable USB OTG
In-Reply-To: <1497508870-4028-1-git-send-email-akurz@blala.de>
References: <1497508870-4028-1-git-send-email-akurz@blala.de>
Message-ID: <CAOMZO5ASN-TGfWKaL=4mZBAeyg8PmH-rnrTXN4ZtQaEkZRVxAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexander,

On Thu, Jun 15, 2017 at 3:41 AM, Alexander Kurz <akurz@blala.de> wrote:

> +
> +               reg_usb_otg_vbus: usb_otg_vbus {
> +                       compatible = "regulator-fixed";
> +                       regulator-name = "usb_otg_vbus";
> +                       regulator-min-microvolt = <5000000>;
> +                       regulator-max-microvolt = <5000000>;
> +                       pinctrl-names = "default";
> +                       pinctrl-0 = <&pinctrl_usbotgvbus>;
> +                       gpio = <&gpio3 22 GPIO_ACTIVE_HIGH>;

There is some inconsistency here:

If this regulator is driven by an active high GPIO then it needs the
'enable-active-high' property.

If 'enable-active-high' property is not passed and this VBUS is being
activated, then you should pass:
gpio = <&gpio3 22 GPIO_ACTIVE_LOW>;

Please double check.
