From: joro@8bytes.org (Joerg Roedel)
Date: Thu, 10 Nov 2016 17:13:31 +0100
Subject: [RFC v2 8/8] iommu/arm-smmu: implement add_reserved_regions
 callback
In-Reply-To: <04ed9694-707d-260b-70c6-f367d292ceca@redhat.com>
References: <1478258646-3117-1-git-send-email-eric.auger@redhat.com>
 <1478258646-3117-9-git-send-email-eric.auger@redhat.com>
 <20161110154606.GH2078@8bytes.org>
 <04ed9694-707d-260b-70c6-f367d292ceca@redhat.com>
Message-ID: <20161110161331.GJ2078@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 10, 2016 at 04:57:51PM +0100, Auger Eric wrote:
> It does not only serve the purpose to register the MSI IOVA region. We
> also need to allocate an iova_domain where MSI IOVAs will be allocated
> upon the request of the relevant MSI controllers. Do you mean you don't
> like to use the iova allocator for this purpose?

Yes, it looks like the only purpose of iommu_get_dma_msi_region_cookie()
is to get the msi-region information into into the reserved-list.

Why do you need to 'allocate' the MSI region after all? Except for
IOMMU_DOMAIN_DMA domains the iommu-core code does not care about address
allocation. This is up to the users of the domain, which includes that
the user has to take care of the MSI region.

Besides that, 'iommu_get_dma_msi_region_cookie' is a terrible function
name and does not describe at all what the function does or is supposed
to do.


	Joerg
