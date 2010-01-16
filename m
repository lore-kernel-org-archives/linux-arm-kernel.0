From: tony@atomide.com (Tony Lindgren)
Date: Sat, 16 Jan 2010 11:18:20 -0800
Subject: [PATCH 2/4] omap: Make uncompress code and DEBUG_LL code generic
In-Reply-To: <20100116093555.GA13596@n2100.arm.linux.org.uk>
References: <20100116013205.10065.95921.stgit@baageli.muru.com>
	<20100116013515.10065.30649.stgit@baageli.muru.com>
	<20100116093555.GA13596@n2100.arm.linux.org.uk>
Message-ID: <20100116191820.GI10318@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [100116 01:33]:
> On Fri, Jan 15, 2010 at 05:35:15PM -0800, Tony Lindgren wrote:
> > diff --git a/arch/arm/mach-omap1/include/mach/debug-macro.S b/arch/arm/mach-omap1/include/mach/debug-macro.S
> > index 23e4724..0174858 100644
> > --- a/arch/arm/mach-omap1/include/mach/debug-macro.S
> > +++ b/arch/arm/mach-omap1/include/mach/debug-macro.S
> > @@ -15,18 +15,71 @@
> >  
> >  #include <plat/serial.h>
> >  
> > +omap_uart_phys:	.word	0x0
> > +omap_uart_virt:	.word	0x0
> 
> I assume that you have no plans for XIP kernel support on OMAP, since
> these will be placed in the .text section, and is therefore read-only
> on XIP kernels.

Did not think of that.. Maybe some addruart_premable solution here would.
Or adding \tmp register for addruart and just do the detection for each
character.

Regards,

Tony
