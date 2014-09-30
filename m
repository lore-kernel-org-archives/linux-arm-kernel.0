From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 30 Sep 2014 20:54:41 +0200
Subject: [RFC 2/4] PCI: generic: Add support for ARM64 and MSI(x)
In-Reply-To: <20140930174821.GX841@e106497-lin.cambridge.arm.com>
References: <1411937610-22125-1-git-send-email-suravee.suthikulpanit@amd.com>
 <20140930173540.GB16583@e102568-lin.cambridge.arm.com>
 <20140930174821.GX841@e106497-lin.cambridge.arm.com>
Message-ID: <3079787.54pZijGjZM@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 30 September 2014 18:48:21 Liviu Dudau wrote:
> > > > > These are the functions I found that refer to pci_sys_data on arm32:
> > > > > 
> > > > > pcibios_add_bus
> > > > > pcibios_remove_bus
> 
> These are only needed if you want to do per HB processing of the bus
> 
> > > > > pcibios_align_resource
> 
> mvebu is the only user of this function.
> 
> > > > > pci_mmap_page_range
> 
> This is only needed when mapping a PCI resource to userspace. Is that your case here?
> 
> > > > > pci_domain_nr
> > > > > pci_proc_domain
> 
> We have equivalent functionality in the generic patches for those.
> 

We clearly don't need those functions for the new drivers, but that's not
the point. The problem is that when you build a kernel that has both
a traditional host bridge driver and a new one in it, you always get those
functions and they get called from the PCI core, with incorrect arguments.

	Arnd
