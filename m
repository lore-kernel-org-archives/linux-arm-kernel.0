From: eric.auger@linaro.org (Eric Auger)
Date: Wed, 20 Apr 2016 09:47:19 +0200
Subject: [PATCH v7 7/8] genirq/msi: map/unmap the MSI doorbells on
 msi_domain_alloc/free_irqs
In-Reply-To: <201604200215.XNyvZSsl%fengguang.wu@intel.com>
References: <201604200215.XNyvZSsl%fengguang.wu@intel.com>
Message-ID: <57173407.9040401@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Both reported errors related to this series are due to the fact part n
has dependency on part n-1.

Does anyone know how to let the 0-day CI robot know about such
dependency between series?

If it is an inconvenience I can put all the patches back into the same
big series, specifying tentative patch split according to sub-systems in
the cover-letter?

Thank you in advance

Best Regards

Eric

04/19/2016 08:04 PM, kbuild test robot wrote:
> Hi,
> 
> [auto build test ERROR on tip/irq/core]
> [also build test ERROR on v4.6-rc4 next-20160419]
> [if your patch is applied to the wrong git tree, please drop us a note to help improving the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Eric-Auger/KVM-PCIe-MSI-passthrough-on-ARM-ARM64-kernel-part-2-3-msi-changes/20160420-011957
> config: x86_64-lkp (attached as .config)
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All errors (new ones prefixed by >>):
> 
>>> kernel/irq/msi.c:17:38: fatal error: linux/dma-reserved-iommu.h: No such file or directory
>     #include <linux/dma-reserved-iommu.h>
>                                          ^
>    compilation terminated.
> 
> vim +17 kernel/irq/msi.c
> 
>     11	 */
>     12	#include <linux/types.h>
>     13	#include <linux/device.h>
>     14	#include <linux/irq.h>
>     15	#include <linux/irqdomain.h>
>     16	#include <linux/msi.h>
>   > 17	#include <linux/dma-reserved-iommu.h>
>     18	#include <linux/iommu.h>
>     19	
>     20	/* Temparory solution for building, will be removed later */
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
