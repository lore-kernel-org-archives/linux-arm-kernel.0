From: lkp@intel.com (kbuild test robot)
Date: Wed, 23 Dec 2015 18:44:09 +0800
Subject: [RESEND PATCH] arm64: Store breakpoint single step state into
 pstate
In-Reply-To: <1450860731-194418-1-git-send-email-wangnan0@huawei.com>
Message-ID: <201512231805.1WQG4VQp%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wang,

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on v4.4-rc6 next-20151223]

url:    https://github.com/0day-ci/linux/commits/Wang-Nan/arm64-Store-breakpoint-single-step-state-into-pstate/20151223-165432
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux for-next/core
config: arm64-allnoconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   arch/arm64/kernel//irq.o: In function `signal_reinstall_single_step':
>> irq.c:(.text+0x0): multiple definition of `signal_reinstall_single_step'
   arch/arm64/kernel//debug-monitors.o:debug-monitors.c:(.text+0x2b4): first defined here
   arch/arm64/kernel//fpsimd.o: In function `signal_reinstall_single_step':
   fpsimd.c:(.text+0x0): multiple definition of `signal_reinstall_single_step'
   arch/arm64/kernel//debug-monitors.o:debug-monitors.c:(.text+0x2b4): first defined here
   arch/arm64/kernel//process.o: In function `signal_reinstall_single_step':
   process.c:(.text+0x0): multiple definition of `signal_reinstall_single_step'
   arch/arm64/kernel//debug-monitors.o:debug-monitors.c:(.text+0x2b4): first defined here
   arch/arm64/kernel//ptrace.o: In function `signal_reinstall_single_step':
   ptrace.c:(.text+0x368): multiple definition of `signal_reinstall_single_step'
   arch/arm64/kernel//debug-monitors.o:debug-monitors.c:(.text+0x2b4): first defined here
   arch/arm64/kernel//setup.o: In function `signal_reinstall_single_step':
   setup.c:(.text+0x0): multiple definition of `signal_reinstall_single_step'
   arch/arm64/kernel//debug-monitors.o:debug-monitors.c:(.text+0x2b4): first defined here
   aarch64-linux-gnu-ld: cannot find arch/arm64/kernel//signal.o: No such file or directory
   arch/arm64/kernel//sys.o: In function `signal_reinstall_single_step':
   sys.c:(.text+0x28): multiple definition of `signal_reinstall_single_step'
   arch/arm64/kernel//debug-monitors.o:debug-monitors.c:(.text+0x2b4): first defined here
   arch/arm64/kernel//stacktrace.o: In function `signal_reinstall_single_step':
   stacktrace.c:(.text+0x0): multiple definition of `signal_reinstall_single_step'
   arch/arm64/kernel//debug-monitors.o:debug-monitors.c:(.text+0x2b4): first defined here
   arch/arm64/kernel//time.o: In function `signal_reinstall_single_step':
   time.c:(.text+0x0): multiple definition of `signal_reinstall_single_step'
   arch/arm64/kernel//debug-monitors.o:debug-monitors.c:(.text+0x2b4): first defined here
   arch/arm64/kernel//traps.o: In function `signal_reinstall_single_step':
   traps.c:(.text+0x2c0): multiple definition of `signal_reinstall_single_step'
   arch/arm64/kernel//debug-monitors.o:debug-monitors.c:(.text+0x2b4): first defined here
   arch/arm64/kernel//io.o: In function `signal_reinstall_single_step':
   io.c:(.text+0x0): multiple definition of `signal_reinstall_single_step'
   arch/arm64/kernel//debug-monitors.o:debug-monitors.c:(.text+0x2b4): first defined here
   arch/arm64/kernel//vdso.o: In function `signal_reinstall_single_step':
   vdso.c:(.text+0x0): multiple definition of `signal_reinstall_single_step'
   arch/arm64/kernel//debug-monitors.o:debug-monitors.c:(.text+0x2b4): first defined here
   arch/arm64/kernel//psci.o: In function `signal_reinstall_single_step':
   psci.c:(.text+0x44): multiple definition of `signal_reinstall_single_step'
   arch/arm64/kernel//debug-monitors.o:debug-monitors.c:(.text+0x2b4): first defined here
   arch/arm64/kernel//cpu_ops.o: In function `signal_reinstall_single_step':
   cpu_ops.c:(.text+0x0): multiple definition of `signal_reinstall_single_step'
   arch/arm64/kernel//debug-monitors.o:debug-monitors.c:(.text+0x2b4): first defined here
   arch/arm64/kernel//insn.o: In function `signal_reinstall_single_step':
   insn.c:(.text+0x250): multiple definition of `signal_reinstall_single_step'
   arch/arm64/kernel//debug-monitors.o:debug-monitors.c:(.text+0x2b4): first defined here
   arch/arm64/kernel//return_address.o: In function `signal_reinstall_single_step':
   return_address.c:(.text+0x90): multiple definition of `signal_reinstall_single_step'
   arch/arm64/kernel//debug-monitors.o:debug-monitors.c:(.text+0x2b4): first defined here
   arch/arm64/kernel//cpuinfo.o: In function `signal_reinstall_single_step':
   cpuinfo.c:(.text+0x3dc): multiple definition of `signal_reinstall_single_step'
   arch/arm64/kernel//debug-monitors.o:debug-monitors.c:(.text+0x2b4): first defined here
   arch/arm64/kernel//cpu_errata.o: In function `signal_reinstall_single_step':
   cpu_errata.c:(.text+0x0): multiple definition of `signal_reinstall_single_step'
   arch/arm64/kernel//debug-monitors.o:debug-monitors.c:(.text+0x2b4): first defined here
   arch/arm64/kernel//cpufeature.o: In function `signal_reinstall_single_step':
   cpufeature.c:(.text+0x1c8): multiple definition of `signal_reinstall_single_step'
   arch/arm64/kernel//debug-monitors.o:debug-monitors.c:(.text+0x2b4): first defined here
   arch/arm64/kernel//alternative.o: In function `signal_reinstall_single_step':
   alternative.c:(.text+0x13c): multiple definition of `signal_reinstall_single_step'
   arch/arm64/kernel//debug-monitors.o:debug-monitors.c:(.text+0x2b4): first defined here
   arch/arm64/kernel//cacheinfo.o: In function `signal_reinstall_single_step':
   cacheinfo.c:(.text+0x230): multiple definition of `signal_reinstall_single_step'
   arch/arm64/kernel//debug-monitors.o:debug-monitors.c:(.text+0x2b4): first defined here
   arch/arm64/kernel//smp.o: In function `signal_reinstall_single_step':
   smp.c:(.text+0x0): multiple definition of `signal_reinstall_single_step'
   arch/arm64/kernel//debug-monitors.o:debug-monitors.c:(.text+0x2b4): first defined here
   arch/arm64/kernel//smp_spin_table.o: In function `signal_reinstall_single_step':
   smp_spin_table.c:(.text+0x108): multiple definition of `signal_reinstall_single_step'
   arch/arm64/kernel//debug-monitors.o:debug-monitors.c:(.text+0x2b4): first defined here
   arch/arm64/kernel//topology.o: In function `signal_reinstall_single_step':
   topology.c:(.text+0x0): multiple definition of `signal_reinstall_single_step'
   arch/arm64/kernel//debug-monitors.o:debug-monitors.c:(.text+0x2b4): first defined here
--
   arch/arm64/kernel/signal.c: In function 'sys_rt_sigreturn':
>> arch/arm64/kernel/signal.c:154:2: error: too many arguments to function 'signal_reinstall_single_step'
     signal_reinstall_single_step(regs->pstate);
     ^
   In file included from arch/arm64/include/asm/bug.h:21:0,
                    from include/linux/bug.h:4,
                    from include/linux/signal.h:5,
                    from arch/arm64/kernel/signal.c:22:
   arch/arm64/include/asm/debug-monitors.h:146:6: note: declared here
    void signal_reinstall_single_step(void)
         ^

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 5635 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151223/0ac60ff7/attachment-0001.obj>
