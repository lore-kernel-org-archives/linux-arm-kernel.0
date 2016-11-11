From: joro@8bytes.org (Joerg Roedel)
Date: Fri, 11 Nov 2016 12:42:23 +0100
Subject: [RFC v2 8/8] iommu/arm-smmu: implement add_reserved_regions
 callback
In-Reply-To: <f4537e43-0237-e478-eacd-b107458628b8@redhat.com>
References: <1478258646-3117-1-git-send-email-eric.auger@redhat.com>
 <1478258646-3117-9-git-send-email-eric.auger@redhat.com>
 <20161110154606.GH2078@8bytes.org>
 <04ed9694-707d-260b-70c6-f367d292ceca@redhat.com>
 <20161110161331.GJ2078@8bytes.org>
 <f4537e43-0237-e478-eacd-b107458628b8@redhat.com>
Message-ID: <20161111114223.GP2078@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 10, 2016 at 07:00:52PM +0100, Auger Eric wrote:
> GICv2m and GICV3 ITS use dma-mapping iommu_dma_map_msi_msg to allocate
> an MSI IOVA on-demand.

Yes, and it the right thing to do there because as a DMA-API
implementation the dma-iommu code cares about the address space
allocation.

As I understand it this is different in your case, as someone else is
defining the address space layout. So why do you need to allocate it
yourself?


	Joerg
