From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Sat, 16 Feb 2013 08:52:34 -0500 (EST)
Subject: [PATCH v6 3/3] ARM: mm: use static_vm for managing static mapped
 areas
In-Reply-To: <20130216125205.GO17833@n2100.arm.linux.org.uk>
References: <1360142010-10598-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1360142010-10598-4-git-send-email-iamjoonsoo.kim@lge.com>
 <201302161249.08597.arnd@arndb.de>
 <20130216125205.GO17833@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.03.1302160851510.6419@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 16 Feb 2013, Russell King - ARM Linux wrote:

> On Sat, Feb 16, 2013 at 12:49:08PM +0000, Arnd Bergmann wrote:
> > 8<-----
> > ARM: mm: remove unused variables in pci_reserve_io
> > 
> > Patch "ARM: 7646/1: mm: use static_vm for managing static mapped areas"
> > removed code from pci_reserve_io but left variable declarations
> > in place that are now unused, as gcc correctly warns.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > 
> > diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> > index c6fe15a..c6d45c8 100644
> > --- a/arch/arm/mm/mmu.c
> > +++ b/arch/arm/mm/mmu.c
> > @@ -901,8 +901,6 @@ static void __init fill_pmd_gaps(void)
> >  #if defined(CONFIG_PCI) && !defined(CONFIG_NEED_MACH_IO_H)
> >  static void __init pci_reserve_io(void)
> >  {
> > -	struct vm_struct *vm;
> > -	unsigned long addr;
> >  	struct static_vm *svm;
> >  
> >  	svm = find_static_vm_vaddr((void *)PCI_IO_VIRT_BASE);
> 
> I already have such a patch in my tree - may not have pushed it out
> as I've been ill (and am still recovering.)

OK, disregard my previous ACK then.


Nicolas
