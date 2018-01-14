From: fengguang.wu@intel.com (kbuild test robot)
Date: Mon, 15 Jan 2018 04:57:24 +0800
Subject: [arm-platforms:kvm-arm/pmuv3-32bit 2/5]
 include/linux/perf/arm_pmuv3.h:20:10: fatal error: asm/arm_pmuv3.h: No such
 file or directory
Message-ID: <201801150423.0vFrmCmM%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm/pmuv3-32bit
head:   283a7dae09aff137f0525917d750b62b1d135cae
commit: d7793b5299f56651ac99ee59e7c51b375b0e7d9c [2/5] arm64: perf: Abstract system register accesses away
config: arm-axm55xx_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout d7793b5299f56651ac99ee59e7c51b375b0e7d9c
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

Note: the arm-platforms/kvm-arm/pmuv3-32bit HEAD 283a7dae09aff137f0525917d750b62b1d135cae builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   In file included from include/kvm/arm_pmu.h:22:0,
                    from arch/arm/kvm/../../../virt/kvm/arm/arm.c:33:
>> include/linux/perf/arm_pmuv3.h:20:10: fatal error: asm/arm_pmuv3.h: No such file or directory
    #include <asm/arm_pmuv3.h>
             ^~~~~~~~~~~~~~~~~
   compilation terminated.

vim +20 include/linux/perf/arm_pmuv3.h

    19	
  > 20	#include <asm/arm_pmuv3.h>
    21	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 20370 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180115/dccb8773/attachment-0001.gz>
