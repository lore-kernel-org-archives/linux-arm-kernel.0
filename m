From: tcmichals@gmail.com (Tim Michals)
Date: Wed, 28 Nov 2012 13:15:23 -0600
Subject: [PATCH] add hardware I2C support for ARM IMX23
In-Reply-To: <20121128195821.71024xoxi57896tp@62.129.139.42>
References: <20121128152403.45224dvyaufb1j7n@62.129.139.42>
 <20121128150851.GA4659@pengutronix.de>
 <20121128171039.14705ltphptrp5kv@62.129.139.42>
 <20121128162452.GB4659@pengutronix.de>
 <50B63F81.4050008@van-ginkel.eu>
 <CANqk_c-UemJvfoFQMt-iNUU0YmiSt-fb-=Y9=eKwE=ka-ffw6A@mail.gmail.com>
 <20121128195821.71024xoxi57896tp@62.129.139.42>
Message-ID: <CANqk_c9ZuDz+krHgUHTC=1GrmBw=5pd9GDsdiy17iFDgi5Hrjg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sander,




>  mxs-i2c 80058000.i2c: Failed to get PIO reg. write descriptor.
>
> Yes, this is the same issue I've encountered, DMA operation did not
terminate, as a quick fix added dmaengine_terminate_all(i2c->dmach);  to
the last line of
static void mxs_i2c_reset(struct mxs_i2c_dev *i2c)
{
...
dmaengine_terminate_all(i2c->dmach);
}
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121128/4dc5bdb2/attachment-0001.html>
