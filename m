From: lkp@intel.com (kbuild test robot)
Date: Wed, 20 Apr 2016 11:05:04 +0800
Subject: [PATCH v7 3/7] vfio/type1: specialize remove_dma and replay
 according to type
In-Reply-To: <1461086687-2658-4-git-send-email-eric.auger@linaro.org>
Message-ID: <201604201036.N5sysMVJ%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test ERROR on iommu/next]
[also build test ERROR on v4.6-rc4 next-20160419]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Eric-Auger/KVM-PCIe-MSI-passthrough-on-ARM-ARM64-kernel-part-3-3-vfio-changes/20160420-013110
base:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git next
config: x86_64-rhel (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

>> drivers/vfio/vfio_iommu_type1.c:39:38: fatal error: linux/dma-reserved-iommu.h: No such file or directory
    #include <linux/dma-reserved-iommu.h>
                                         ^
   compilation terminated.

vim +39 drivers/vfio/vfio_iommu_type1.c

    33	#include <linux/rbtree.h>
    34	#include <linux/sched.h>
    35	#include <linux/slab.h>
    36	#include <linux/uaccess.h>
    37	#include <linux/vfio.h>
    38	#include <linux/workqueue.h>
  > 39	#include <linux/dma-reserved-iommu.h>
    40	
    41	#define DRIVER_VERSION  "0.2"
    42	#define DRIVER_AUTHOR   "Alex Williamson <alex.williamson@redhat.com>"

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 36435 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160420/860cc76e/attachment-0001.obj>
