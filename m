From: lkp@intel.com (kbuild test robot)
Date: Wed, 3 Aug 2016 13:49:31 +0800
Subject: [PATCH v12 6/8] vfio/type1: check doorbell safety
In-Reply-To: <1470159012-7110-7-git-send-email-eric.auger@redhat.com>
Message-ID: <201608031314.kN4c6thc%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

[auto build test ERROR on vfio/next]
[also build test ERROR on v4.7]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Eric-Auger/KVM-PCIe-MSI-passthrough-on-ARM-ARM64-kernel-part-3-3-vfio-changes/20160803-122924
base:   https://github.com/awilliam/linux-vfio.git next
config: x86_64-randconfig-s1-08031247 (attached as .config)
compiler: gcc-4.4 (Debian 4.4.7-8) 4.4.7
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers/vfio/vfio_iommu_type1.c:39:29: error: linux/msi-iommu.h: No such file or directory
>> drivers/vfio/vfio_iommu_type1.c:40:32: error: linux/msi-doorbell.h: No such file or directory
   drivers/vfio/vfio_iommu_type1.c: In function 'vfio_set_msi_aperture':
   drivers/vfio/vfio_iommu_type1.c:453: error: implicit declaration of function 'iommu_msi_set_aperture'
   drivers/vfio/vfio_iommu_type1.c: In function 'vfio_iommu_type1_attach_group':
>> drivers/vfio/vfio_iommu_type1.c:933: error: implicit declaration of function 'msi_doorbell_safe'
   At top level:
   cc1: warning: unrecognized command line option "-Wno-maybe-uninitialized"

vim +40 drivers/vfio/vfio_iommu_type1.c

    33	#include <linux/rbtree.h>
    34	#include <linux/sched.h>
    35	#include <linux/slab.h>
    36	#include <linux/uaccess.h>
    37	#include <linux/vfio.h>
    38	#include <linux/workqueue.h>
  > 39	#include <linux/msi-iommu.h>
  > 40	#include <linux/msi-doorbell.h>
    41	
    42	#define DRIVER_VERSION  "0.2"
    43	#define DRIVER_AUTHOR   "Alex Williamson <alex.williamson@redhat.com>"

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 19855 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160803/b1f7903a/attachment-0001.obj>
