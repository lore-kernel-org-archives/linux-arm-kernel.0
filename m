From: axel.lin@gmail.com (Axel Lin)
Date: Sun, 17 Jul 2011 21:38:56 +0800
Subject: [PATCH] omap1: select GENERIC_IRQ_CHIP for TI OMAP1
In-Reply-To: <87boxi2eep.fsf@ti.com>
References: <1309251943.3984.1.camel@phoenix> <87boxi2eep.fsf@ti.com>
Message-ID: <CAF+7xW=DKMi9doKm0XH0+EvJLX0gzUE0_TqrZNrqHqvjuSeHdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/6/28 Kevin Hilman <khilman@ti.com>:
> Axel Lin <axel.lin@gmail.com> writes:
>
>> The gpio-omap driver has been converted to use generic IRQ chip.
>> Thus select GENERIC_IRQ_CHIP for TI OMAP1 to fix below build error.
>>
>> ? LD ? ? ?vmlinux
>> drivers/built-in.o: In function `omap_mpuio_alloc_gc':
>> drivers/gpio/gpio-omap.c:1087: undefined reference to `irq_alloc_generic_chip'
>> drivers/gpio/gpio-omap.c:1100: undefined reference to `irq_setup_generic_chip'
>> drivers/built-in.o: In function `omap_gpio_show_rev':
>> drivers/gpio/gpio-omap.c:998: undefined reference to `irq_gc_mask_clr_bit'
>> drivers/gpio/gpio-omap.c:998: undefined reference to `irq_gc_mask_set_bit'
>> make: *** [vmlinux] Error 1
>>
>> Signed-off-by: Axel Lin <axel.lin@gmail.com>
>
> Thanks, I have a fix for this already queued for v3.0-rc3 series:
>
> ? ? ? ?http://marc.info/?l=linux-omap&m=130749135312468&w=2
>
Hi,
Seems this patch is not upstream.
I still have the same build error with  [linux-next: Tree for July 16].

Regards,
Axel
