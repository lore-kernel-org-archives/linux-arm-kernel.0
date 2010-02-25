From: sedji.gaouaou@atmel.com (Sedji Gaouaou)
Date: Thu, 25 Feb 2010 11:09:42 +0100
Subject: AC97 audio broken on SAM9263EK?
In-Reply-To: <4B85789D.6000704@billgatliff.com>
References: <4B85789D.6000704@billgatliff.com>
Message-ID: <4B864C66.6060209@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bill,

I have been working on the sam9263 AC97 driver. I have sent a patch to 
the alsa mailing list but it has not being integrated yet (as far as I 
know...)(http://mailman.alsa-project.org/pipermail/alsa-devel/2010-February/025119.html).

I have tested it and it worked, but I have recently made some changes so 
the atmel ac97.c driver could support full duplex mode.

So I will submit a new patch by the end of the day/week, and I will copy 
it to you if you are interested.

Regards,
Sedji Gaaouaou
Le 2/24/2010 8:06 PM, Bill Gatliff a ?crit :
> Guys:
>
>
> It looks like AC97 support for the SAM9263EK isn't in the current
> mainline kernel.  Or am I just missing something?
>
> More specifically, it looks like the "atmel_ac97c" driver found in
> sound/atmel/ac97c.c is what I need, based on my look at
> at91_add_device_ac97().  But I see this in sound/atmel/Kconfig:
>
>      config SND_ATMEL_AC97C
>              tristate "Atmel AC97 Controller (AC97C) driver"
>              select SND_PCM
>              select SND_AC97_CODEC
>              depends on DW_DMAC&&  AVR32
>
> And I see this in sound/atmel/Makefile:
>
>      snd-atmel-abdac-objs            := abdac.o
>      snd-atmel-ac97c-objs            := ac97c.o
>
>      obj-$(CONFIG_SND_ATMEL_ABDAC)   += snd-atmel-abdac.o
>      obj-$(CONFIG_SND_ATMEL_AC97C)   += snd-atmel-ac97c.o
>
> In other words, the driver isn't built unless I'm on an AVR32 platform
> and I have a DesignWare DMAC.  Neither of those describe the AT91SAM9263EK.
>
> Has anyone tested AC97 audio on the SAM9263EK lately?  Has it ever worked?
>
>
> Thanks!
>
