From: notasas@gmail.com (Grazvydas Ignotas)
Date: Thu, 12 Feb 2015 19:47:41 +0200
Subject: [PATCH 1/4] ARM: dts: omap3-pandora: add common device tree
In-Reply-To: <1423746226-700-2-git-send-email-marek@goldelico.com>
References: <1423746226-700-1-git-send-email-marek@goldelico.com>
 <1423746226-700-2-git-send-email-marek@goldelico.com>
Message-ID: <CANOLnOMEJXSJcujdeG+6XXkU99yv7cSw115b+-NX+CPVVO_FVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 12, 2015 at 3:03 PM, Marek Belisko <marek@goldelico.com> wrote:
> From: "H. Nikolaus Schaller" <hns@goldelico.com>
>
> This device tree allows to boot, supports the panel,
> framebuffer, touch screen, as well as some more peripherals.
> Since there is a OMAP3530 based 600 MHz variant and a DM3730 based
> 1 GHz variant we must include this common device tree code
> in one of two CPU specific device trees.
>
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> Signed-off-by: Marek Belisko <marek@goldelico.com>
> ---
>  arch/arm/boot/dts/omap3-pandora-common.dtsi | 641 ++++++++++++++++++++++++++++
>  1 file changed, 641 insertions(+)
>  create mode 100644 arch/arm/boot/dts/omap3-pandora-common.dtsi
>
> diff --git a/arch/arm/boot/dts/omap3-pandora-common.dtsi b/arch/arm/boot/dts/omap3-pandora-common.dtsi
> new file mode 100644
> index 0000000..0a2a878
> --- /dev/null
> +++ b/arch/arm/boot/dts/omap3-pandora-common.dtsi
> @@ -0,0 +1,641 @@

...

