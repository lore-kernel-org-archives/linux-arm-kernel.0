From: tony@atomide.com (Tony Lindgren)
Date: Thu, 22 Sep 2016 11:07:18 -0700
Subject: Regression in next with "mfd: twl6040: The chip does not support
 bulk access"
Message-ID: <20160922180718.kmttyt26t56fa3kp@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Looks like commit 7a17e47f6403 ("mfd: twl6040: The chip does not
support bulk access") breaks at least omap4-duovero. I now get
tons of errors:

Skipping twl internal clock init and using bootloader value (unknown osc rate)
twl 0-0048: PIH (irq 332) nested IRQs
of_get_named_gpiod_flags: parsed 'ti,audpwron-gpio' property of node '/ocp/i2c at 48070000/t
wl at 4b[0]' - status (0)
omap_i2c 48070000.i2c: bus 0 rev0.10 at 400 kHz
twl6040 0-004b: Failed to read IRQ status: -16
twl6040 0-004b: Failed to read IRQ status: -16
twl6040 0-004b: Failed to read IRQ status: -16
twl6040 0-004b: Failed to read IRQ status: -16
twl6040 0-004b: Failed to read IRQ status: -16
twl6040 0-004b: Failed to read IRQ status: -16
twl6040 0-004b: Failed to read IRQ status: -16
twl6040 0-004b: Failed to read IRQ status: -16
twl6040 0-004b: Failed to read IRQ status: -16

It seems the regmap irqs don't work with use_single_rw?

Also seems that twl6040 does support bulk access as things have been
working earlier?

Anyways, can you please revert?

Regards,

Tony
