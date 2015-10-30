From: lkp@intel.com (kbuild test robot)
Date: Fri, 30 Oct 2015 20:08:13 +0800
Subject: [PATCH v4 18/21] KVM: ARM64: Add PMU overflow interrupt routing
In-Reply-To: <1446186123-11548-19-git-send-email-zhaoshenglong@huawei.com>
Message-ID: <201510302030.qrh0XuT1%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shannon,

[auto build test ERROR on kvm/linux-next -- if it's inappropriate base, please suggest rules for selecting the more suitable base]

url:    https://github.com/0day-ci/linux/commits/Shannon-Zhao/KVM-ARM64-Add-guest-PMU-support/20151030-143148
config: arm-axm55xx_defconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   In file included from arch/arm/kvm/arm.c:31:0:
>> include/kvm/arm_pmu.h:22:21: fatal error: asm/pmu.h: No such file or directory
    #include <asm/pmu.h>
                        ^
   compilation terminated.

vim +22 include/kvm/arm_pmu.h

219856f5 Shannon Zhao 2015-10-30  16   */
219856f5 Shannon Zhao 2015-10-30  17  
219856f5 Shannon Zhao 2015-10-30  18  #ifndef __ASM_ARM_KVM_PMU_H
219856f5 Shannon Zhao 2015-10-30  19  #define __ASM_ARM_KVM_PMU_H
219856f5 Shannon Zhao 2015-10-30  20  
219856f5 Shannon Zhao 2015-10-30  21  #include <linux/perf_event.h>
219856f5 Shannon Zhao 2015-10-30 @22  #include <asm/pmu.h>
219856f5 Shannon Zhao 2015-10-30  23  
219856f5 Shannon Zhao 2015-10-30  24  struct kvm_pmc {
219856f5 Shannon Zhao 2015-10-30  25  	u8 idx;/* index into the pmu->pmc array */

:::::: The code at line 22 was first introduced by commit
:::::: 219856f54d23298fff48e6e20e7e87fc45e42798 KVM: ARM64: Define PMU data structure for each vcpu

:::::: TO: Shannon Zhao <shannon.zhao@linaro.org>
:::::: CC: 0day robot <fengguang.wu@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 18309 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151030/132d758a/attachment-0001.obj>
