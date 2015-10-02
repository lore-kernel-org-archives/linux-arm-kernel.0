From: lkp@intel.com (kbuild test robot)
Date: Fri, 2 Oct 2015 13:13:24 +0800
Subject: [RFC] arm: Add generic smc wrapper
In-Reply-To: <1443701047-10101-1-git-send-email-larper@axis.com>
Message-ID: <201510021338.iKkCgj7c%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lars,

[auto build test results on v4.3-rc3 -- if it's inappropriate base, please ignore]

config: arm-rpc_defconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All error/warnings (new ones prefixed by >>):

   arch/arm/kernel/smc-call.S: Assembler messages:
>> arch/arm/kernel/smc-call.S:21: Error: selected processor does not support ARM mode `bx lr'

vim +21 arch/arm/kernel/smc-call.S

    15	
    16	#include <asm/opcodes-sec.h>
    17	
    18	/* int invoke_smc(u32 function_id, u32 arg0, u32 arg1, u32 arg2) */
    19	ENTRY(invoke_smc)
    20		__SMC(0)
  > 21		bx	lr
    22	ENDPROC(invoke_smc)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 12414 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151002/a8a9624f/attachment-0001.obj>
