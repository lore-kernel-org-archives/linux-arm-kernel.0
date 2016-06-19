From: lkp@intel.com (kbuild test robot)
Date: Sun, 19 Jun 2016 10:12:24 +0800
Subject: [PATCH v3 3/5] i.MX: system.c: Replace magic numbers
In-Reply-To: <1466296268-27099-6-git-send-email-andrew.smirnov@gmail.com>
Message-ID: <201606191030.ZUZAsi57%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test ERROR on shawnguo/for-next]
[also build test ERROR on v4.7-rc3 next-20160617]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Andrey-Smirnov/i-MX-L2-cache-code-cleanups-and-performance-tweaks/20160619-083620
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git for-next
config: arm-multi_v7_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 5.3.1-8) 5.3.1 20160205
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   arch/arm/mach-imx/system.c: In function 'imx_init_l2cache':
>> arch/arm/mach-imx/system.c:112:10: error: implicit declaration of function 'L310_PREFETCH_CTRL_DBL_' [-Werror=implicit-function-declaration]
      val |= L310_PREFETCH_CTRL_DBL_
             ^
   cc1: some warnings being treated as errors

vim +/L310_PREFETCH_CTRL_DBL_ +112 arch/arm/mach-imx/system.c

   106			goto out;
   107		}
   108	
   109		if (!(readl_relaxed(l2x0_base + L2X0_CTRL) & L2X0_CTRL_EN)) {
   110			/* Configure the L2 PREFETCH and POWER registers */
   111			val = readl_relaxed(l2x0_base + L310_PREFETCH_CTRL);
 > 112			val |= L310_PREFETCH_CTRL_DBL_
   113				L310_PREFETCH_CTRL_INSTR_PREFETCH |
   114				L310_PREFETCH_CTRL_DATA_PREFETCH |
   115				L310_PREFETCH_CTRL_DBL_LINEFILL_INCR;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 37700 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160619/fa9cf85e/attachment-0001.obj>
