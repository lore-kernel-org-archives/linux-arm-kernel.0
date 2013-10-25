From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 25 Oct 2013 14:46:01 +0300
Subject: [PATCH 3/3] ARM: OMAP2: omap4-sdp: remove unneeded gpios from
 dss-common
In-Reply-To: <526A528C.2020204@ti.com>
References: <1382695658-18757-1-git-send-email-tomi.valkeinen@ti.com>
 <1382695658-18757-3-git-send-email-tomi.valkeinen@ti.com>
 <526A4585.30403@ti.com> <526A4708.7010309@ti.com> <526A4DEA.3050505@ti.com>
 <526A528C.2020204@ti.com>
Message-ID: <526A59F9.3010104@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/10/13 14:14, Nishanth Menon wrote:

> lcd2_pins: pinmux_lcd2_pins {
> +		pinctrl-single,pins = <
> +			0x20 (PIN_OUTPUT_PULLDOWN | MUX_MODE3)	/* gpio_40 */
> +			0x46 (PIN_OUTPUT_PULLUP | MUX_MODE3)	/* gpio_59 */
> +			0x56 (PIN_OUTPUT_PULLDOWN | MUX_MODE3)	/* gpio_104 */
> +		>;
> 
> 3 pins are driven around 300uA at boot, even with display OFF -> which
> means wasted current that could have been optimized by hooking the pin
> to the dts node corresponding to the device and used by the driver
> appropriately.

One more clarification question.

The gpio 40 is used to enable powers for the picodlp. Shouldn't that one
have a pinctrl pull-down in any case? If it's left floating, and the
driver is not compiled in or doesn't start, the powers could get enabled
depending on sunspot, right?

And I guess the same goes for all gpios used to enable something.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131025/9be3961c/attachment-0001.sig>
