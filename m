From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 16 Oct 2017 15:51:57 -0200
Subject: [PATCH] ARM: dts: imx: add ZII RDU1 board
In-Reply-To: <20171016165540.917-1-l.stach@pengutronix.de>
References: <20171016165540.917-1-l.stach@pengutronix.de>
Message-ID: <CAOMZO5Bub-TrF-X+s-N_tVy5mtCb=_m35U0stvmFHh4GeU0mAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lucas,

On Mon, Oct 16, 2017 at 2:55 PM, Lucas Stach <l.stach@pengutronix.de> wrote:

> +       disp0 {
> +               compatible = "fsl,imx-parallel-display";
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&pinctrl_ipu_disp1>;
> +
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               port at 0 {
> +                       reg = <0>;
> +
> +                       display_in: endpoint {
> +                               remote-endpoint = <&ipu_di0_disp0>;

Please use ipu_di0_disp1 instead as done in this recent commit:
https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git/commit/?h=imx/dt&id=f7059428ec1b16785bdc2a70e056ef20f3a8df41

> +       usbh1phy: usbphy at 1 {

This will give a warning when building with W=1 as a unit-address is
passed without its corresponding reg node.

You could simply remove the @1.

> +               compatible = "usb-nop-xceiv";
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&pinctrl_usbh1phy>;
> +               clocks = <&clk_26M_usb>;
> +               clock-names = "main_clk";
> +               reset-gpios = <&gpio4 8 GPIO_ACTIVE_LOW>;
> +               vcc-supply = <&vusb_reg>;
> +       };
> +
> +       usbh2phy: usbphy at 2 {

Ditto.

> +&ecspi1 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_ecspi1>;
> +       fsl,spi-num-chipselects = <2>;

This is an obsolete property, please remove it.
