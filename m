From: helgaas@kernel.org (Bjorn Helgaas)
Date: Tue, 4 Jul 2017 15:24:12 -0500
Subject: [PATCH v9 0/3] Tango PCIe controller support
In-Reply-To: <987fac41-80dc-f1d0-ec0b-91ae57b91bfd@sigmadesigns.com>
References: <987fac41-80dc-f1d0-ec0b-91ae57b91bfd@sigmadesigns.com>
Message-ID: <20170704202412.GK13824@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 20, 2017 at 10:12:57AM +0200, Marc Gonzalez wrote:
> Marc Z pointed out that posting partial series is not ideal.
> Collect last-minute fixups into a single patch series.
> 
> - Bump series to v9 to avoid any ambiguity
> - Add Rob's Ack on patch 1
> 
> Marc Gonzalez (3):
>   PCI: Add DT binding for tango PCIe controller
>   PCI: Add tango PCIe host bridge support
>   PCI: Add tango MSI controller support
> 
>  .../devicetree/bindings/pci/tango-pcie.txt         |  29 ++
>  drivers/pci/host/Kconfig                           |   8 +
>  drivers/pci/host/Makefile                          |   1 +
>  drivers/pci/host/pcie-tango.c                      | 390 +++++++++++++++++++++
>  include/linux/pci_ids.h                            |   2 +
>  5 files changed, 430 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/tango-pcie.txt
>  create mode 100644 drivers/pci/host/pcie-tango.c

I made the trivial changes I mentioned, added a dependency on
CONFIG_BROKEN (for the config/MMIO muxing issue), and put these on
pci/host-tango.  I can't build or test this, so I probably broke
something in the process.  I think the combination of the boot-time
warning, the taint, and CONFIG_BROKEN is a reasonable amount of
warning that a user should expect issues.

Can you take a look and see if it works for you?

https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/log/?h=pci/host-tango

Bjorn
