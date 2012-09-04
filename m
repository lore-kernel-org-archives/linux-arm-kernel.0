From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 4 Sep 2012 10:01:32 +0100
Subject: linux-next: manual merge of the arm-soc tree with the
 arm-current tree
In-Reply-To: <201209040808.25103.arnd@arndb.de>
References: <20120904160626.f1dcb67ebbb145053c49da8c@canb.auug.org.au>
 <201209040808.25103.arnd@arndb.de>
Message-ID: <20120904090132.GG24085@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 04, 2012 at 08:08:24AM +0000, Arnd Bergmann wrote:
> On Tuesday 04 September 2012, Stephen Rothwell wrote:
> > Today's linux-next merge of the arm-soc tree got a conflict in
> > arch/arm/mm/mmu.c between commit a849088aa155 ("ARM: Fix ioremap() of
> > address zero") from the arm-current tree and commit c2794437091a ("ARM:
> > Add fixed PCI i/o mapping") from the arm-soc tree.
> > 
> > I am not sure how to fix this, so I have used the arm-current version of
> > the change to pmd_empty_section_gap() since that changed the vm->flags.
> > It may be that just changing the vm->flags value in vm_reserve_area_early()
> > would be ok?
> 
> If I read this correctly, we want pci_reserve_io to use VM_ARM_STATIC_MAPPING
> while pmd_empty_section_gap should use VM_ARM_EMPTY_MAPPING, so we probably
> want to add a flag argument to the vm_reserve_area_early() function.

Whereas Rob said to me that both can use VM_ARM_EMPTY_MAPPING when I
queried this conflict last week.
