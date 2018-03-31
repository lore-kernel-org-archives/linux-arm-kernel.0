From: lkp@intel.com (kbuild test robot)
Date: Sat, 31 Mar 2018 12:39:25 +0800
Subject: [PATCH v4 01/14] soc: qcom: Separate kryo l2 accessors from PMU
 driver
In-Reply-To: <1522358807-10413-2-git-send-email-ilialin@codeaurora.org>
References: <1522358807-10413-2-git-send-email-ilialin@codeaurora.org>
Message-ID: <201803311139.Z34ksG0T%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ilia,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on clk/clk-next]
[also build test ERROR on v4.16-rc7 next-20180329]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Ilia-Lin/soc-qcom-Separate-kryo-l2-accessors-from-PMU-driver/20180331-093947
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> drivers/soc/qcom/kryo-l2-accessors.c:17:10: fatal error: asm/sysreg.h: No such file or directory
    #include <asm/sysreg.h>
             ^~~~~~~~~~~~~~
   compilation terminated.

vim +17 drivers/soc/qcom/kryo-l2-accessors.c

  > 17	#include <asm/sysreg.h>
    18	#include <soc/qcom/kryo-l2-accessors.h>
    19	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 65187 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180331/f9ddd27b/attachment-0001.gz>
