From: sander@van-ginkel.eu (Sander van Ginkel)
Date: Wed, 28 Nov 2012 17:44:49 +0100
Subject: [PATCH] add hardware I2C support for ARM IMX23
In-Reply-To: <20121128162452.GB4659@pengutronix.de>
References: <20121128152403.45224dvyaufb1j7n@62.129.139.42>
 <20121128150851.GA4659@pengutronix.de>
 <20121128171039.14705ltphptrp5kv@62.129.139.42>
 <20121128162452.GB4659@pengutronix.de>
Message-ID: <50B63F81.4050008@van-ginkel.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tested with:
CONFIG_I2C_MXS=m
CONFIG_I2C_MXS=y

in combination with CONFIG_GPIO_MXS enabled and disabled

used kernels: 3.6 and 3.7.0-rc6

My I2C slave is a PCF8575 i/o expander with some LEDs at the output.
These are controlled through sysfs.

Just tested with "i2cdetc -y -r 0" that crashes with  "BUG: soft lockup 
- CPU#0 stuck for 22s!"
according to the docs (IMX23RM.pdf) the interrupts for I2C are 26 and 27 
that why I assigned these two in the dts.
