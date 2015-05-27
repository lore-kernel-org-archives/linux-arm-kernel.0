From: bhelgaas@google.com (Bjorn Helgaas)
Date: Wed, 27 May 2015 11:45:44 -0500
Subject: [PATCH Part1 v11 0/5] Some cleanup for pcie host drivers
In-Reply-To: <1430204499-19571-1-git-send-email-wangyijing@huawei.com>
References: <1430204499-19571-1-git-send-email-wangyijing@huawei.com>
Message-ID: <20150527164544.GV32152@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 28, 2015 at 03:01:34PM +0800, Yijing Wang wrote:
> These patches are split out from patchset(patch 5 is new)
> "Refine PCI scan interfaces and make generic pci host bridge".
> They are independent of the series, pci_bus_add_devices()
> has been ripped out from pci_scan_root_bus(), so we could
> use pci_scan_root_bus() instead of pci_create_root_bus() + 
> pci_scan_child_bus() for simplicity. Also this is the preparation
> for the series.
> 
> Yijing Wang (5):
>   PCI: mvebu: Use pci_common_init_dev() to simplify code
>   PCI: tegra: Remove redundant tegra_pcie_scan_bus()
>   PCI: designware: Use pci_scan_root_bus() for simplicity
>   PCI: xgene: Use pci_scan_root_bus() instead of pci_create_root_bus()

I applied the four patches above to pci/enumeration for v4.2, thanks.

>   PCI: iproc: Use pci_scan_root_bus() instead of pci_create_root_bus()
> 
>  drivers/pci/host/pci-mvebu.c       |   18 +-----------------
>  drivers/pci/host/pci-tegra.c       |   16 ----------------
>  drivers/pci/host/pci-xgene.c       |    3 +--
>  drivers/pci/host/pcie-designware.c |    4 +---
>  drivers/pci/host/pcie-iproc.c      |    5 ++---
>  5 files changed, 5 insertions(+), 41 deletions(-)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
