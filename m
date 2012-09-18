From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 18 Sep 2012 22:04:42 +0100
Subject: [PATCH 01/15] ARM: add mem_type prot_pte accessor
In-Reply-To: <20120915153436.21241.95691.stgit@ubuntu>
References: <20120915153359.21241.86002.stgit@ubuntu>
 <20120915153436.21241.95691.stgit@ubuntu>
Message-ID: <20120918210442.GA12245@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 15, 2012 at 11:34:36AM -0400, Christoffer Dall wrote:
> From: Marc Zyngier <marc.zyngier@arm.com>
> 
> The KVM hypervisor mmu code requires access to the mem_type prot_pte
> field when setting up page tables pointing to a device. Unfortunately,
> the mem_type structure is opaque.
> 
> Add an accessor (get_mem_type_prot_pte()) to retrieve the prot_pte
> value.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>

Is there a reason why we need this to be exposed, along with all the
page table manipulation in patch 7?

Is there a reason why we can't have new MT_ types for PAGE_HYP and
the HYP MT_DEVICE type (which is the same as MT_DEVICE but with
PTE_USER set) and have the standard ARM/generic kernel code build
those mappings?

That would (it seems) also avoid the need to export the pXd_clear_bad()
acessors too...
