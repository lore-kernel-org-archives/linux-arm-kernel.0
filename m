From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 15 Mar 2010 15:15:42 +0100
Subject: Wrong cache flush function used in
	arch/arm/boot/compressed/head.S?
In-Reply-To: <1268409116.16433.28.camel@e102109-lin.cambridge.arm.com>
References: <20100312100511.GQ19843@pengutronix.de>
	<1268409116.16433.28.camel@e102109-lin.cambridge.arm.com>
Message-ID: <20100315141542.GA19843@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 12, 2010 at 03:51:56PM +0000, Catalin Marinas wrote:
> On Fri, 2010-03-12 at 10:05 +0000, Sascha Hauer wrote:
> > 0e056f20f18d0efa5da920f3cf8532adc56d5779 contains the following hunk:
> > 
> >                 .word   0x00060000              @ ARMv5TEJ
> >                 .word   0x000f0000
> > -               b       __armv4_mmu_cache_on
> > -               b       __armv4_mmu_cache_off
> > -               b       __armv5tej_mmu_cache_flush
> > +               W(b)    __armv4_mmu_cache_on
> > +               W(b)    __armv4_mmu_cache_off
> > +               W(b)    __armv4_mmu_cache_flush
> > 
> > Is this intentional? I do not see any problems in my kernel, but I
> > use the same code in my bootloader and it doesn't seem to work correctly
> > on my arm926 based system.
> 
> It wasn't intentional. I think I got it wrong when trying to solve a
> merge conflict and I just added the original hunk.

Ok, I just sent a patch to the patch system.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
