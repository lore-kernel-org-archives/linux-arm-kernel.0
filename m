From: tcmichals@gmail.com (Tim Michals)
Date: Wed, 28 Nov 2012 12:33:10 -0600
Subject: [PATCH] add hardware I2C support for ARM IMX23
In-Reply-To: <50B63F81.4050008@van-ginkel.eu>
References: <20121128152403.45224dvyaufb1j7n@62.129.139.42>
 <20121128150851.GA4659@pengutronix.de>
 <20121128171039.14705ltphptrp5kv@62.129.139.42>
 <20121128162452.GB4659@pengutronix.de>
 <50B63F81.4050008@van-ginkel.eu>
Message-ID: <CANqk_c-UemJvfoFQMt-iNUU0YmiSt-fb-=Y9=eKwE=ka-ffw6A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sander,

Just tested with "i2cdetc -y -r 0" that crashes with  "BUG: soft lockup -
> CPU#0 stuck for 22s!"
> according to the docs (IMX23RM.pdf) the interrupts for I2C are 26 and 27
> that why I assigned these two in the dts.
>

In your dts, is it 26, 27? Order matters, it should be 27, 26.  Error ISR,
DMA.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121128/0233d8ab/attachment-0001.html>
