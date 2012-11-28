From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 28 Nov 2012 18:09:07 +0100
Subject: [PATCH] add hardware I2C support for ARM IMX23
In-Reply-To: <50B63F81.4050008@van-ginkel.eu>
References: <20121128152403.45224dvyaufb1j7n@62.129.139.42>
 <20121128150851.GA4659@pengutronix.de>
 <20121128171039.14705ltphptrp5kv@62.129.139.42>
 <20121128162452.GB4659@pengutronix.de>
 <50B63F81.4050008@van-ginkel.eu>
Message-ID: <20121128170907.GC4659@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

(adding the i2c list)

On Wed, Nov 28, 2012 at 05:44:49PM +0100, Sander van Ginkel wrote:
> tested with:
> CONFIG_I2C_MXS=m
> CONFIG_I2C_MXS=y
> 
> in combination with CONFIG_GPIO_MXS enabled and disabled
> 
> used kernels: 3.6 and 3.7.0-rc6
> 
> My I2C slave is a PCF8575 i/o expander with some LEDs at the output.
> These are controlled through sysfs.

Thanks, this is useful info.

> Just tested with "i2cdetc -y -r 0" that crashes with  "BUG: soft
> lockup - CPU#0 stuck for 22s!"
> according to the docs (IMX23RM.pdf) the interrupts for I2C are 26
> and 27 that why I assigned these two in the dts.

You might want to try my for-next branch or wait for 3.8-rc1, maybe the
DMA termination patch helps? Also enabling I2C debug messages is
probably worth it.

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121128/8e813c29/attachment.sig>
