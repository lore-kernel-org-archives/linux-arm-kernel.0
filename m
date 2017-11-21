From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 21 Nov 2017 14:54:10 -0200
Subject: [PATCH 2/4] ARM: dts: imx6qdl: Add Variscite DART-MX6 SoM support
In-Reply-To: <1511281705-30849-3-git-send-email-narmstrong@baylibre.com>
References: <1511281705-30849-1-git-send-email-narmstrong@baylibre.com>
 <1511281705-30849-3-git-send-email-narmstrong@baylibre.com>
Message-ID: <CAOMZO5BDQxZxHX_dn63QvbwfaVjERQtBqCp3FCT9Q6zvsrgn4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 21, 2017 at 2:28 PM, Neil Armstrong <narmstrong@baylibre.com> wrote:

> +       reg_wl18xx_vmmc: regulator-wl18xx {
> +               compatible = "regulator-fixed";
> +               regulator-name = "vwl1807";
> +               regulator-min-microvolt = <1800000>;
> +               regulator-max-microvolt = <1800000>;
> +               gpio = <&gpio7 8 0>;

GPIO_ACTIVE_HIGH please.

> +&can2 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_flexcan2>;
> +       status = "disabled";
> +};
> +
> +&cpu0 {
> +       arm-supply = <&sw1a_reg>;
> +       soc-supply = <&sw1c_reg>;
> +       operating-points = <
> +               /* kHz    uV */
> +               1200000 1350000
> +               996000  1250000
> +               852000  1250000
> +               792000  1175000
> +               396000  1175000
> +       >;
> +       fsl,soc-operating-points = <
> +               /* ARM kHz  SOC-PU uV */
> +               1200000 1275000
> +               996000  1250000
> +               852000  1250000
> +               792000  1175000
> +               396000  1175000
> +       >;


Don't the standard operating points described at imx6q.dtsi work on this board?

If not, please add a comment explaining why you need custom operating
points here.

> +       pinctrl_flexcan1: flexcan1grp {
> +               fsl,pins = <
> +                       MX6QDL_PAD_GPIO_7__FLEXCAN1_TX          0x80000000
> +                       MX6QDL_PAD_GPIO_8__FLEXCAN1_RX          0x80000000

Please avoid 0x80000000 and use the real IOMUX values instead.

> +               >;
> +       };
> +
> +       pinctrl_flexcan2: flexcan2grp {
> +               fsl,pins = <
> +                       MX6QDL_PAD_KEY_COL4__FLEXCAN2_TX        0x80000000
> +                       MX6QDL_PAD_KEY_ROW4__FLEXCAN2_RX        0x80000000

Please avoid 0x80000000 and use the real IOMUX values instead.
