From: jamie@jamieiles.com (Jamie Iles)
Date: Mon, 21 Mar 2011 11:50:41 +0000
Subject: Build warning in todays linus/master
In-Reply-To: <002101cbe7bc$d547c6f0$7fd754d0$@deacon@arm.com>
References: <20110321110105.GB2610@pulham.picochip.com>
	<002101cbe7bc$d547c6f0$7fd754d0$@deacon@arm.com>
Message-ID: <20110321115041.GA29724@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 21, 2011 at 11:40:52AM -0000, Will Deacon wrote:
> Hi Jamie,
> 
> > I'm getting a build warning on todays master build for my V6K platform:
> > 
> >   CC      arch/arm/mm/mmu.o
> > arch/arm/mm/mmu.c: In function 'create_36bit_mapping':
> > arch/arm/mm/mmu.c:601:10: warning: format '%08llx' expects type 'long long unsigned int', but argument
> > 2 has type 'unsigned int'
> > arch/arm/mm/mmu.c:614:10: warning: format '%08llx' expects type 'long long unsigned int', but argument
> > 2 has type 'unsigned int'
> > arch/arm/mm/mmu.c:621:10: warning: format '%08llx' expects type 'long long unsigned int', but argument
> > 2 has type 'unsigned int'
> > arch/arm/mm/mmu.c: In function 'create_mapping':
> > arch/arm/mm/mmu.c:662:10: warning: format '%08llx' expects type 'long long unsigned int', but argument
> > 2 has type 'unsigned int'
> > arch/arm/mm/mmu.c:670:10: warning: format '%08llx' expects type 'long long unsigned int', but argument
> > 2 has type 'unsigned int'
> > arch/arm/mm/mmu.c:690:10: warning: format '%08lx' expects type 'long unsigned int', but argument 2 has
> > type 'unsigned int'
> > 
> > Which is introduced by (3a6b16 [ARM: 6675/1: use phys_addr_t instead of
> > unsigned long in conversion code]), because phys_addr_t is a u32
> > (!CONFIG_PHYS_ADDR_T_64BIT).  I guess a cast to u64 in the printk()'s in
> > arch/arm/mm/mmu.c would fix these up, is that the right approach?
> 
> It looks like one of the LPAE preparation patches has been merged
> (i.e. the one which replaces unsigned long with phys_addr_t) but the
> conversion specifier fixes are not yet in mainline, although they do
> live in -next.

Ahh, I thought I'd seen something like that on the lists before but 
obviously couldn't find the right one!  Thanks for pointing me at the 
right patches though.

Jamie
