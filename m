From: ddaney@caviumnetworks.com (David Daney)
Date: Tue, 15 Sep 2015 11:06:59 -0700
Subject: [PATCH 0/6] PCI: generic: Misc. bug fixes and enhanced support
 for MSI.
In-Reply-To: <1442013719-5001-1-git-send-email-ddaney.cavm@gmail.com>
References: <1442013719-5001-1-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <55F85E43.5070207@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/11/2015 04:21 PM, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
>
> While using the pci-host-generic driver to add PCI support for the
> Cavium ThunderX processors, several bugs were discovered.  We also
> need the ability to specify a per-bus MSI controller, so support for
> that was added.
>
> David Daney (6):
>    PCI: Make global and export pdev_fixup_irq().
>    PCI: generic: Only fixup irqs for bus we are creating.
>    PCI: generic: Quit clobbering our pci_ops.
>    PCI: generic: Correct, and avoid overflow, in bus_max calculation.
>    PCI: generic: Pass proper starting bus number to pci_scan_root_bus().
>    PCI: generic: Allow bus default MSI controller to be specified.
>

Based on feedback on this first revision of the patches, I plan on 
sending an updated patch set in a few days.  In the mean time, keep 
sending feedback...

David Daney



>   .../devicetree/bindings/pci/host-generic-pci.txt   |  5 ++
>   drivers/pci/host/pci-host-generic.c                | 55 +++++++++++++++-------
>   drivers/pci/setup-irq.c                            |  7 +--
>   include/linux/pci.h                                |  3 ++
>   4 files changed, 50 insertions(+), 20 deletions(-)
>
