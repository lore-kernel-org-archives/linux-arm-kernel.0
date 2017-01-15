From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 15 Jan 2017 00:11:21 -0200
Subject: [PATCH RFC v2 4/4] ARM: dts: imx6*-hummingboard2: convert to more
 conventional vmmc-supply
In-Reply-To: <E1cS36q-0002wW-C3@rmk-PC.armlinux.org.uk>
References: <20170113144449.GQ14217@n2100.armlinux.org.uk>
 <E1cS36q-0002wW-C3@rmk-PC.armlinux.org.uk>
Message-ID: <CAOMZO5CUcEWiMpwbgYwcVgZkh41ET3J9E-LQBfc7bmFEGUCvpw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 13, 2017 at 12:45 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:

> +       reg_usdhc2_vmmc: reg-usdhc2-vmmc {
> +               compatible = "regulator-fixed";
> +               gpio = <&gpio4 30 GPIO_ACTIVE_HIGH>;
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&pinctrl_hummingboard2_vmmc>;
> +               regulator-boot-on;
> +               regulator-max-microvolt = <3300000>;
> +               regulator-min-microvolt = <3300000>;
> +               regulator-name = "usdhc2_vmmc";
> +               startup-delay-us = <1000>;
> +       };
> +
>         sound-sgtl5000 {
>                 audio-codec = <&sgtl5000>;
>                 audio-routing =
> @@ -393,7 +400,6 @@
>
>                 pinctrl_hummingboard2_usdhc2_aux: hummingboard2-usdhc2-aux {
>                         fsl,pins = <
> -                               MX6QDL_PAD_GPIO_4__GPIO1_IO04    0x1f071
>                                 MX6QDL_PAD_KEY_ROW1__SD2_VSELECT 0x1b071
>                                 MX6QDL_PAD_DISP0_DAT9__GPIO4_IO30 0x1b0b0
>                         >;
> @@ -432,6 +438,12 @@
>                         >;
>                 };
>
> +               pinctrl_hummingboard2_vmmc: hummingboard2-vmmc {
> +                       fsl,pins = <
> +                               MX6QDL_PAD_GPIO_4__GPIO1_IO04    0x1f071

Shouldn't this be gpio4 30 instead?

> +                       >;
> +               };
> +
>                 pinctrl_hummingboard2_usdhc3: hummingboard2-usdhc3 {
>                         fsl,pins = <
>                                 MX6QDL_PAD_SD3_CMD__SD3_CMD    0x17059
> @@ -519,7 +531,7 @@
>                 &pinctrl_hummingboard2_usdhc2_aux
>                 &pinctrl_hummingboard2_usdhc2_200mhz
>         >;
> -       mmc-pwrseq = <&usdhc2_pwrseq>;
> +       vmmc-supply = <&reg_usdhc2_vmmc>;
>         cd-gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;

as gpio1 4 seems to be used as card detect.
