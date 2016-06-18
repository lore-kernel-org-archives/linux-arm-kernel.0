From: pavel@ucw.cz (Pavel Machek)
Date: Sat, 18 Jun 2016 16:35:57 +0200
Subject: Platform-specific suspend/resume code in drivers
In-Reply-To: <57592E3C.8020005@laposte.net>
References: <Pine.LNX.4.44L0.1606081340050.2191-100000@iolanthe.rowland.org>
 <57592E3C.8020005@laposte.net>
Message-ID: <20160618143557.GA8392@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > More details, please.
> 
> In addition to what Marc already replied, allow me to put a small (and hopefully self-contained) example:
> 
> - There's a SoC with a HW IP (UART, ethernet, usb or whatever else) for which a generic driver exists.
> - The generic driver only needs to know the base address of the block, and it will just work.
> - It'll just work, provided that when Linux boots the HW IP is enabled.
> - Indeed, the SoC may have other registers controlling if the HW IP is enabled/powered up.
> - Those registers are SoC specific, even if the HW IP is generic.
> 
> So the question is:
> => Does the use of a generic driver indirectly implies that any SoC specific registers are to be setup outside Linux?
> In other words, does Linux expects the HW IP to be powered up/enabled and ready to use? (ie: setup by the bootloader)
>

On PC, Linux has some expectations about bootloader. On other
platforms, it should not have to... and with suspend / hibernation, it
is harder and harder to rely on it.

> If that is not the case, what is the recommended way to handle those pregisters?
> In other words, do the generic drivers provide with an API to handle SoC specific enable/clockgating/powerup registers?
>

You should create a special driver for your hardware when this
happens. clock gating is usually handled by specifying what clocks it
needs in the device tree, and you specify power control GPIO, too.

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
