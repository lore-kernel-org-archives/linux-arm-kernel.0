From: lkp@intel.com (kbuild test robot)
Date: Fri, 29 Sep 2017 14:23:31 +0800
Subject: [PATCH v4 2/2] memory: ti-emif-sram: introduce relocatable
 suspend/resume handlers
In-Reply-To: <20170927000355.30597-3-d-gerlach@ti.com>
Message-ID: <201709291400.QaIXheU8%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.14-rc2]
[cannot apply to next-20170928]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Dave-Gerlach/Documentation-dt-Update-ti-emif-bindings/20170929-111250
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> drivers/memory/ti-emif-sram-pm.S:22:30: fatal error: emif-asm-offsets.h: No such file or directory
    #include "emif-asm-offsets.h"
                                 ^
   compilation terminated.

vim +22 drivers/memory/ti-emif-sram-pm.S

    20	
    21	#include "emif.h"
  > 22	#include "emif-asm-offsets.h"
    23	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 63995 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170929/cba8c2ac/attachment-0001.gz>
