From: lkp@intel.com (kbuild test robot)
Date: Sat, 19 May 2018 23:42:49 +0800
Subject: [arm-platforms:kvm-arm/pmuv3-32bit 2/5]
 include/linux/perf/arm_pmuv3.h:21:10: fatal error: asm/arm_pmuv3.h: No such
 file or directory
Message-ID: <201805192347.6uL3iApo%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm/pmuv3-32bit
head:   582eb41425e31201afb545db00bb25b39d6e3091
commit: b5297bf07d662cccffbb922e0d0488df25245b0a [2/5] arm64: perf: Abstract system register accesses away
config: arm-axm55xx_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout b5297bf07d662cccffbb922e0d0488df25245b0a
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

Note: the arm-platforms/kvm-arm/pmuv3-32bit HEAD 582eb41425e31201afb545db00bb25b39d6e3091 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   In file included from include/kvm/arm_pmu.h:22:0,
                    from arch/arm/kvm/../../../virt/kvm/arm/arm.c:33:
>> include/linux/perf/arm_pmuv3.h:21:10: fatal error: asm/arm_pmuv3.h: No such file or directory
    #include <asm/arm_pmuv3.h>
             ^~~~~~~~~~~~~~~~~
   compilation terminated.

vim +21 include/linux/perf/arm_pmuv3.h

    20	
  > 21	#include <asm/arm_pmuv3.h>
    22	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 19846 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180519/3445cbe2/attachment-0001.gz>
