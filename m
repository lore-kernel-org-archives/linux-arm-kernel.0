From: liubo95@huawei.com (Bob Liu)
Date: Wed, 22 Nov 2017 11:15:24 +0800
Subject: [RFCv2 PATCH 01/36] iommu: Keep track of processes and PASIDs
In-Reply-To: <20171006133203.22803-2-jean-philippe.brucker@arm.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
 <20171006133203.22803-2-jean-philippe.brucker@arm.com>
Message-ID: <588ad6f0-e78a-63de-e27a-3da4de4ab2ab@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Jean,

On 2017/10/6 21:31, Jean-Philippe Brucker wrote:
> IOMMU drivers need a way to bind Linux processes to devices. This is used
> for Shared Virtual Memory (SVM), where devices support paging. In that
> mode, DMA can directly target virtual addresses of a process.
> 
> Introduce boilerplate code for allocating process structures and binding
> them to devices. Four operations are added to IOMMU drivers:
> 
> * process_alloc, process_free: to create an iommu_process structure and
>   perform architecture-specific operations required to grab the process
>   (for instance on ARM SMMU, pin down the CPU ASID). There is a single
>   iommu_process structure per Linux process.
> 

I'm a bit confused here.
The original meaning of iommu_domain is a virtual addrspace defined by a set of io page table.
(fix me if I misunderstood).
Then what's the meaning of iommu_domain and iommu_process after introducing iommu_process?
Could you consider document these concepts? 

Thanks,
Liubo
