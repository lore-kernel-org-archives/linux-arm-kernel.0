From: lkp@intel.com (kbuild test robot)
Date: Fri, 8 Sep 2017 07:25:42 +0800
Subject: [PATCH v2 1/3] arm64/ras: support sea error recovery
In-Reply-To: <1504609566-66318-2-git-send-email-xiexiuqi@huawei.com>
Message-ID: <201709080708.qJGN76YL%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Xie,

[auto build test ERROR on pm/linux-next]
[also build test ERROR on v4.13]
[cannot apply to arm64/for-next/core next-20170907]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Xie-XiuQi/arm64-ras-support-sea-error-recovery/20170908-062353
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
config: x86_64-allyesdebian (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

>> drivers/acpi/apei/ghes.c:54:21: fatal error: asm/ras.h: No such file or directory
    #include <asm/ras.h>
                        ^
   compilation terminated.

vim +54 drivers/acpi/apei/ghes.c

    49	
    50	#include <acpi/actbl1.h>
    51	#include <acpi/ghes.h>
    52	#include <acpi/apei.h>
    53	#include <asm/tlbflush.h>
  > 54	#include <asm/ras.h>
    55	#include <ras/ras_event.h>
    56	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 39282 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170908/e6026ec8/attachment-0001.gz>
