From: lkp@intel.com (kbuild test robot)
Date: Mon, 19 Feb 2018 09:04:04 +0800
Subject: [PATCH 1/7 RESEND] arm64: move arm uprobes code to be reused by
 arm64
In-Reply-To: <1518780191-31094-2-git-send-email-m.slodczyk2@partner.samsung.com>
References: <1518780191-31094-2-git-send-email-m.slodczyk2@partner.samsung.com>
Message-ID: <201802190846.FhFpN7wE%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maciej,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on v4.16-rc1 next-20180216]
[cannot apply to linus/master]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Maciej-Slodczyk/arm64-uprobes-ARM32-instruction-probing/20180219-040158
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> arch/arm/probes/kprobes/test-core.c:215:10: fatal error: ../decode-arm.h: No such file or directory
    #include "../decode-arm.h"
             ^~~~~~~~~~~~~~~~~
   compilation terminated.

vim +215 arch/arm/probes/kprobes/test-core.c

c41584ddc arch/arm/kernel/kprobes-test.c      Leif Lindholm 2011-12-12  212  
fca08f326 arch/arm/probes/kprobes/test-core.c Wang Nan      2015-01-09  213  #include "core.h"
fca08f326 arch/arm/probes/kprobes/test-core.c Wang Nan      2015-01-09  214  #include "test-core.h"
fca08f326 arch/arm/probes/kprobes/test-core.c Wang Nan      2015-01-09 @215  #include "../decode-arm.h"
fca08f326 arch/arm/probes/kprobes/test-core.c Wang Nan      2015-01-09  216  #include "../decode-thumb.h"
9eed17977 arch/arm/kernel/kprobes-test.c      Jon Medhurst  2011-08-28  217  
9eed17977 arch/arm/kernel/kprobes-test.c      Jon Medhurst  2011-08-28  218  

:::::: The code at line 215 was first introduced by commit
:::::: fca08f326ae0423f03b097ff54de432fe77b95d0 ARM: probes: move all probe code to dedicate directory

:::::: TO: Wang Nan <wangnan0@huawei.com>
:::::: CC: Jon Medhurst <tixy@linaro.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 64572 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180219/0479f2ff/attachment-0001.gz>