> +
> +       gpio-leds {
> +
> +               compatible = "gpio-leds";
> +
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&led_pins>;
> +
> +               led at 1 {
> +                       label = "pandora::sd1";
> +                       gpios = <&gpio5 0 GPIO_ACTIVE_HIGH>;    /* GPIO_128 */
> +                       linux,default-trigger = "mmc0";
> +                       default-state = "off";
> +               };
> +
> +               led at 2 {
> +                       label = "pandora::sd2";
> +                       gpios = <&gpio5 1 GPIO_ACTIVE_HIGH>;    /* GPIO_129 */
> +                       linux,default-trigger = "mmc1";
> +                       default-state = "off";
> +               };
> +
> +               led at 3 {
> +                       label = "pandora::bluetooth";
> +                       gpios = <&gpio5 30 GPIO_ACTIVE_HIGH>;   /* GPIO_158 */
> +                       linux,default-trigger = "heartbeat";

I'd prefer this had no trigger, but no strong feelings here.

> +                       default-state = "off";
> +               };
> +
> +               led at 4 {
> +                       label = "pandora::wifi";
> +                       gpios = <&gpio5 31 GPIO_ACTIVE_HIGH>;   /* GPIO_159 */
> +                       linux,default-trigger = "mmc2";
> +                       default-state = "off";
> +               };
> +       };
> +
> +       gpio-keys {
> +               compatible = "gpio-keys";
> +
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&button_pins>;
> +
> +               up-button {
> +                       label = "up";
> +                       linux,code = <KEY_UP>;
> +                       gpios = <&gpio4 14 GPIO_ACTIVE_HIGH>;   /* GPIO_110 */
> +                       gpio-key,wakeup;
> +               };
> +
> +               down-button {
> +                       label = "down";
> +                       linux,code = <KEY_DOWN>;
> +                       gpios = <&gpio4 7 GPIO_ACTIVE_HIGH>;    /* GPIO_103 */
> +                       gpio-key,wakeup;
> +               };
> +
> +               left-button {
> +                       label = "left";
> +                       linux,code = <KEY_LEFT>;
> +                       gpios = <&gpio4 0 GPIO_ACTIVE_HIGH>;    /* GPIO_96 */
> +                       gpio-key,wakeup;
> +               };
> +
> +               right-button {
> +                       label = "right";
> +                       linux,code = <KEY_RIGHT>;
> +                       gpios = <&gpio4 2 GPIO_ACTIVE_HIGH>;    /* GPIO_98 */
> +                       gpio-key,wakeup;
> +               };
> +
> +               pageup-button {
> +                       label = "game 1";
> +                       linux,code = <KEY_PAGEUP>;
> +                       gpios = <&gpio4 13 GPIO_ACTIVE_HIGH>;   /* GPIO_109 */
> +                       gpio-key,wakeup;
> +               };
> +
> +               pagedown-button {
> +                       label = "game 3";
> +                       linux,code = <KEY_PAGEDOWN>;
> +                       gpios = <&gpio4 10 GPIO_ACTIVE_HIGH>;   /* GPIO_106 */
> +                       gpio-key,wakeup;
> +               };
> +
> +               home-button {
> +                       label = "game 4";
> +                       linux,code = <KEY_HOME>;
> +                       gpios = <&gpio4 5 GPIO_ACTIVE_HIGH>;    /* GPIO_101 */
> +                       gpio-key,wakeup;
> +               };
> +
> +               end-button {
> +                       label = "game 2";
> +                       linux,code = <KEY_END>;
> +                       gpios = <&gpio4 15 GPIO_ACTIVE_HIGH>;   /* GPIO_111 */
> +                       gpio-key,wakeup;
> +               };
> +
> +               right-shift {
> +                       label = "l";
> +                       linux,code = <KEY_RIGHTSHIFT>;
> +                       gpios = <&gpio4 6 GPIO_ACTIVE_HIGH>;    /* GPIO_102 */
> +                       gpio-key,wakeup;
> +               };
> +
> +               kp-plus {
> +                       label = "l2";
> +                       linux,code = <KEY_KPPLUS>;
> +                       gpios = <&gpio4 1 GPIO_ACTIVE_HIGH>;    /* GPIO_97 */
> +                       gpio-key,wakeup;
> +               };
> +
> +               right-ctrl {
> +                       label = "r";
> +                       linux,code = <KEY_RIGHTCTRL>;
> +                       gpios = <&gpio4 9 GPIO_ACTIVE_HIGH>;    /* GPIO_105 */
> +                       gpio-key,wakeup;
> +               };
> +
> +               kp-minus {
> +                       label = "r2";
> +                       linux,code = <KEY_KPMINUS>;
> +                       gpios = <&gpio4 11 GPIO_ACTIVE_HIGH>;   /* GPIO_107 */
> +                       gpio-key,wakeup;
> +               };
> +
> +               left-ctrl {
> +                       label = "ctrl";
> +                       linux,code = <KEY_LEFTCTRL>;
> +                       gpios = <&gpio4 8 GPIO_ACTIVE_HIGH>;    /* GPIO_104 */
> +                       gpio-key,wakeup;
> +               };
> +
> +               menu {
> +                       label = "menu";
> +                       linux,code = <KEY_MENU>;
> +                       gpios = <&gpio4 3 GPIO_ACTIVE_HIGH>;    /* GPIO_99 */
> +                       gpio-key,wakeup;
> +               };
> +
> +               hold {
> +                       label = "hold";
> +                       linux,code = <KEY_COFFEE>;
> +                       gpios = <&gpio6 16 GPIO_ACTIVE_HIGH>;   /* GPIO_176 */
> +                       gpio-key,wakeup;
> +               };
> +
> +               left-alt {
> +                       label = "alt";
> +                       linux,code = <KEY_LEFTALT>;
> +                       gpios = <&gpio4 4 GPIO_ACTIVE_HIGH>;    /* GPIO_100 */
> +                       gpio-key,wakeup;
> +               };
> +
> +               lid {
> +                       label = "lid";
> +                       linux,code = <0x00>;    /* SW_LID lid shut */
> +                       linux,input-type = <0x05>;    /* EV_SW */
> +                       gpios = <&gpio4 12 GPIO_ACTIVE_HIGH>;   /* GPIO_108 */
> +                       gpio-key,wakeup;
> +               };

This is not right, all button GPIOs are active low except GPIO_100,
which is active high. GPIO_108 should not have the wakeup flag set
because lid switch power is normally cut during low power modes.

...

> +
> +       dss_dpi_pins: pinmux_dss_dpi_pins {
> +               pinctrl-single,pins = <
> +                       OMAP3_CORE1_IOPAD(0x20d4, PIN_OUTPUT | MUX_MODE0)       /* dss_pclk.dss_pclk */
> +                       OMAP3_CORE1_IOPAD(0x20d6, PIN_OUTPUT | MUX_MODE0)       /* dss_hsync.dss_hsync */
> +                       OMAP3_CORE1_IOPAD(0x20d8, PIN_OUTPUT | MUX_MODE0)       /* dss_vsync.dss_vsync */
> +                       OMAP3_CORE1_IOPAD(0x20da, PIN_OUTPUT | MUX_MODE0)       /* dss_acbias.dss_acbias */
> +                       OMAP3_CORE1_IOPAD(0x20dc, PIN_OUTPUT | MUX_MODE0)       /* dss_data0.dss_data0 */
> +                       OMAP3_CORE1_IOPAD(0x20de, PIN_OUTPUT | MUX_MODE0)       /* dss_data1.dss_data1 */
> +                       OMAP3_CORE1_IOPAD(0x20e0, PIN_OUTPUT | MUX_MODE0)       /* dss_data2.dss_data2 */
> +                       OMAP3_CORE1_IOPAD(0x20e2, PIN_OUTPUT | MUX_MODE0)       /* dss_data3.dss_data3 */
> +                       OMAP3_CORE1_IOPAD(0x20e4, PIN_OUTPUT | MUX_MODE0)       /* dss_data4.dss_data4 */
> +                       OMAP3_CORE1_IOPAD(0x20e6, PIN_OUTPUT | MUX_MODE0)       /* dss_data5.dss_data5 */
> +                       OMAP3_CORE1_IOPAD(0x20e8, PIN_OUTPUT | MUX_MODE0)       /* dss_data6.dss_data6 */
> +                       OMAP3_CORE1_IOPAD(0x20ea, PIN_OUTPUT | MUX_MODE0)       /* dss_data7.dss_data7 */
> +                       OMAP3_CORE1_IOPAD(0x20ec, PIN_OUTPUT | MUX_MODE0)       /* dss_data8.dss_data8 */
> +                       OMAP3_CORE1_IOPAD(0x20ee, PIN_OUTPUT | MUX_MODE0)       /* dss_data9.dss_data9 */
> +                       OMAP3_CORE1_IOPAD(0x20f0, PIN_OUTPUT | MUX_MODE0)       /* dss_data10.dss_data10 */
> +                       OMAP3_CORE1_IOPAD(0x20f2, PIN_OUTPUT | MUX_MODE0)       /* dss_data11.dss_data11 */
> +                       OMAP3_CORE1_IOPAD(0x20f4, PIN_OUTPUT | MUX_MODE0)       /* dss_data12.dss_data12 */
> +                       OMAP3_CORE1_IOPAD(0x20f6, PIN_OUTPUT | MUX_MODE0)       /* dss_data13.dss_data13 */
> +                       OMAP3_CORE1_IOPAD(0x20f8, PIN_OUTPUT | MUX_MODE0)       /* dss_data14.dss_data14 */
> +                       OMAP3_CORE1_IOPAD(0x20fa, PIN_OUTPUT | MUX_MODE0)       /* dss_data15.dss_data15 */
> +                       OMAP3_CORE1_IOPAD(0x20fc, PIN_OUTPUT | MUX_MODE0)       /* dss_data16.dss_data16 */
> +                       OMAP3_CORE1_IOPAD(0x20fe, PIN_OUTPUT | MUX_MODE0)       /* dss_data17.dss_data17 */
> +                       OMAP3_CORE1_IOPAD(0x2100, PIN_OUTPUT | MUX_MODE0)       /* dss_data18.dss_data18 */
> +                       OMAP3_CORE1_IOPAD(0x2102, PIN_OUTPUT | MUX_MODE0)       /* dss_data19.dss_data19 */
> +                       OMAP3_CORE1_IOPAD(0x2104, PIN_OUTPUT | MUX_MODE0)       /* dss_data20.dss_data20 */
> +                       OMAP3_CORE1_IOPAD(0x2106, PIN_OUTPUT | MUX_MODE0)       /* dss_data21.dss_data21 */
> +                       OMAP3_CORE1_IOPAD(0x2108, PIN_OUTPUT | MUX_MODE0)       /* dss_data22.dss_data22 */
> +                       OMAP3_CORE1_IOPAD(0x210a, PIN_OUTPUT | MUX_MODE0)       /* dss_data23.dss_data23 */
> +                       OMAP3_CORE1_IOPAD(0x218e, PIN_OUTPUT | MUX_MODE4)       /* GPIO_157 = lcd reset */
> +               >;
> +       };
> +
> +       uart3_pins: pinmux_uart3_pins {
> +               pinctrl-single,pins = <
> +                       OMAP3_CORE1_IOPAD(0x219e, PIN_INPUT | PIN_OFF_WAKEUPENABLE | MUX_MODE0) /* uart3_rx_irrx.uart3_rx_irrx */
> +                       OMAP3_CORE1_IOPAD(0x21a0, PIN_OUTPUT | MUX_MODE0) /* uart3_tx_irtx.uart3_tx_irtx */
> +               >;
> +       };
> +
> +       led_pins: pinmux_leds_pins {
> +               pinctrl-single,pins = <
> +                       OMAP3_CORE1_IOPAD(0x2154, PIN_OUTPUT | MUX_MODE4)       /* GPIO_128 */
> +                       OMAP3_CORE1_IOPAD(0x2156, PIN_OUTPUT | MUX_MODE4)       /* GPIO_129 */
> +                       OMAP3_CORE1_IOPAD(0x2190, PIN_OUTPUT | MUX_MODE4)       /* GPIO_158 */
> +                       OMAP3_CORE1_IOPAD(0x2192, PIN_OUTPUT | MUX_MODE4)       /* GPIO_159 */
> +               >;
> +       };
> +
> +       button_pins: pinmux_button_pins {
> +               pinctrl-single,pins = <
> +                       OMAP3_CORE1_IOPAD(0x2110, PIN_INPUT_PULLUP | MUX_MODE4)        /* GPIO_96 */
> +                       OMAP3_CORE1_IOPAD(0x2112, PIN_INPUT_PULLUP | MUX_MODE4)        /* GPIO_97 */
> +                       OMAP3_CORE1_IOPAD(0x2114, PIN_INPUT_PULLUP | MUX_MODE4)        /* GPIO_98 */
> +                       OMAP3_CORE1_IOPAD(0x2116, PIN_INPUT_PULLUP | MUX_MODE4)        /* GPIO_99 */
> +                       OMAP3_CORE1_IOPAD(0x2118, PIN_INPUT_PULLUP | MUX_MODE4)        /* GPIO_100 */
> +                       OMAP3_CORE1_IOPAD(0x211a, PIN_INPUT_PULLUP | MUX_MODE4)        /* GPIO_101 */
> +                       OMAP3_CORE1_IOPAD(0x211c, PIN_INPUT_PULLUP | MUX_MODE4)        /* GPIO_102 */
> +                       OMAP3_CORE1_IOPAD(0x211e, PIN_INPUT_PULLUP | MUX_MODE4)        /* GPIO_103 */
> +                       OMAP3_CORE1_IOPAD(0x2120, PIN_INPUT_PULLUP | MUX_MODE4)        /* GPIO_104 */
> +                       OMAP3_CORE1_IOPAD(0x2122, PIN_INPUT_PULLUP | MUX_MODE4)        /* GPIO_105 */
> +                       OMAP3_CORE1_IOPAD(0x2124, PIN_INPUT_PULLUP | MUX_MODE4)        /* GPIO_106 */
> +                       OMAP3_CORE1_IOPAD(0x2126, PIN_INPUT_PULLUP | MUX_MODE4)        /* GPIO_107 */
> +                       OMAP3_CORE1_IOPAD(0x2128, PIN_INPUT_PULLUP | MUX_MODE4)        /* GPIO_108 */
> +                       OMAP3_CORE1_IOPAD(0x212a, PIN_INPUT_PULLUP | MUX_MODE4)        /* GPIO_109 */
> +                       OMAP3_CORE1_IOPAD(0x212c, PIN_INPUT_PULLUP | MUX_MODE4)        /* GPIO_110 */
> +                       OMAP3_CORE1_IOPAD(0x212e, PIN_INPUT_PULLUP | MUX_MODE4)        /* GPIO_111 */
> +                       OMAP3_CORE1_IOPAD(0x21d2, PIN_INPUT_PULLUP | MUX_MODE4)        /* GPIO_176 */

We should not set pullups for all the buttons, they all have external pullups.

> +               >;
> +       };
> +
> +       penirq_pins: pinmux_penirq_pins {
> +               pinctrl-single,pins = <
> +                       /* here we could enable to wakeup the cpu from suspend by a pen touch */
> +                       OMAP3_CORE1_IOPAD(0x210c, PIN_INPUT_PULLUP | MUX_MODE4) /* GPIO_94 */

Again, we already have external pullup, no need to waste power.

...

> +
> +&mmc1 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&mmc1_pins>;
> +       vmmc-supply = <&vmmc1>;
> +       bus-width = <4>;
> +       cd-gpios = <&twl_gpio 0 GPIO_ACTIVE_LOW>;
> +       wp-gpios = <&gpio4 30 GPIO_ACTIVE_LOW>; /* GPIO_126 */

Large number of pandoras have defective write potect pins. Kernel used
to not support write protect at all, so we noticed it too late. If
it's possible to omit this it would be better do so, perhaps with a
comment, or I can send a patch later...

> +};
> +
> +&mmc2 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&mmc2_pins>;
> +       vmmc-supply = <&vmmc2>;
> +       bus-width = <4>;
> +       cd-gpios = <&twl_gpio 1 GPIO_ACTIVE_HIGH>;
> +       wp-gpios = <&gpio4 31 GPIO_ACTIVE_LOW>; /* GPIO_127 */

same here


Gra?vydas
