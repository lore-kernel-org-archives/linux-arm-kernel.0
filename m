From: lkp@intel.com (kbuild test robot)
Date: Fri, 25 Nov 2016 22:32:46 +0800
Subject: [PATCH v17 08/15] clocksource/drivers/arm_arch_timer: move
 arch_timer_needs_of_probing into DT init call
In-Reply-To: <20161125084623.22515-9-fu.wei@linaro.org>
Message-ID: <201611252221.UyJ9iWPV%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fu,

[auto build test ERROR on pm/linux-next]
[also build test ERROR on v4.9-rc6]
[cannot apply to tip/timers/core next-20161125]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/fu-wei-linaro-org/acpi-clocksource-add-GTDT-driver-and-GTDT-support-in-arm_arch_timer/20161125-171111
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

Note: the linux-review/fu-wei-linaro-org/acpi-clocksource-add-GTDT-driver-and-GTDT-support-in-arm_arch_timer/20161125-171111 HEAD 498f1f2503da21841b0e7679ddbdb86a40451bdb builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   drivers/clocksource/arm_arch_timer.c: In function 'arch_timer_acpi_init':
>> drivers/clocksource/arm_arch_timer.c:1071:2: error: 'ret' undeclared (first use in this function)
     ret = arch_timer_register();
     ^~~
   drivers/clocksource/arm_arch_timer.c:1071:2: note: each undeclared identifier is reported only once for each function it appears in

vim +/ret +1071 drivers/clocksource/arm_arch_timer.c

  1065			return -EINVAL;
  1066		}
  1067	
  1068		/* Always-on capability */
  1069		arch_timer_c3stop = !(gtdt->non_secure_el1_flags & ACPI_GTDT_ALWAYS_ON);
  1070	
> 1071		ret = arch_timer_register();
  1072		if (ret)
  1073			return ret;
  1074	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 31917 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161125/cf2e05c2/attachment-0001.gz>
