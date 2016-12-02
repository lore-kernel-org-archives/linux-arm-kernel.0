From: fengguang.wu@intel.com (kbuild test robot)
Date: Sat, 3 Dec 2016 06:05:27 +0800
Subject: [arm64:for-next/core 52/52] arch/arm64/include/asm/probes.h:18:25:
 fatal error: asm/opcodes.h: No such file or directory
Message-ID: <201612030617.rGmhD67h%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
head:   bca8f17f57bd76ddf2bbd2527eb890d6f588853e
commit: bca8f17f57bd76ddf2bbd2527eb890d6f588853e [52/52] arm64: Get rid of asm/opcodes.h
config: arm64-allmodconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout bca8f17f57bd76ddf2bbd2527eb890d6f588853e
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   In file included from arch/arm64/include/asm/uprobes.h:14:0,
                    from include/linux/uprobes.h:61,
                    from include/linux/mm_types.h:13,
                    from include/linux/sched.h:27,
                    from arch/arm64/kernel/asm-offsets.c:21:
>> arch/arm64/include/asm/probes.h:18:25: fatal error: asm/opcodes.h: No such file or directory
    #include <asm/opcodes.h>
                            ^
   compilation terminated.
   make[2]: *** [arch/arm64/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [sub-make] Error 2

vim +18 arch/arm64/include/asm/probes.h

2dd0e8d2d Sandeepa Prabhu 2016-07-08   2   * arch/arm64/include/asm/probes.h
2dd0e8d2d Sandeepa Prabhu 2016-07-08   3   *
2dd0e8d2d Sandeepa Prabhu 2016-07-08   4   * Copyright (C) 2013 Linaro Limited
2dd0e8d2d Sandeepa Prabhu 2016-07-08   5   *
2dd0e8d2d Sandeepa Prabhu 2016-07-08   6   * This program is free software; you can redistribute it and/or modify
2dd0e8d2d Sandeepa Prabhu 2016-07-08   7   * it under the terms of the GNU General Public License version 2 as
2dd0e8d2d Sandeepa Prabhu 2016-07-08   8   * published by the Free Software Foundation.
2dd0e8d2d Sandeepa Prabhu 2016-07-08   9   *
2dd0e8d2d Sandeepa Prabhu 2016-07-08  10   * This program is distributed in the hope that it will be useful,
2dd0e8d2d Sandeepa Prabhu 2016-07-08  11   * but WITHOUT ANY WARRANTY; without even the implied warranty of
2dd0e8d2d Sandeepa Prabhu 2016-07-08  12   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
2dd0e8d2d Sandeepa Prabhu 2016-07-08  13   * General Public License for more details.
2dd0e8d2d Sandeepa Prabhu 2016-07-08  14   */
2dd0e8d2d Sandeepa Prabhu 2016-07-08  15  #ifndef _ARM_PROBES_H
2dd0e8d2d Sandeepa Prabhu 2016-07-08  16  #define _ARM_PROBES_H
2dd0e8d2d Sandeepa Prabhu 2016-07-08  17  
39a67d49b Sandeepa Prabhu 2016-07-08 @18  #include <asm/opcodes.h>
39a67d49b Sandeepa Prabhu 2016-07-08  19  
c2249707e Pratyush Anand  2016-11-02  20  typedef u32 probe_opcode_t;
c2249707e Pratyush Anand  2016-11-02  21  typedef void (probes_handler_t) (u32 opcode, long addr, struct pt_regs *);
2dd0e8d2d Sandeepa Prabhu 2016-07-08  22  
2dd0e8d2d Sandeepa Prabhu 2016-07-08  23  /* architecture specific copy of original instruction */
c2249707e Pratyush Anand  2016-11-02  24  struct arch_probe_insn {
c2249707e Pratyush Anand  2016-11-02  25  	probe_opcode_t *insn;
39a67d49b Sandeepa Prabhu 2016-07-08  26  	pstate_check_t *pstate_cc;

:::::: The code at line 18 was first introduced by commit
:::::: 39a67d49ba353630d144a8eb775500c041c89e7a arm64: kprobes instruction simulation support

:::::: TO: Sandeepa Prabhu <sandeepa.s.prabhu@gmail.com>
:::::: CC: Catalin Marinas <catalin.marinas@arm.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 52505 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161203/a50fa932/attachment-0001.gz>
