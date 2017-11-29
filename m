From: helgaas@kernel.org (Bjorn Helgaas)
Date: Wed, 29 Nov 2017 11:09:48 -0600
Subject: [PATCH V3 00/29] PCI: deprecate pci_get_bus_and_slot()
In-Reply-To: <1511801886-6753-1-git-send-email-okaya@codeaurora.org>
References: <1511801886-6753-1-git-send-email-okaya@codeaurora.org>
Message-ID: <20171129170947.GE6469@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sinan,

On Mon, Nov 27, 2017 at 11:57:37AM -0500, Sinan Kaya wrote:
> Deprecate pci_get_bus_and_slot() in favor of pci_get_domain_bus_and_slot()
> in order to remove domain 0 assumptions in the kernel.
> 
> pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
> where a PCI device is present. This restricts the device drivers to be
> reused for other domain numbers.
> 
> Use pci_get_domain_bus_and_slot() with a domain number of 0 where we can't
> extract the domain number. Other places, use the actual domain number from
> the device.
> 
> Changes from v2:
> * commit text cleanups
> * remove implicit busfn assignments and use PCI_DEVFN call in place.
> * change storage type for local copy of pci_domain_nr() value to int
> 
> Sinan Kaya (29):
>   alpha/PCI: deprecate pci_get_bus_and_slot()
>   powerpc/PCI: deprecate pci_get_bus_and_slot()
>   x86/PCI: deprecate pci_get_bus_and_slot()
>   ata: deprecate pci_get_bus_and_slot()
>   agp: nvidia: deprecate pci_get_bus_and_slot()
>   edd: deprecate pci_get_bus_and_slot()
>   ibft: deprecate pci_get_bus_and_slot()
>   drm/gma500: deprecate pci_get_bus_and_slot()
>   drm/i915: deprecate pci_get_bus_and_slot()
>   drm/nouveau: deprecate pci_get_bus_and_slot()
>   Drivers: ide: deprecate pci_get_bus_and_slot()
>   iommu/amd: deprecate pci_get_bus_and_slot()
>   powerpc/powermac: deprecate pci_get_bus_and_slot()
>   bnx2x: deprecate pci_get_bus_and_slot()
>   pch_gbe: deprecate pci_get_bus_and_slot()
>   PCI: cpqhp: deprecate pci_get_bus_and_slot()
>   PCI: ibmphp: deprecate pci_get_bus_and_slot()
>   PCI/quirks: deprecate pci_get_bus_and_slot()
>   PCI/syscall: deprecate pci_get_bus_and_slot()
>   xen: deprecate pci_get_bus_and_slot()
>   openprom: deprecate pci_get_bus_and_slot()
>   [media] atomisp: deprecate pci_get_bus_and_slot()
>   staging: rts5208: remove rtsx_read_pci_cfg_byte()
>   backlight: deprecate pci_get_bus_and_slot()
>   video: fbdev: intelfb: deprecate pci_get_bus_and_slot()
>   video: fbdev: nvidia: deprecate pci_get_bus_and_slot()
>   video: fbdev: riva: deprecate pci_get_bus_and_slot()
>   i7300_idle: remove unused file
>   PCI: remove pci_get_bus_and_slot() function

Thanks for doing this work!

I see other maintainers are picking up some of these.  I'll wait until
later in the cycle and pick up any remaining ones and the PCI core
parts.

If you repost the series for any reason, please capitalize the first
word of the changelog summary to match the drivers/pci convention (for
non PCI patches, follow *their* convention, of course) and put the
acks/reviewed-by tags after your signed-off-by.  I use this order:

  Reported-by:
  Tested-by:
  Signed-off-by: (author)
  Signed-off-by: (chain)
  Reviewed-by:
  Acked-by:
  Cc: stable at vger.kernel.org        # 3.4+
  Cc: (other)

But don't bother reposting the series just for this reason; I can fix
these up myself.

Bjorn
