From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Wed, 13 Sep 2017 09:57:47 +0200
Subject: [PATCH 0/3] Tango PCIe host bridge MSI support + required API
In-Reply-To: <f10055cc-4430-ff30-f892-3d3d6f24354c@sigmadesigns.com>
References: <f10055cc-4430-ff30-f892-3d3d6f24354c@sigmadesigns.com>
Message-ID: <a016bb7e-bb17-174d-92de-dd07cdf3a7ee@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/08/2017 16:19, Marc Gonzalez wrote:

> Bjorn, Marc Z,
> 
> This patch-set includes:
>
> o [PATCH v11] PCI: tango: Add MSI controller support
> with the doorbell address parsed from DT instead of hard-coded
> in the driver.
> 
> o A wrapper to parse dma-ranges was added to drivers/of/address.c
> 
> o A few drivers were converted to use the new wrapper
> 
> Marc Gonzalez (3):
>    of/pci: Add dma-ranges parsing support
>    PCI: Use of_pci_dma_range_parser_init API
>    PCI: tango: Add MSI controller support
> 
>   drivers/of/address.c             |  19 +++-
>   drivers/pci/host/pci-ftpci100.c  |  20 +---
>   drivers/pci/host/pci-rcar-gen2.c |  20 +---
>   drivers/pci/host/pci-xgene.c     |  20 +---
>   drivers/pci/host/pcie-iproc.c    |  20 +---
>   drivers/pci/host/pcie-rcar.c     |  20 +---
>   drivers/pci/host/pcie-tango.c    | 205 ++++++++++++++++++++++++++++++++++++++-
>   include/linux/of_address.h       |  10 +-
>   8 files changed, 232 insertions(+), 102 deletions(-)

What's the word on this patch series?

Marc Z, Robin: is the computation of pcie->msi_doorbell alright?
(Is u64 the correct type for a PCI address?)

Should the first two patches be squashed together, in case reverting
is required?

Regards.
