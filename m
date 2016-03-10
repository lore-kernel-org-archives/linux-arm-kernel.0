From: lkp@intel.com (kbuild test robot)
Date: Fri, 11 Mar 2016 05:19:19 +0800
Subject: [PATCH 15/18] ARM: vf610: PM: initial suspend/resume support
In-Reply-To: <1457576219-7971-16-git-send-email-stefan@agner.ch>
Message-ID: <201603110523.voIa120E%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

[auto build test ERROR on shawnguo/for-next]
[also build test ERROR on v4.5-rc7]
[cannot apply to next-20160310]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Stefan-Agner/ARM-vf610-Suspend-resume-with-self-refresh-mode/20160310-102621
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git for-next
config: arm-vf610m4_defconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   arch/arm/mach-imx/pm-vf610.c: In function 'vf610_suspend_finish':
>> arch/arm/mach-imx/pm-vf610.c:348:3: error: implicit declaration of function 'local_flush_tlb_all' [-Werror=implicit-function-declaration]
      local_flush_tlb_all();
      ^
   cc1: some warnings being treated as errors

vim +/local_flush_tlb_all +348 arch/arm/mach-imx/pm-vf610.c

   342			cpu_do_idle();
   343		} else {
   344			/*
   345			 * call low level suspend function in ocram,
   346			 * as we need to float DDR IO.
   347			 */
 > 348			local_flush_tlb_all();
   349			flush_cache_all();
   350			outer_flush_all();
   351			vf610_suspend_in_ocram_fn(suspend_ocram_base);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 7259 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160311/1c30b81c/attachment.obj>
