From: fengguang.wu@intel.com (kbuild test robot)
Date: Wed, 30 Mar 2016 17:58:43 +0800
Subject: [stericsson:earlydebug 1/1] init/main.c:579: undefined reference to
 `printascii'
Message-ID: <201603301739.uOptHW44%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git earlydebug
head:   7a0e86123c84ec8853d7c6ae248e911a04a81bb4
commit: 7a0e86123c84ec8853d7c6ae248e911a04a81bb4 [1/1] uglyhack printascii
config: sh-sh7785lcr_32bit_defconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 7a0e86123c84ec8853d7c6ae248e911a04a81bb4
        # save the attached .config to linux build tree
        make.cross ARCH=sh 

All errors (new ones prefixed by >>):

   init/built-in.o: In function `start_kernel':
>> init/main.c:579: undefined reference to `printascii'

vim +579 init/main.c

ad596171 John Stultz            2006-06-26  573  	timekeeping_init();
88fecaa2 John Stultz            2006-07-03  574  	time_init();
38ff87f7 Stephen Boyd           2013-06-01  575  	sched_clock_postinit();
9e630205 Stephane Eranian       2013-04-03  576  	perf_event_init();
93e02814 Heiko Carstens         2006-07-03  577  	profile_init();
d8ad7d11 Takao Indoh            2011-03-29  578  	call_function_init();
f91eb62f Steven Rostedt         2013-04-29 @579  	WARN(!irqs_disabled(), "Interrupts were enabled early\n");
2ce802f6 Tejun Heo              2011-01-20  580  	early_boot_irqs_disabled = false;
93e02814 Heiko Carstens         2006-07-03  581  	local_irq_enable();
dcce284a Benjamin Herrenschmidt 2009-06-18  582  

:::::: The code at line 579 was first introduced by commit
:::::: f91eb62f71b31e69e405663ff8d047bc3b9f7525 init: scream bloody murder if interrupts are enabled too early

:::::: TO: Steven Rostedt <rostedt@goodmis.org>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 16303 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160330/9af55e36/attachment.obj>
