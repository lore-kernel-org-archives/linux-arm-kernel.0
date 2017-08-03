From: lkp@intel.com (kbuild test robot)
Date: Thu, 3 Aug 2017 20:12:46 +0800
Subject: [patch v1 2/2] drivers: jtag: Add Aspeed SoC 24xx and 25xx
 families JTAG master driver
In-Reply-To: <1501679918-20486-3-git-send-email-oleksandrs@mellanox.com>
Message-ID: <201708032035.PvPxwkZr%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Oleksandr,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.13-rc3 next-20170802]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Oleksandr-Shamray/JTAG-driver-introduction/20170803-110721
config: arm64-allmodconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

>> drivers/jtag/jtag-aspeed.c:34:28: fatal error: asm/mach-types.h: No such file or directory
    #include <asm/mach-types.h>
                               ^
   compilation terminated.

vim +34 drivers/jtag/jtag-aspeed.c

  > 34	#include <asm/mach-types.h>
    35	#include <asm/mach/arch.h>
    36	#include <linux/clk.h>
    37	#include <linux/device.h>
    38	#include <linux/interrupt.h>
    39	#include <linux/jtag.h>
    40	#include <linux/kernel.h>
    41	#include <linux/module.h>
    42	#include <linux/of_address.h>
    43	#include <linux/platform_device.h>
    44	#include <linux/slab.h>
    45	#include <uapi/linux/jtag.h>
    46	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 56842 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170803/33b4b638/attachment-0001.gz>
