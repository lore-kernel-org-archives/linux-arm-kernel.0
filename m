From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 19 Dec 2017 15:03:13 -0200
Subject: [PATCH 1/6] ARM: dts: imx6: Add initial support for phyCORE-i.MX
 6 SOM
In-Reply-To: <1513698588-13325-2-git-send-email-s.riedmueller@phytec.de>
References: <1513698588-13325-1-git-send-email-s.riedmueller@phytec.de>
 <1513698588-13325-2-git-send-email-s.riedmueller@phytec.de>
Message-ID: <CAOMZO5Do0G8nJ2LTq+u-JDL7ONCyyLvn2+kcLYyMnmBH1aGDmA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 19, 2017 at 1:49 PM, Stefan Riedmueller
<s.riedmueller@phytec.de> wrote:

> +
> +/ {
> +       model = "PHYTEC phyCORE-i.MX 6";
> +       compatible = "phytec,imx6qdl-pcm058", "fsl,imx6qdl";
> +
> +       aliases {
> +               ipu0 = &ipu1;

Is this alias needed?

> +               rtc1 = &da9062_rtc;
> +               rtc2 = &snvs_rtc;
> +       };
> +
> +       /*
> +        * Set the minimum memory size here and
> +        * let the bootloader set the real size.
> +        */
> +       memory {


memory at 10000000 so that you don't get warnings when building with W=1.

Also, please build W=1 and make sure to not introduce any build
warning in this series.

> +&i2c3 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_i2c3>;
> +       clock-frequency = <400000>;
> +       status = "okay";
> +
> +       eeprom: eeprom at 50 {
> +               compatible = "cat,24c32";

This compatible is not documented.
