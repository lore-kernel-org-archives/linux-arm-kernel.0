From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 19 Dec 2017 15:10:17 -0200
Subject: [PATCH 2/6] ARM: dts: imx6: Add initial support for phyBOARD-Mira
In-Reply-To: <1513698588-13325-3-git-send-email-s.riedmueller@phytec.de>
References: <1513698588-13325-1-git-send-email-s.riedmueller@phytec.de>
 <1513698588-13325-3-git-send-email-s.riedmueller@phytec.de>
Message-ID: <CAOMZO5CSQSpPXTnR69HqHfKZiUpi+eqonqjuEu9mgBECsWG_5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 19, 2017 at 1:49 PM, Stefan Riedmueller
<s.riedmueller@phytec.de> wrote:

> +       reg_pcie: regulator-pcie {
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&pinctrl_pcie_reg>;
> +               compatible = "regulator-fixed";
> +               regulator-name = "mPCIe_1V5";
> +               regulator-min-microvolt = <1500000>;
> +               regulator-max-microvolt = <1500000>;
> +               gpio = <&gpio3 0 GPIO_ACTIVE_HIGH>;
> +               regulator-always-on;

Instead of using 'regulator-always-on' here, you could use:

vpcie-supply = <&reg_pcie>;

under the &pcie node

> +       panel {
> +               compatible = "auo,g104sn02";

I could not find this compatible in linux-next.

> +       i2c_rtc: rtc at 68 {
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&pinctrl_rtc_int>;
> +               compatible = "mc,rv4162";

I could not find this compatible in linux-next.

> +&pcie {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_pcie>;
> +       reset-gpio = <&gpio2 25 GPIO_ACTIVE_HIGH>;

The imx driver ignores the polarity and it is active high only when
'reset-gpio-active-high' property is present.

The correct here would be: reset-gpio = <&gpio2 25 GPIO_ACTIVE_LOW>;

> +&uart3 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_uart3>;
> +       fsl,uart-has-rtscts;

uart-has-rtscts, please.
