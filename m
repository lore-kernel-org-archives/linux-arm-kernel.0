From: lkp@intel.com (kbuild test robot)
Date: Fri, 9 Nov 2018 18:18:24 +0800
Subject: [PATCH v12 2/5] clk: imx: add fractional PLL output clock
In-Reply-To: <1541594266-16712-3-git-send-email-abel.vesa@nxp.com>
References: <1541594266-16712-3-git-send-email-abel.vesa@nxp.com>
Message-ID: <201811091832.kSh4BXdS%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lucas,

I love your patch! Yet something to improve:

[auto build test ERROR on shawnguo/for-next]
[also build test ERROR on v4.20-rc1 next-20181109]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Abel-Vesa/Add-i-MX8MQ-clock-driver/20181109-063930
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git for-next
config: arm-multi_v5_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   drivers/clk/imx/clk-frac-pll.o: In function `clk_pll_recalc_rate':
>> clk-frac-pll.c:(.text+0x74): undefined reference to `__aeabi_uldivmod'
   drivers/clk/imx/clk-frac-pll.o: In function `clk_pll_round_rate':
   clk-frac-pll.c:(.text+0xbc): undefined reference to `__aeabi_uldivmod'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 30313 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181109/e29a5c7b/attachment-0001.gz>
