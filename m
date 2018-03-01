From: fengguang.wu@intel.com (kbuild test robot)
Date: Fri, 2 Mar 2018 03:57:49 +0800
Subject: [arm-platforms:kvm-arm64/haslr 30/31] arch/arm64/mm/fault.c:719:2:
 error: implicit declaration of function 'arm64_apply_bp_hardening'; did you
 mean 'do_el0_irq_bp_hardening'?
Message-ID: <201803020345.qBthC71N%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm64/haslr
head:   59f018b25acbeec7d46fdf5fbced13e12665a16b
commit: 286d63fc464fa92e4bc6e48e0a52b007d7c4c2a5 [30/31] arm64: KVM: Allow mapping of vectors outside of the RAM region
config: arm64-allnoconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 286d63fc464fa92e4bc6e48e0a52b007d7c4c2a5
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   arch/arm64/mm/fault.c: In function 'do_el0_irq_bp_hardening':
>> arch/arm64/mm/fault.c:719:2: error: implicit declaration of function 'arm64_apply_bp_hardening'; did you mean 'do_el0_irq_bp_hardening'? [-Werror=implicit-function-declaration]
     arm64_apply_bp_hardening();
     ^~~~~~~~~~~~~~~~~~~~~~~~
     do_el0_irq_bp_hardening
   cc1: some warnings being treated as errors
--
   arch/arm64/mm/context.c: In function 'check_and_switch_context':
>> arch/arm64/mm/context.c:238:2: error: implicit declaration of function 'arm64_apply_bp_hardening' [-Werror=implicit-function-declaration]
     arm64_apply_bp_hardening();
     ^~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +719 arch/arm64/mm/fault.c

1d18c47c Catalin Marinas 2012-03-05  715  
30d88c0e Will Deacon     2018-02-02  716  asmlinkage void __exception do_el0_irq_bp_hardening(void)
30d88c0e Will Deacon     2018-02-02  717  {
30d88c0e Will Deacon     2018-02-02  718  	/* PC has already been checked in entry.S */
30d88c0e Will Deacon     2018-02-02 @719  	arm64_apply_bp_hardening();
30d88c0e Will Deacon     2018-02-02  720  }
30d88c0e Will Deacon     2018-02-02  721  

:::::: The code at line 719 was first introduced by commit
:::::: 30d88c0e3ace625a92eead9ca0ad94093a8f59fe arm64: entry: Apply BP hardening for suspicious interrupts from EL0

:::::: TO: Will Deacon <will.deacon@arm.com>
:::::: CC: Catalin Marinas <catalin.marinas@arm.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 7006 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180302/0d210f56/attachment.gz>
