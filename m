From: lkp@intel.com (kbuild test robot)
Date: Mon, 25 Jul 2016 04:26:42 +0800
Subject: [PATCH v8 4/9] clocksource/drivers/arm_arch_timer: use readq to
 get 64-bit CNTVCT
In-Reply-To: <1468952284-28942-5-git-send-email-fu.wei@linaro.org>
Message-ID: <201607250415.f4732fEH%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test ERROR on stable/master]
[cannot apply to tip/timers/core pm/linux-next next-20160724]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/fu-wei-linaro-org/acpi-clocksource-add-GTDT-driver-and-GTDT-support-in-arm_arch_timer/20160725-022614
base:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git master
config: arm-sunxi_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 5.4.0-6) 5.4.0 20160609
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   drivers/clocksource/arm_arch_timer.c: In function 'arch_counter_get_cntvct_mem':
>> drivers/clocksource/arm_arch_timer.c:421:9: error: implicit declaration of function 'readq' [-Werror=implicit-function-declaration]
     return readq(arch_counter_base + CNTVCT_LO);
            ^
   cc1: some warnings being treated as errors

vim +/readq +421 drivers/clocksource/arm_arch_timer.c

   415	{
   416		return arch_timer_rate;
   417	}
   418	
   419	static u64 arch_counter_get_cntvct_mem(void)
   420	{
 > 421		return readq(arch_counter_base + CNTVCT_LO);
   422	}
   423	
   424	/*

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 19385 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160725/6fab7e8c/attachment-0001.obj>
