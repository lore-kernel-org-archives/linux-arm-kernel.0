From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 11 Oct 2014 22:37:04 +0200
Subject: [PATCH] ARM: keystone: add bus notifier to set dma_pfn_offset for
 pci devices
In-Reply-To: <54387429.2030605@ti.com>
References: <1412954137-4567-1-git-send-email-m-karicheri2@ti.com>
 <54385187.6030002@ti.com> <54387429.2030605@ti.com>
Message-ID: <7696162.dApA5zbMp7@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 10 October 2014 20:04:57 Santosh Shilimkar wrote:
> On 10/10/14 5:37 PM, Murali Karicheri wrote:
> > Based on this, dma configuration parameters get set for the device which
> > is probed through DT.
> >
> > As PCI devices are attached to the PCI bus during scan, and we don't
> > have DT nodes, we could use similar mechanism to pass the dma-range info
> > from parent host platform device to the PCI devices by adding an
> > of_pci_dma_configure() API and hook it to the PCI probe path some where?
> > Please comment on this so that I can work on the right solution to
> > address this issue for Keystone.
> >
> Adding the DT node parsing code in PCI bus probe path is the right way
> to go about it. You could re-use some of the helpers from dma parsing
> code.
> 
> I let Arnd comment if he disagrees, otherwise I suggest to create an
> RFC patch and post it on the list. We can take it from there.

Yes, I think that is the correct way forward, we need this anyway to
handle IOMMUs correctly, following the patches that Will Deacon did
for platform device IOMMU configuration.
 
> That also reminded me xhci host code issue with dma-ranges since the
> devices are manually created there. I will review that thread as
> well after this merge window.

Right, manually created devices are always problematic, you should
try to avoid those.

	Arnd
