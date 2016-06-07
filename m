From: eric.auger@redhat.com (Auger Eric)
Date: Tue, 7 Jun 2016 18:41:57 +0200
Subject: [PATCH v10 4/8] vfio/type1: handle unmap/unpin and replay for
 VFIO_IOVA_RESERVED slots
In-Reply-To: <201606080053.GBblobZp%fengguang.wu@intel.com>
References: <201606080053.GBblobZp%fengguang.wu@intel.com>
Message-ID: <5d5b1dd9-5116-f8ea-101b-bb47f1e17980@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,
Le 07/06/2016 ? 18:44, kbuild test robot a ?crit :
> Hi,
> 
> [auto build test ERROR on vfio/next]
> [also build test ERROR on v4.7-rc2 next-20160607]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Eric-Auger/KVM-PCIe-MSI-passthrough-on-ARM-ARM64-kernel-part-3-3-vfio-changes/20160608-001148
> base:   https://github.com/awilliam/linux-vfio.git next
> config: x86_64-rhel (attached as .config)
> compiler: gcc-4.9 (Debian 4.9.3-14) 4.9.3
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All errors (new ones prefixed by >>):
> 
>>> drivers/vfio/vfio_iommu_type1.c:39:29: fatal error: linux/msi-iommu.h: No such file or directory
>     #include <linux/msi-iommu.h>
this is due to the dependency on part2 (MSI layer changes).

Best Regards

Eric
>                                 ^
>    compilation terminated.
> 
> vim +39 drivers/vfio/vfio_iommu_type1.c
> 
>     33	#include <linux/rbtree.h>
>     34	#include <linux/sched.h>
>     35	#include <linux/slab.h>
>     36	#include <linux/uaccess.h>
>     37	#include <linux/vfio.h>
>     38	#include <linux/workqueue.h>
>   > 39	#include <linux/msi-iommu.h>
>     40	
>     41	#define DRIVER_VERSION  "0.2"
>     42	#define DRIVER_AUTHOR   "Alex Williamson <alex.williamson@redhat.com>"
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
