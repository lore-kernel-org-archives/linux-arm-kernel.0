From: lkp@intel.com (kbuild test robot)
Date: Mon, 4 Apr 2016 17:22:23 +0800
Subject: [PATCH v6 4/4] msi: IOMMU map the doorbell address when needed
In-Reply-To: <1459757972-2814-5-git-send-email-eric.auger@linaro.org>
Message-ID: <201604041717.U3ElVlv7%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

[auto build test ERROR on tip/irq/core]
[also build test ERROR on v4.6-rc2 next-20160404]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Eric-Auger/KVM-PCIe-MSI-passthrough-on-ARM-ARM64-kernel-part-2-3-msi-changes/20160404-162527
config: x86_64-randconfig-s1-04041632 (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

>> kernel/irq/msi.c:21:38: fatal error: linux/dma-reserved-iommu.h: No such file or directory
   compilation terminated.

vim +21 kernel/irq/msi.c

    15	#include <linux/irqdomain.h>
    16	#include <linux/msi.h>
    17	
    18	/* Temparory solution for building, will be removed later */
    19	#include <linux/pci.h>
    20	#include <linux/iommu.h>
  > 21	#include <linux/dma-reserved-iommu.h>
    22	
    23	struct msi_desc *alloc_msi_entry(struct device *dev)
    24	{

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 27840 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160404/e0469232/attachment-0001.obj>
