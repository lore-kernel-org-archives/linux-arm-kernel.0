From: lkp@intel.com (kbuild test robot)
Date: Wed, 20 Apr 2016 02:04:19 +0800
Subject: [PATCH v7 7/8] genirq/msi: map/unmap the MSI doorbells on
 msi_domain_alloc/free_irqs
In-Reply-To: <1461085990-2547-8-git-send-email-eric.auger@linaro.org>
Message-ID: <201604200215.XNyvZSsl%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test ERROR on tip/irq/core]
[also build test ERROR on v4.6-rc4 next-20160419]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Eric-Auger/KVM-PCIe-MSI-passthrough-on-ARM-ARM64-kernel-part-2-3-msi-changes/20160420-011957
config: x86_64-lkp (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

>> kernel/irq/msi.c:17:38: fatal error: linux/dma-reserved-iommu.h: No such file or directory
    #include <linux/dma-reserved-iommu.h>
                                         ^
   compilation terminated.

vim +17 kernel/irq/msi.c

    11	 */
    12	#include <linux/types.h>
    13	#include <linux/device.h>
    14	#include <linux/irq.h>
    15	#include <linux/irqdomain.h>
    16	#include <linux/msi.h>
  > 17	#include <linux/dma-reserved-iommu.h>
    18	#include <linux/iommu.h>
    19	
    20	/* Temparory solution for building, will be removed later */

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 22417 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160420/f6b60d8e/attachment-0001.obj>
