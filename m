From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 1 Nov 2018 07:28:09 -0300
Subject: [PATCH V3 09/10] dts: fsl: add imx7ulp evk support
In-Reply-To: <1540996688-23681-10-git-send-email-aisheng.dong@nxp.com>
References: <1540996688-23681-1-git-send-email-aisheng.dong@nxp.com>
 <1540996688-23681-10-git-send-email-aisheng.dong@nxp.com>
Message-ID: <CAOMZO5AZejEAHeB0hQ9T5U2ZJ7MXK=BYm8jY+yyZjbDHo4utGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dong,

On Wed, Oct 31, 2018 at 11:46 AM A.s. Dong <aisheng.dong@nxp.com> wrote:

> +       reg_vsd_3v3: regulator-vsd-3v3 {
> +               compatible = "regulator-fixed";
> +               regulator-name = "VSD_3V3";
> +               regulator-min-microvolt = <3300000>;
> +               regulator-max-microvolt = <3300000>;
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&pinctrl_usdhc0_rst>;
> +               gpio = <&gpio_ptd 0 GPIO_ACTIVE_HIGH>;
> +               enable-active-high;

You model this as a regulator...

> +&usdhc0 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_usdhc0>;
> +       cd-gpios = <&gpio_ptc 10 GPIO_ACTIVE_LOW>;
> +       vmmc-supply = <&reg_vsd_3v3>;

but as this pins controls the reset of the SD port it seems that using
mmc-pwrseq would be more appropriate.

This way you could pass 'reset-gpios' inside the pwrseq node, which
would describe the hardware more accurately.
