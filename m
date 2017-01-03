From: lkp@intel.com (kbuild test robot)
Date: Tue, 3 Jan 2017 20:26:10 +0800
Subject: [PATCH v4 2/3] soc: zte: pm_domains: Add support for zx296718
 board
In-Reply-To: <1483426577-5470-2-git-send-email-baoyou.xie@linaro.org>
Message-ID: <201701032003.qkbw7vjv%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Baoyou,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.10-rc2 next-20161224]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Baoyou-Xie/soc-zte-pm_domains-Prepare-for-supporting-ARMv8-zx2967-family/20170103-181714
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> drivers/soc/zte/zx296718_pm_domains.c:7:47: fatal error: dt-bindings/soc/zx2967,pm_domains.h: No such file or directory
    #include <dt-bindings/soc/zx2967,pm_domains.h>
                                                  ^
   compilation terminated.

vim +7 drivers/soc/zte/zx296718_pm_domains.c

     1	/*
     2	 * Copyright (C) 2015 ZTE Ltd.
     3	 *
     4	 * Author: Baoyou Xie <baoyou.xie@linaro.org>
     5	 * License terms: GNU General Public License (GPL) version 2
     6	 */
   > 7	#include <dt-bindings/soc/zx2967,pm_domains.h>
     8	#include "zx2967_pm_domains.h"
     9	
    10	static u16 zx296718_offsets[REG_ARRAY_SIZE] = {

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 60343 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170103/2d453a38/attachment-0001.gz>
