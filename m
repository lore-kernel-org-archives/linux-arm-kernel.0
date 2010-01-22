From: tony@atomide.com (Tony Lindgren)
Date: Thu, 21 Jan 2010 19:07:12 -0800
Subject: [PATCH 2/4] omap: Make uncompress code and DEBUG_LL code
	generic, v2
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC356087030070F296@dbde02.ent.ti.com>
References: <20100116013205.10065.95921.stgit@baageli.muru.com>
	<20100116013515.10065.30649.stgit@baageli.muru.com>
	<20100116093555.GA13596@n2100.arm.linux.org.uk>
	<20100116191820.GI10318@atomide.com>
	<20100116193313.GA23092@n2100.arm.linux.org.uk>
	<20100116200003.GL10318@atomide.com>
	<FCCFB4CDC6E5564B9182F639FC356087030070F296@dbde02.ent.ti.com>
Message-ID: <20100122030711.GP23467@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Pandita, Vikram <vikram.pandita@ti.com> [100118 17:48]:
>
> >* Russell King - ARM Linux <linux@arm.linux.org.uk> [100116 11:31]:
> >
> >> Why not do something like this:
> >>
> >> 		.pushsection .data
> >> omap_uart_phys:	.word 0
> >> omap_uart_virt:	.word 0
> >> 		.popsection

Updated patch below using .data. This assumes getting an additional
tmp register passed to addruart as in the patch I posted earlier.
 
> Also We may need a:
> 	 omap_uart_shift: .word 0 
> Since shift also varies depending on different omap boards
> (external debug board shift=1, internal omap has shift=2)

OK, I've added that too, but for mach-omap2 only. I've also
added an experimental zoom2/3 support.

Care to take try it out and see what happens on a zoom?
 
> Bingo..I think this was the key solution to the problem.
> I had posted long ago similar kind of implementation [1] 
> and I wish rmk had given this nice idea then :)
> 
> [1] http://marc.info/?l=linux-omap&m=125269221820632&w=2
> 	See this part: 
> 	+		.align
> 	+		.type   __phy_uart_addr, #object
> 	+__phy_uart_addr:       .word   0xFF
> 	+		.type   __virt_uart_addr, #object
> 	+__virt_uart_addr:       .word   0xFF

Yeah hopefully we're pretty close to better DEBUG_LL support
for omaps now :)

BTW, I've also pushed these patches into a temporary multi-omap
branch in the linux-omap tree:

http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=shortlog;h=refs/heads/multi-omap

I'll update also the entry-macro.S tomorrow.

Regards,

Tony
