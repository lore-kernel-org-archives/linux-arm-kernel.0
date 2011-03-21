From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Mar 2011 11:58:23 +0000
Subject: Build warning in todays linus/master
In-Reply-To: <20110321110105.GB2610@pulham.picochip.com>
References: <20110321110105.GB2610@pulham.picochip.com>
Message-ID: <20110321115823.GB22222@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 21, 2011 at 11:01:05AM +0000, Jamie Iles wrote:
> Hi Will,
> 
> I'm getting a build warning on todays master build for my V6K platform:
> 
>   CC      arch/arm/mm/mmu.o
> arch/arm/mm/mmu.c: In function 'create_36bit_mapping':
> arch/arm/mm/mmu.c:601:10: warning: format '%08llx' expects type 'long long unsigned int', but argument 2 has type 'unsigned int'
> arch/arm/mm/mmu.c:614:10: warning: format '%08llx' expects type 'long long unsigned int', but argument 2 has type 'unsigned int'
> arch/arm/mm/mmu.c:621:10: warning: format '%08llx' expects type 'long long unsigned int', but argument 2 has type 'unsigned int'
> arch/arm/mm/mmu.c: In function 'create_mapping':
> arch/arm/mm/mmu.c:662:10: warning: format '%08llx' expects type 'long long unsigned int', but argument 2 has type 'unsigned int'
> arch/arm/mm/mmu.c:670:10: warning: format '%08llx' expects type 'long long unsigned int', but argument 2 has type 'unsigned int'
> arch/arm/mm/mmu.c:690:10: warning: format '%08lx' expects type 'long unsigned int', but argument 2 has type 'unsigned int'
> 
> Which is introduced by (3a6b16 [ARM: 6675/1: use phys_addr_t instead of 
> unsigned long in conversion code]), because phys_addr_t is a u32 
> (!CONFIG_PHYS_ADDR_T_64BIT).  I guess a cast to u64 in the printk()'s in 
> arch/arm/mm/mmu.c would fix these up, is that the right approach?

Please leave well alone until I've merged everything in my tree.  Thanks.
