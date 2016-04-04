From: eric.auger@linaro.org (Eric Auger)
Date: Mon, 4 Apr 2016 11:28:22 +0200
Subject: [PATCH v6 4/4] msi: IOMMU map the doorbell address when needed
In-Reply-To: <201604041717.U3ElVlv7%fengguang.wu@intel.com>
References: <201604041717.U3ElVlv7%fengguang.wu@intel.com>
Message-ID: <570233B6.8080805@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/04/2016 11:22 AM, kbuild test robot wrote:
> Hi Eric,
> 
> [auto build test ERROR on tip/irq/core]
> [also build test ERROR on v4.6-rc2 next-20160404]
> [if your patch is applied to the wrong git tree, please drop us a note to help improving the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Eric-Auger/KVM-PCIe-MSI-passthrough-on-ARM-ARM64-kernel-part-2-3-msi-changes/20160404-162527
> config: x86_64-randconfig-s1-04041632 (attached as .config)
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All errors (new ones prefixed by >>):
> 
>>> kernel/irq/msi.c:21:38: fatal error: linux/dma-reserved-iommu.h: No such file or directory
>    compilation terminated.

Yes this was expected. this series needs to be applied on part 1: [PATCH
v6 0/7] KVM PCIe/MSI passthrough on ARM/ARM64: kernel part 1/3: iommu
changes, https://lkml.org/lkml/2016/4/4/90.

Same for part 3.

I split the whole series to ease the review process however this comes
at the expense of automatic testing. Sorry for that.

Best Regards

Eric


> 
> vim +21 kernel/irq/msi.c
> 
>     15	#include <linux/irqdomain.h>
>     16	#include <linux/msi.h>
>     17	
>     18	/* Temparory solution for building, will be removed later */
>     19	#include <linux/pci.h>
>     20	#include <linux/iommu.h>
>   > 21	#include <linux/dma-reserved-iommu.h>
>     22	
>     23	struct msi_desc *alloc_msi_entry(struct device *dev)
>     24	{
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
