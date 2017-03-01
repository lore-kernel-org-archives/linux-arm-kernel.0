From: lkp@intel.com (kbuild test robot)
Date: Wed, 1 Mar 2017 15:19:22 +0800
Subject: [PATCH v3 20/25] ARM: owl: Implement CPU enable-method for S500
In-Reply-To: <20170228063535.32069-21-afaerber@suse.de>
Message-ID: <201703011539.2lGXT7m0%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andreas,

[auto build test ERROR on next-20170228]
[also build test ERROR on v4.10]
[cannot apply to robh/for-next linus/master linux/master v4.9-rc8 v4.9-rc7 v4.9-rc6]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Andreas-F-rber/ARM-Initial-Actions-Semi-S500-and-S900-enablement/20170301-110028
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   arch/arm/mach-actions/headsmp.S: Assembler messages:
>> arch/arm/mach-actions/headsmp.S:43: Error: selected processor does not support `dsb' in ARM mode
>> arch/arm/mach-actions/headsmp.S:44: Error: selected processor does not support `isb' in ARM mode

vim +43 arch/arm/mach-actions/headsmp.S

    37		mov	r6, r2, lsl r0
    38		orr	r5, r5, r6	@ Reg = (Temp<<WayShift)|(NumSets<<SetShift)
    39		mcr	p15, 0, r5, c7, c6, 2
    40		bgt	2b
    41		cmp	r2, #0
    42		bgt	1b
  > 43		dsb
  > 44		isb
    45		mov	pc, lr
    46	ENDPROC(owl_v7_invalidate_l1)
    47	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 61367 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170301/5ab32304/attachment-0001.gz>
