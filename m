From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 26 Mar 2018 13:45:56 +0200
Subject: sun6i SPI driver issue
In-Reply-To: <536bf3b1-4440-d060-b22f-2ce7321f4c13@orpaltech.com>
References: <536bf3b1-4440-d060-b22f-2ce7321f4c13@orpaltech.com>
Message-ID: <20180326114556.6xgxzq3jrbpah47n@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 19, 2018 at 06:43:43PM +0300, Sergey Suloev wrote:
> I have recently found a critical issue with sun6i SPI driver. It actually
> found it long time ago while using spidev but I didn't considered it as
> something important. Now it seems like a blocking issue that prevents using
> the driver in any serious application.

So is it "critical" or "not important"?

> I have created a DRM driver for a ili9488-based display, its source is
> available here [1] and device tree overlay [2]. The driver has been
> successfully verified on RPi3, but? it is failing on sunxi: the driver gets
> loaded, display seems working but SPI transfers are periodically failing
> with error -110 (timeout). Due to the issue the picture is frozen and
> completely refreshed again from time to time.

On which kernel version was this tested?

Do you have any additional details on what exactly is happening?

Is it timeouting because you never received any interrupts? Is the
first part of your transfer (the one that would fit in the FIFO
actually done, and it's the second part that fails? Something else?

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180326/d6ef926f/attachment.sig>
