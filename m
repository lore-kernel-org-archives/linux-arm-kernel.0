From: liubo95@huawei.com (Bob Liu)
Date: Fri, 24 Nov 2017 16:23:26 +0800
Subject: [RFCv2 PATCH 10/36] vfio: Add support for Shared Virtual Memory
In-Reply-To: <20171006133203.22803-11-jean-philippe.brucker@arm.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
 <20171006133203.22803-11-jean-philippe.brucker@arm.com>
Message-ID: <419afe22-816d-263f-9c85-1a9e28c723b7@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017/10/6 21:31, Jean-Philippe Brucker wrote:
> Add two new ioctl for VFIO containers. VFIO_DEVICE_BIND_PROCESS creates a
> bond between a container and a process address space, identified by a
> device-specific ID named PASID. This allows the device to target DMA
> transactions at the process virtual addresses without a need for mapping
> and unmapping buffers explicitly in the IOMMU. The process page tables are
> shared with the IOMMU, and mechanisms such as PCI ATS/PRI may be used to
> handle faults. VFIO_DEVICE_UNBIND_PROCESS removed a bond identified by a
> PASID.
> 

How about hide bind/unbind into ioctl(VFIO_SET_IOMMU)? 
e.g always bind to current process in SET_IOMMU.

Not sure about the real use case.

> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> ---
>  drivers/vfio/vfio_iommu_type1.c | 243 +++++++++++++++++++++++++++++++++++++++-
>  include/uapi/linux/vfio.h       |  69 ++++++++++++
>  2 files changed, 311 insertions(+), 1 deletion(-)
> 
