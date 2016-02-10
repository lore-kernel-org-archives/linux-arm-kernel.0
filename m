From: lkp@intel.com (kbuild test robot)
Date: Wed, 10 Feb 2016 12:10:33 +0800
Subject: [PATCH] pci: xgene: Add ECAM fixups
In-Reply-To: <1455068984-22210-1-git-send-email-dhdang@apm.com>
Message-ID: <201602101236.v5Xf48zl%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Duc,

[auto build test ERROR on pci/next]
[also build test ERROR on v4.5-rc3 next-20160209]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Duc-Dang/pci-xgene-Add-ECAM-fixups/20160210-095702
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
config: arm64-allyesconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

>> drivers/pci/host/pci-xgene.c:34:24: fatal error: linux/ecam.h: No such file or directory
    #include <linux/ecam.h>
                           ^
   compilation terminated.

vim +34 drivers/pci/host/pci-xgene.c

    28	#include <linux/of_pci.h>
    29	#include <linux/pci.h>
    30	#include <linux/platform_device.h>
    31	#include <linux/slab.h>
    32	#ifdef CONFIG_ACPI
    33	#include <linux/acpi.h>
  > 34	#include <linux/ecam.h>
    35	#include <linux/pci-acpi.h>
    36	#endif
    37	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 48147 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160210/ef5471ae/attachment-0001.obj>
