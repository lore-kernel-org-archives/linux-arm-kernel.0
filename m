From: lkp@intel.com (kbuild test robot)
Date: Sun, 24 Jul 2016 09:41:40 +0800
Subject: [PATCH v11 4/8] vfio/type1: handle unmap/unpin and replay for
 VFIO_IOVA_RESERVED slots
In-Reply-To: <1468933894-23250-5-git-send-email-eric.auger@redhat.com>
Message-ID: <201607240918.hP8YWSxI%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test ERROR on vfio/next]
[also build test ERROR on v4.7-rc7 next-20160722]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Eric-Auger/KVM-PCIe-MSI-passthrough-on-ARM-ARM64-kernel-part-3-3-vfio-changes/20160724-082318
base:   https://github.com/awilliam/linux-vfio.git next
config: x86_64-rhel (attached as .config)
compiler: gcc-6 (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

>> drivers/vfio/vfio_iommu_type1.c:39:29: fatal error: linux/msi-iommu.h: No such file or directory
    #include <linux/msi-iommu.h>
                                ^
   compilation terminated.

vim +39 drivers/vfio/vfio_iommu_type1.c

    33	#include <linux/rbtree.h>
    34	#include <linux/sched.h>
    35	#include <linux/slab.h>
    36	#include <linux/uaccess.h>
    37	#include <linux/vfio.h>
    38	#include <linux/workqueue.h>
  > 39	#include <linux/msi-iommu.h>
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
Size: 37222 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160724/0a780fdb/attachment-0001.obj>
