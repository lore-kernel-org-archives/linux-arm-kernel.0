From: joro@8bytes.org (Joerg Roedel)
Date: Wed, 17 Jan 2018 14:02:31 +0100
Subject: [PATCH V4 11/26] iommu/amd: deprecate pci_get_bus_and_slot()
In-Reply-To: <1513661883-28662-12-git-send-email-okaya@codeaurora.org>
References: <1513661883-28662-1-git-send-email-okaya@codeaurora.org>
 <1513661883-28662-12-git-send-email-okaya@codeaurora.org>
Message-ID: <20180117130231.GP28161@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 19, 2017 at 12:37:47AM -0500, Sinan Kaya wrote:
> pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
> where a PCI device is present. This restricts the device drivers to be
> reused for other domain numbers.
> 
> Getting ready to remove pci_get_bus_and_slot() function in favor of
> pci_get_domain_bus_and_slot().
> 
> Hard-code the domain number as 0 for the AMD IOMMU driver.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/iommu/amd_iommu.c      | 3 ++-
>  drivers/iommu/amd_iommu_init.c | 9 +++++----
>  drivers/iommu/amd_iommu_v2.c   | 3 ++-
>  3 files changed, 9 insertions(+), 6 deletions(-)

Acked-by: Joerg Roedel <jroedel@suse.de>
