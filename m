From: robertcnelson@gmail.com (Robert Nelson)
Date: Wed, 20 Jan 2016 10:32:45 -0600
Subject: [PATCH 2/2] ARM: dts: am33xx: add support for Ka-Ro electronics
 TX48-7020 module
In-Reply-To: <1453292992-1788-3-git-send-email-LW@KARO-electronics.de>
References: <1453292992-1788-1-git-send-email-LW@KARO-electronics.de>
 <1453292992-1788-3-git-send-email-LW@KARO-electronics.de>
Message-ID: <CAOCHtYhHiQmueqdxcvA48iC64eqq+Ey2gKNuwZjxaMYKeWPB-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +
> +&am33xx_pinmux {
> +       cpsw_default: cpsw_default {
> +               pinctrl-single,pins = <
> +                       /* Slave 1 */
> +                       0x10c (PIN_INPUT_PULLDOWN | MUX_MODE1)  /* mii1_crs.rmii1_crs_dv */
> +                       0x110 (PIN_INPUT_PULLDOWN | MUX_MODE1)  /* mii1_rxerr.rmii1_rxerr */
> +                       0x114 (PIN_OUTPUT_PULLDOWN | MUX_MODE1) /* mii1_txen.rmii1_txen */
> +                       0x124 (PIN_OUTPUT_PULLDOWN | MUX_MODE1) /* mii1_txd1.rmii1_txd1 */
> +                       0x128 (PIN_OUTPUT_PULLDOWN | MUX_MODE1) /* mii1_txd0.rmii1_txd0 */
> +                       0x13c (PIN_INPUT_PULLDOWN | MUX_MODE1)  /* mii1_rxd1.rmii1_rxd1 */
> +                       0x140 (PIN_INPUT_PULLDOWN | MUX_MODE1)  /* mii1_rxd0.rmii1_rxd0 */
> +                       0x144 (PIN_INPUT | SLEWCTRL_FAST | MUX_MODE0)   /* rmii1_ref_clk.rmii1_refclk */
> +                       0x1e4 (PIN_INPUT_PULLUP | MUX_MODE7)    /* emu0.gpio3_7 */
> +                       0x1e8 (PIN_OUTPUT_PULLDOWN | MUX_MODE7) /* emu1.gpio3_8 */

please go thru and convert these all to use the AM33XX_IOPAD macro..

All the boards have been converted for the 4.5.0-rc0 merge..

example:

https://git.kernel.org/cgit/linux/kernel/git/tmlind/linux-omap.git/commit/?h=for-next&id=df10eadfce3510c2814e95d9f3d2d5d2c64eb26b

Regards,

-- 
Robert Nelson
https://rcn-ee.com/
