From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 27 Sep 2017 13:34:30 +0100
Subject: [PATCH 1/2] iommu/io-pgtable-arm: Convert to IOMMU API TLB sync
In-Reply-To: <20170927122726.GM8398@8bytes.org>
References: <a472d061559a6afcc4631e881e9420944471f461.1505747866.git.robin.murphy@arm.com>
 <20170922154322.GA27080@arm.com> <20170927122726.GM8398@8bytes.org>
Message-ID: <1d55901b-e1a6-c3d5-b039-4c63b724c468@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/09/17 13:27, Joerg Roedel wrote:
> Hi Will, Robin,
> 
> On Fri, Sep 22, 2017 at 04:43:22PM +0100, Will Deacon wrote:
>> Joerg, do you reckon it's worth merging this as-is, or should we also
>> hook up add_flush before implementing this?
> 
> The patches implement .iotlb_sync() so that it is okay to not have a
> .iotlb_range_add() call-back for now. But the patches lack a
> .flush_iotlb_range() call-back, which is strictly necessary for
> correctness because it is defined to be synchronous and doesn't require
> a sync-call afterwards.

Good point - even with the flush still implicit in the unmap, an
iommu_unmap_fast()/iommu_flush_iotlb_all() sequence would indeed be
missing a sync at the end. I'll fix that up and post a new version shortly.

Thanks,
Robin.
