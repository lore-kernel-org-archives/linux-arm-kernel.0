From: w.sang@pengutronix.de (Wolfram Sang)
Date: Sat, 3 Nov 2012 15:16:24 +0100
Subject: [PATCH] i2c: at91: add a sanity check on i2c message length
In-Reply-To: <5093EE2B.8080005@atmel.com>
References: <1349879158-27268-1-git-send-email-ludovic.desroches@atmel.com>
 <20121101222922.GD22956@pengutronix.de> <5093A8CD.60006@atmel.com>
 <20121102111432.GD21313@pengutronix.de>
 <5093EE2B.8080005@atmel.com>
Message-ID: <20121103141624.GA24952@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> >>Yes SMBUS quick command is supported but is not managed in the
> >>driver, we have to tell explicitly the IP that we want to send this
> >>command.
> >
> >Ok, so unless you want to implement the support, please update this
> >patch with a comment that SMBUS_QUICK is a TODO and remove the
> >SMBUS_QUICK capability.
> >
> 
> Implementation should not be a huge task, only one bit to set in a
> register but I have no device to test it.

'i2cdetect' from i2c-tools uses SMBUS_QUICK as one method to detect
chips. Most slaves (both I2C and SMBus) react to that, so that would do
in my book.

> Did you test the driver with SMBus compatible devices? Can I keep
> other SMBus capabilities from SMBUS_EMUL?

The rest should be fine.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121103/b3b8259b/attachment.sig>
