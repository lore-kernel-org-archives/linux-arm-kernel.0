From: bhelgaas@google.com (Bjorn Helgaas)
Date: Mon, 29 Sep 2014 13:43:35 -0600
Subject: [PATCH v13 00/12] Support for creating generic PCI host bridges
 from DT
In-Reply-To: <1412000971-9242-1-git-send-email-Liviu.Dudau@arm.com>
References: <1412000971-9242-1-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <20140929194335.GA13747@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 29, 2014 at 03:29:19PM +0100, Liviu Dudau wrote:
> This is my version 13 of the attempt at adding support for generic PCI host
> bridge controllers. It contains only cleanups to make it play nice with the
> linux-next tree as of 09/25. If Bjorn deems it safe, now that it looks like
> asm-generic is going to revert some of its more aggresive patches, he has the
> choice of queueing it into linux-next again.
> ...

These patches above were already on my pci/host-generic branch and in
linux-next:

   asm-generic/io.h: Fix ioport_map() for !CONFIG_GENERIC_IOMAP
   of/pci: Add pci_register_io_range() and pci_pio_to_address()
   ARM: Define PCI_IOBASE as the base of virtual PCI IO space
   of/pci: Define of_pci_range_to_resource() only when CONFIG_PCI=y
   of/pci: Move of_pci_range_to_resources() to of/address.c
   of/pci: Fix the conversion of IO ranges into IO resources

I added these three patches to my pci/host-generic branch:

   PCI: Add generic domain handling
   of/pci: Add pci_get_new_domain_nr() and of_get_pci_domain_nr()
   of/pci: Add support for parsing PCI host bridge resources from DT

Yinghai pointed out a problem with this one, so I omitted it:

   PCI: Assign unassigned bus resources in pci_scan_root_bus()

I added this one to my pci/host-generic branch:

   PCI: Add pci_remap_iospace() to map bus I/O resources

I assume this depends on the pci_scan_root_bus() change (if not, let me
know), so I omitted this one:

   arm64: Add architectural support for PCI

Bjorn
