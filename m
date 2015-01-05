From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 05 Jan 2015 23:26:15 +0100
Subject: [PATCH v2 1/2] of/pci: add of_pci_dma_configure() update dma
 configuration
In-Reply-To: <54AAEEE1.7020607@ti.com>
References: <1419459099-6667-1-git-send-email-m-karicheri2@ti.com>
 <2019516.ehiuEv0rdL@wuerfel> <54AAEEE1.7020607@ti.com>
Message-ID: <1671700.LL29F8Iz6R@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 05 January 2015 15:06:57 Murali Karicheri wrote:
> On 01/03/2015 04:37 PM, Arnd Bergmann wrote:
> > Yes, but we also need to pass a PCI device specific identifier along
> > with the root bus node, because some iommu drivers take the PCI
> > bus/device/function number into account for creating per-function
> > i/o page tables.

> ...

> I will post v3 of the patch with what is agreed before in my response 
> and I understand there is no additional change required based on this 
> particular discussion about iommu. Right?

Actually regarding the bit I wrote above, it might be helpful to pass
the PCI_DEVID() into both of_iommu_configure and of_dma_configure.

While this may or may not be sufficient, I think there is no question
about it being needed for the ARM SMMU with PCI, so we may as well add
it at the point when you touch the same lines already. In the platform
bus case, just pass zero here.

	Arnd
