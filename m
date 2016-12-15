From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 15 Dec 2016 14:59:06 +0000
Subject: Need some information about IOMMU support for ARM64 in 4.6
In-Reply-To: <E6F4274F7BEC774AAA4E7A98618BCFAE132076@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <E6F4274F7BEC774AAA4E7A98618BCFAE132076@XAP-PVEXMBX01.xlnx.xilinx.com>
Message-ID: <a02aee03-00ff-4855-73fe-a5ac809c461c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Barghav,

I assume you're talking about the ARM SMMU(v2)?

On 15/12/16 06:50, Bhargav Shah wrote:
> Hi,
> I am using kernel version 4.6.
> of_iommu_configure() gets IOMMU ops from of_iommu_list and call arch_setup_dma_ops.
> Presently, __iommu_setup_dma_ops() it expects iommu ops to be present. 
> Here, of_iommu_configure() get NULL iommu ops and it calls arch_setup_dma_ops with it.
> 
> So, in my current flow iommu ops is not getting set for device.

Yes. The SMMUv2 driver in 4.6 does not call of_iommu_set_ops(). That's
because it doesn't support of_xlate() either, so in general can't be
used for DMA ops. The default domain support which went into 4.6 was
just some early groundwork which, in hindsight, caused more problems
than it solved at that time.

> Am I missing something  which is causing this ?
> What is proper way to set iommu ops to device ? 

The proper way would be to update to 4.9, where full generic
configuration and DMA ops support finally landed ;)

Robin.

> 
> Thanks
> Bhargav 
> 
> 
