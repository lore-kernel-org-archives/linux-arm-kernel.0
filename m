From: bhargav.shah@xilinx.com (Bhargav Shah)
Date: Thu, 15 Dec 2016 06:50:58 +0000
Subject: Need some information about IOMMU support for ARM64 in 4.6
Message-ID: <E6F4274F7BEC774AAA4E7A98618BCFAE132076@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
I am using kernel version 4.6.
of_iommu_configure() gets IOMMU ops from of_iommu_list and call arch_setup_dma_ops.
Presently, __iommu_setup_dma_ops() it expects iommu ops to be present. 
Here, of_iommu_configure() get NULL iommu ops and it calls arch_setup_dma_ops with it.

So, in my current flow iommu ops is not getting set for device.

Am I missing something  which is causing this ?
What is proper way to set iommu ops to device ? 

Thanks
Bhargav 
