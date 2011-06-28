From: khilman@ti.com (Kevin Hilman)
Date: Tue, 28 Jun 2011 07:56:14 -0700
Subject: [PATCH] omap1: select GENERIC_IRQ_CHIP for TI OMAP1
In-Reply-To: <1309251943.3984.1.camel@phoenix> (Axel Lin's message of "Tue, 28
	Jun 2011 17:05:43 +0800")
References: <1309251943.3984.1.camel@phoenix>
Message-ID: <87boxi2eep.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Axel Lin <axel.lin@gmail.com> writes:

> The gpio-omap driver has been converted to use generic IRQ chip.
> Thus select GENERIC_IRQ_CHIP for TI OMAP1 to fix below build error.
>
>   LD      vmlinux
> drivers/built-in.o: In function `omap_mpuio_alloc_gc':
> drivers/gpio/gpio-omap.c:1087: undefined reference to `irq_alloc_generic_chip'
> drivers/gpio/gpio-omap.c:1100: undefined reference to `irq_setup_generic_chip'
> drivers/built-in.o: In function `omap_gpio_show_rev':
> drivers/gpio/gpio-omap.c:998: undefined reference to `irq_gc_mask_clr_bit'
> drivers/gpio/gpio-omap.c:998: undefined reference to `irq_gc_mask_set_bit'
> make: *** [vmlinux] Error 1
>
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Thanks, I have a fix for this already queued for v3.0-rc3 series:

        http://marc.info/?l=linux-omap&m=130749135312468&w=2

Kevin
