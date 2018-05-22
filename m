From: lkp@intel.com (kbuild test robot)
Date: Tue, 22 May 2018 21:49:39 +0800
Subject: [PATCH v8 04/15] clk: qcom: Add CPU clock driver for msm8996
In-Reply-To: <1526555955-29960-5-git-send-email-ilialin@codeaurora.org>
References: <1526555955-29960-5-git-send-email-ilialin@codeaurora.org>
Message-ID: <201805222147.CWKD3iui%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ilia,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on v4.17-rc6]
[cannot apply to clk/clk-next next-20180517]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Ilia-Lin/CPU-scaling-support-for-msm8996/20180520-132401
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arm-allyesconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> drivers/soc/qcom/kryo-l2-accessors.c:7:10: fatal error: asm/sysreg.h: No such file or directory
    #include <asm/sysreg.h>
             ^~~~~~~~~~~~~~
   compilation terminated.

vim +7 drivers/soc/qcom/kryo-l2-accessors.c

f4e14120 Ilia Lin 2018-05-17 @7  #include <asm/sysreg.h>
f4e14120 Ilia Lin 2018-05-17  8  #include <soc/qcom/kryo-l2-accessors.h>
f4e14120 Ilia Lin 2018-05-17  9  

:::::: The code at line 7 was first introduced by commit
:::::: f4e14120d663ce6e4670516a66bc0158dc692c45 soc: qcom: Separate kryo l2 accessors from PMU driver

:::::: TO: Ilia Lin <ilialin@codeaurora.org>
:::::: CC: 0day robot <lkp@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 64542 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180522/d0336abb/attachment-0001.gz>
