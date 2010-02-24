From: bgat@billgatliff.com (Bill Gatliff)
Date: Wed, 24 Feb 2010 13:06:05 -0600
Subject: AC97 audio broken on SAM9263EK?
Message-ID: <4B85789D.6000704@billgatliff.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Guys:


It looks like AC97 support for the SAM9263EK isn't in the current
mainline kernel.  Or am I just missing something?

More specifically, it looks like the "atmel_ac97c" driver found in
sound/atmel/ac97c.c is what I need, based on my look at
at91_add_device_ac97().  But I see this in sound/atmel/Kconfig:

    config SND_ATMEL_AC97C
            tristate "Atmel AC97 Controller (AC97C) driver"
            select SND_PCM
            select SND_AC97_CODEC
            depends on DW_DMAC && AVR32

And I see this in sound/atmel/Makefile:

    snd-atmel-abdac-objs            := abdac.o
    snd-atmel-ac97c-objs            := ac97c.o

    obj-$(CONFIG_SND_ATMEL_ABDAC)   += snd-atmel-abdac.o
    obj-$(CONFIG_SND_ATMEL_AC97C)   += snd-atmel-ac97c.o

In other words, the driver isn't built unless I'm on an AVR32 platform
and I have a DesignWare DMAC.  Neither of those describe the AT91SAM9263EK.

Has anyone tested AC97 audio on the SAM9263EK lately?  Has it ever worked?


Thanks!

-- 
Bill Gatliff
Embedded systems training and consulting
http://billgatliff.com
bgat at billgatliff.com
