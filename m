From: khilman@ti.com (Kevin Hilman)
Date: Wed, 03 Aug 2011 10:34:36 -0700
Subject: [PATCH RESEND] omap1: select GENERIC_IRQ_CHIP for TI OMAP1
In-Reply-To: <1312355897.14329.5.camel@phoenix> (Axel Lin's message of "Wed,
	03 Aug 2011 15:18:17 +0800")
References: <1312355897.14329.5.camel@phoenix>
Message-ID: <8762me761f.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Axel,

Axel Lin <axel.lin@gmail.com> writes:

> The gpio-omap driver has been converted to use generic IRQ chip.
> Thus select GENERIC_IRQ_CHIP for TI OMAP1 to fix below build error.
>
>  LD      vmlinux
> drivers/built-in.o: In function `omap_mpuio_alloc_gc':
> drivers/gpio/gpio-omap.c:1087: undefined reference to `irq_alloc_generic_chip'
> drivers/gpio/gpio-omap.c:1100: undefined reference to `irq_setup_generic_chip'
> drivers/built-in.o: In function `omap_gpio_show_rev':
> drivers/gpio/gpio-omap.c:998: undefined reference to `irq_gc_mask_clr_bit'
> drivers/gpio/gpio-omap.c:998: undefined reference to `irq_gc_mask_set_bit'
> make: *** [vmlinux] Error 1
>
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
> Kevin already sent a similar patch.  http://marc.info/?l=linux-omap&m=130749135312468&w=2
> But I still have the build error with make omap1_defconfig in today's linux-next tree.
> So here is a resend.

Tony didn't pick this up for v3.1, so I now have the original in my
fixies queue for v3.1-rc, which will be posted shortly.

Sorry this has slipped through the cracks.

Kevin
