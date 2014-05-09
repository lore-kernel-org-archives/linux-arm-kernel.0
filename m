From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 9 May 2014 21:29:18 +0200
Subject: [PATCH v2] arm/dts: am335x-evmsk enable display and lcd panel
 support
In-Reply-To: <1399661354-10022-1-git-send-email-detheridge@ti.com>
References: <1399661354-10022-1-git-send-email-detheridge@ti.com>
Message-ID: <20140509192918.GA18138@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 09, 2014 at 01:49:14PM -0500, Darren Etheridge wrote:
> Add the necessary nodes to enable the LCD controller and the
> LCD panel that is attached to the Texas Instruments AM335x
> EVMSK platform.  Also setup the necessary pin mux within the
> DT file to drive the LCD connector and add the correct
> pinmux settings for the lcd pins to be configured to when
> the SoC goes into sleep state for the minimum power
> consumption.
> 
> For the sleep mode LCD pin settings, MUX_MODE7 is chosen as
> this corresponds to switching the pins into input GPIO's with
> an internal pulldown.  Which has been determined to offer the
> lowest power solution vs leaving the pins configured in LCD
> mode.
> 
> Signed-off-by: Darren Etheridge <detheridge@ti.com>

In general:

Acked-by: Wolfram Sang <wsa@sang-engineering.com>

> +	lcd_pins_sleep: lcd_pins_sleep {
> +		pinctrl-single,pins = <
> +			0x20 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad8.lcd_data23 */
> +			0x24 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad9.lcd_data22 */
> +			0x28 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad10.lcd_data21 */
> +			0x2c (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad11.lcd_data20 */
> +			0x30 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad12.lcd_data19 */
> +			0x34 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad13.lcd_data18 */
> +			0x38 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad14.lcd_data17 */
> +			0x3c (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad15.lcd_data16 */
> +			0xa0 (PULL_DISABLE | MUX_MODE7)	/* lcd_data0.lcd_data0 */
> +			0xa4 (PULL_DISABLE | MUX_MODE7)	/* lcd_data1.lcd_data1 */
> +			0xa8 (PULL_DISABLE | MUX_MODE7)	/* lcd_data2.lcd_data2 */
> +			0xac (PULL_DISABLE | MUX_MODE7)	/* lcd_data3.lcd_data3 */
> +			0xb0 (PULL_DISABLE | MUX_MODE7)	/* lcd_data4.lcd_data4 */
> +			0xb4 (PULL_DISABLE | MUX_MODE7)	/* lcd_data5.lcd_data5 */
> +			0xb8 (PULL_DISABLE | MUX_MODE7)	/* lcd_data6.lcd_data6 */
> +			0xbc (PULL_DISABLE | MUX_MODE7)	/* lcd_data7.lcd_data7 */
> +			0xc0 (PULL_DISABLE | MUX_MODE7)	/* lcd_data8.lcd_data8 */
> +			0xc4 (PULL_DISABLE | MUX_MODE7)	/* lcd_data9.lcd_data9 */
> +			0xc8 (PULL_DISABLE | MUX_MODE7)	/* lcd_data10.lcd_data10 */
> +			0xcc (PULL_DISABLE | MUX_MODE7)	/* lcd_data11.lcd_data11 */
> +			0xd0 (PULL_DISABLE | MUX_MODE7)	/* lcd_data12.lcd_data12 */
> +			0xd4 (PULL_DISABLE | MUX_MODE7)	/* lcd_data13.lcd_data13 */
> +			0xd8 (PULL_DISABLE | MUX_MODE7)	/* lcd_data14.lcd_data14 */
> +			0xdc (PULL_DISABLE | MUX_MODE7)	/* lcd_data15.lcd_data15 */
> +			0xe0 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* lcd_vsync.lcd_vsync */
> +			0xe4 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* lcd_hsync.lcd_hsync */
> +			0xe8 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* lcd_pclk.lcd_pclk */
> +			0xec (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* lcd_ac_bias_en.lcd_ac_bias_en */

Maybe a comment why LCD0-15 are handled differently?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140509/279ce322/attachment.sig>
