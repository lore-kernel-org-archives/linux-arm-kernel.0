From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 27 Nov 2017 18:15:25 -0200
Subject: [PATCH 01/13] ARM: dts: imx6qdl: SolidRun: remove redundant
 regulators node
In-Reply-To: <E1eJMdd-0002qR-Or@rmk-PC.armlinux.org.uk>
References: <20171127165134.GH31757@n2100.armlinux.org.uk>
 <E1eJMdd-0002qR-Or@rmk-PC.armlinux.org.uk>
Message-ID: <CAOMZO5B9GW26+3EfutnH4meUec3qq09Q6OBYHTtdvWG+DavJwg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 27, 2017 at 2:52 PM, Russell King
<rmk+kernel@armlinux.org.uk> wrote:

> -               };
> +       reg_usbh1_vbus: usb-h1-vbus {
> +               compatible = "regulator-fixed";
> +               enable-active-high;
> +               gpio = <&gpio1 0 0>;

gpio = <&gpio1 0 GPIO_ACTIVE_HIGH>; would be easier to read.

> +       reg_usbotg_vbus: usb-otg-vbus {
> +               compatible = "regulator-fixed";
> +               enable-active-high;
> +               gpio = <&gpio3 22 0>;

Ditto.

> +       reg_brcm: brcm-reg {
> +               compatible = "regulator-fixed";
> +               enable-active-high;
> +               gpio = <&gpio3 19 0>;

Ditto.
