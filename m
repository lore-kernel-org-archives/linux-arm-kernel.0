From: eric.auger@linaro.org (Eric Auger)
Date: Mon, 4 Apr 2016 11:35:09 +0200
Subject: [PATCH v6 2/5] vfio: allow the user to register reserved iova
 range for MSI mapping
In-Reply-To: <201604041755.NOuQMtNK%fengguang.wu@intel.com>
References: <201604041755.NOuQMtNK%fengguang.wu@intel.com>
Message-ID: <5702354D.7000101@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/04/2016 11:30 AM, kbuild test robot wrote:
> Hi Eric,
> 
> [auto build test ERROR on iommu/next]
> [also build test ERROR on v4.6-rc2 next-20160404]
> [if your patch is applied to the wrong git tree, please drop us a note to help improving the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Eric-Auger/KVM-PCIe-MSI-passthrough-on-ARM-ARM64-kernel-part-3-3-vfio-changes/20160404-163335
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git next
> config: x86_64-randconfig-s1-04041632 (attached as .config)
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
This series needs to be applied on top of
- part 2: [PATCH v6 0/4] KVM PCIe/MSI passthrough on ARM/ARM64: kernel
part 2/3: msi changes, https://lkml.org/lkml/2016/4/4/104
- part 1 ([PATCH v6 0/7] KVM PCIe/MSI passthrough on ARM/ARM64: kernel
part 1/3: iommu changes, https://lkml.org/lkml/2016/4/4/90)


Best Regards

Eric
> 
> All errors (new ones prefixed by >>):
> 
>>> drivers/vfio/vfio_iommu_type1.c:39:38: fatal error: linux/dma-reserved-iommu.h: No such file or directory
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
>   > 39	#include <linux/dma-reserved-iommu.h>
>     40	
>     41	#define DRIVER_VERSION  "0.2"
>     42	#define DRIVER_AUTHOR   "Alex Williamson <alex.williamson@redhat.com>"
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
