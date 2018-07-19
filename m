From: helgaas@kernel.org (Bjorn Helgaas)
Date: Thu, 19 Jul 2018 18:05:00 -0500
Subject: [PATCH V5 0/6] PCI: unify slot and bus reset calls
In-Reply-To: <1530572336-20296-1-git-send-email-okaya@codeaurora.org>
References: <1530572336-20296-1-git-send-email-okaya@codeaurora.org>
Message-ID: <20180719230500.GR128988@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 02, 2018 at 06:58:49PM -0400, Sinan Kaya wrote:
> pci_reset_slot() and pci_reset_bus() functions require user to query if a
> device is behind a hotplug slot. External users are not following this
> requirement.
> 
> Hide the implemetnation into PCI core and check hotplug association on
> behalf of the user internally.
> 
> Changes from v4:
> * return code factoring per Andy.
> 
> Sinan Kaya (6):
>   PCI: Handle error return from pci_reset_bridge_secondary_bus()
>   IB/hfi1: Use pci_try_reset_bus() for initiating pci secondary bus
>     reset
>   PCI: Hide pci_reset_bridge_secondary_bus() from drivers
>   PCI: Unify try slot and bus reset API
>   PCI: Deprecate pci_reset_bus() and pci_reset_slot() functions
>   PCI: Rename pci_try_reset_bus() to pci_reset_bus()
> 
>  drivers/infiniband/hw/hfi1/pcie.c |  4 +-
>  drivers/pci/hotplug/pciehp_hpc.c  |  5 ++-
>  drivers/pci/pci.c                 | 91 +++++++++++----------------------------
>  drivers/pci/pci.h                 |  1 +
>  drivers/pci/pcie/aer.c            |  5 ++-
>  drivers/pci/pcie/err.c            |  6 ++-
>  drivers/vfio/pci/vfio_pci.c       |  6 +--
>  include/linux/pci.h               |  6 +--
>  8 files changed, 40 insertions(+), 84 deletions(-)

Applied to pci/virtualization for v4.19, thanks!
