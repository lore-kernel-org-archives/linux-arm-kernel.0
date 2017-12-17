From: fengguang.wu@intel.com (kbuild test robot)
Date: Sun, 17 Dec 2017 10:38:54 +0800
Subject: [arm-platforms:kvm-arm64/haslr 8/23]
 arch/arm64/include/asm/asm-offsets.h:2:10: fatal error:
 generated/asm-offsets.h: No such file or directory
Message-ID: <201712171051.OQ8gMmTK%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm64/haslr
head:   8d0cd2e88233536ddbbc037bf50477a1dcbc035f
commit: 3061497dd692751c9e1fc3b9ffcede947ac55288 [8/23] arm64: alternatives: Enforce alignment of struct alt_instr
config: arm64-allyesconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 3061497dd692751c9e1fc3b9ffcede947ac55288
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   In file included from arch/arm64/include/asm/alternative.h:5:0,
                    from arch/arm64/include/asm/lse.h:8,
                    from arch/arm64/include/asm/atomic.h:27,
                    from include/linux/atomic.h:5,
                    from include/linux/debug_locks.h:6,
                    from include/linux/lockdep.h:28,
                    from include/linux/spinlock_types.h:18,
                    from kernel/bounds.c:14:
>> arch/arm64/include/asm/asm-offsets.h:2:10: fatal error: generated/asm-offsets.h: No such file or directory
    #include <generated/asm-offsets.h>
             ^~~~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.
   make[2]: *** [kernel/bounds.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [sub-make] Error 2

vim +2 arch/arm64/include/asm/asm-offsets.h

0be7320a Catalin Marinas 2012-03-05 @2  #include <generated/asm-offsets.h>

:::::: The code at line 2 was first introduced by commit
:::::: 0be7320a635c2e434e8b67e0e9474a85ceb421c4 arm64: Assembly macros and definitions

:::::: TO: Catalin Marinas <catalin.marinas@arm.com>
:::::: CC: Catalin Marinas <catalin.marinas@arm.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 58551 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171217/b25b0c55/attachment-0001.gz>
