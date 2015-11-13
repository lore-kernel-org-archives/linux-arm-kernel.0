From: igor.grinberg@compulab.co.il (Igor Grinberg)
Date: Fri, 13 Nov 2015 12:19:19 +0200
Subject: [PATCH 1/6] ARM: OMAP2+: dts: cm-t335: add initial support
In-Reply-To: <1445948100-16446-2-git-send-email-uri.mashiach@compulab.co.il>
References: <1445948100-16446-1-git-send-email-uri.mashiach@compulab.co.il>
 <1445948100-16446-2-git-send-email-uri.mashiach@compulab.co.il>
Message-ID: <5645B927.5020001@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uri,

On 10/27/15 14:14, Uri Mashiach wrote:
> From: Ilya Ledvich <ilya@compulab.co.il>
> 
> Add basic support for CompuLab cm-t335 module based on AM335X SoC.
> 
> CM-T335 is a tiny computer-on-module (CoM) / system-on-module (SoM)
> The module is built around the Texas Instruments Sitara AM3352/4
> system-on-chip.
> 
> The CPU is supplemented with up-to 512MB DDR3 and up-to 1GB of on-board
> NAND storage, WiFi connected to SPI, Bluetooth, Analog audio, Gigabit
> Ethernet, CAN bus.
> 
> Current patch adds support:
> UART0 and GPIO LED
> 
> Detailed description can be found at the module site:
> http://www.compulab.co.il/products/computer-on-modules/cm-t335/

[...]

> diff --git a/arch/arm/boot/dts/am335x-cm-t335.dts b/arch/arm/boot/dts/am335x-cm-t335.dts
> new file mode 100644
> index 0000000..197d5ce
> --- /dev/null
> +++ b/arch/arm/boot/dts/am335x-cm-t335.dts
> @@ -0,0 +1,62 @@

[...]

> +&am33xx_pinmux {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <>;
> +
> +	gpio_led_pins: pinmux_gpio_led_pins {
> +		pinctrl-single,pins = <
> +			0x88 (PIN_OUTPUT | MUX_MODE7)	/* gpmc_csn3.gpio2_0 */
> +		>;
> +	};
> +
> +	uart0_pins: pinmux_uart0_pins {
> +		pinctrl-single,pins = <
> +			/* uart0_rxd.uart0_rxd */
> +			0x170 (PIN_INPUT_PULLUP | MUX_MODE0)
> +			/* uart0_txd.uart0_txd */
> +			0x174 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)

Can we use AM33XX_IOPAD macro here?
and may be other patches too?

[...]

-- 
Regards,
Igor.
