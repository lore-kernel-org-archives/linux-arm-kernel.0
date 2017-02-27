From: fengguang.wu@intel.com (kbuild test robot)
Date: Mon, 27 Feb 2017 23:20:47 +0800
Subject: [arm-platforms:kvm-arm/testing 24/25]
 arch/sh/include/asm/perf_event.h:19:28: error: 'PERF_COUNT_HW_CACHE_MAX'
 undeclared here (not in a function)
Message-ID: <201702272344.xUkV1C5y%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm/testing
head:   3d9d99cbf83bf1c290e8e9f251fecebfb4c00008
commit: 89d3a013a23103a1d62d9871cdc680eb5129c101 [24/25] perf: PMUv3: Allow the use of the PMUv3 driver on 32bit ARM
config: sh-titan_defconfig (attached as .config)
compiler: sh4-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 89d3a013a23103a1d62d9871cdc680eb5129c101
        # save the attached .config to linux build tree
        make.cross ARCH=sh 

All errors (new ones prefixed by >>):

   In file included from drivers/perf/arm_pmuv3.c:23:0:
>> arch/sh/include/asm/perf_event.h:19:28: error: 'PERF_COUNT_HW_CACHE_MAX' undeclared here (not in a function)
     const int (*cache_events)[PERF_COUNT_HW_CACHE_MAX]
                               ^~~~~~~~~~~~~~~~~~~~~~~
>> arch/sh/include/asm/perf_event.h:20:13: error: 'PERF_COUNT_HW_CACHE_OP_MAX' undeclared here (not in a function)
               [PERF_COUNT_HW_CACHE_OP_MAX]
                ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> arch/sh/include/asm/perf_event.h:21:13: error: 'PERF_COUNT_HW_CACHE_RESULT_MAX' undeclared here (not in a function)
               [PERF_COUNT_HW_CACHE_RESULT_MAX];
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/perf/arm_pmuv3.c:24:22: fatal error: asm/virt.h: No such file or directory
    #include <asm/virt.h>
                         ^
   compilation terminated.

vim +/PERF_COUNT_HW_CACHE_MAX +19 arch/sh/include/asm/perf_event.h

ac44e669 Paul Mundt 2009-10-28  13  	void		(*enable)(struct hw_perf_event *, int);
ac44e669 Paul Mundt 2009-10-28  14  	void		(*disable)(struct hw_perf_event *, int);
ac44e669 Paul Mundt 2009-10-28  15  	u64		(*read)(int);
ac44e669 Paul Mundt 2009-10-28  16  	int		(*event_map)(int);
ac44e669 Paul Mundt 2009-10-28  17  	unsigned int	max_events;
ac44e669 Paul Mundt 2009-10-28  18  	unsigned long	raw_event_mask;
ac44e669 Paul Mundt 2009-10-28 @19  	const int	(*cache_events)[PERF_COUNT_HW_CACHE_MAX]
ac44e669 Paul Mundt 2009-10-28 @20  				       [PERF_COUNT_HW_CACHE_OP_MAX]
ac44e669 Paul Mundt 2009-10-28 @21  				       [PERF_COUNT_HW_CACHE_RESULT_MAX];
ac44e669 Paul Mundt 2009-10-28  22  };
ac44e669 Paul Mundt 2009-10-28  23  
ac44e669 Paul Mundt 2009-10-28  24  /* arch/sh/kernel/perf_event.c */

:::::: The code at line 19 was first introduced by commit
:::::: ac44e6694755744fe96442919da1f2c7e87a2a61 sh: perf events: Add preliminary support for SH-4A counters.

:::::: TO: Paul Mundt <lethal@linux-sh.org>
:::::: CC: Paul Mundt <lethal@linux-sh.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 16138 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170227/96ce6219/attachment.gz>
