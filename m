From: fengguang.wu@intel.com (kbuild test robot)
Date: Fri, 20 May 2016 20:40:46 +0800
Subject: [stericsson:earlydebug 1/1] init/main.c:490: undefined reference to
 `printascii'
Message-ID: <201605202044.auhsCGs8%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git earlydebug
head:   7a0e86123c84ec8853d7c6ae248e911a04a81bb4
commit: 7a0e86123c84ec8853d7c6ae248e911a04a81bb4 [1/1] uglyhack printascii
config: alpha-defconfig (attached as .config)
compiler: alpha-linux-gnu-gcc (Debian 5.3.1-8) 5.3.1 20160205
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 7a0e86123c84ec8853d7c6ae248e911a04a81bb4
        # save the attached .config to linux build tree
        make.cross ARCH=alpha 

Note: the stericsson/earlydebug HEAD 7a0e86123c84ec8853d7c6ae248e911a04a81bb4 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   init/built-in.o: In function `start_kernel':
>> init/main.c:490: undefined reference to `printascii'
>> init/main.c:490: undefined reference to `printascii'

vim +490 init/main.c

   484		set_task_stack_end_magic(&init_task);
   485		smp_setup_processor_id();
   486		debug_objects_early_init();
   487	
   488		{
   489		  extern void printascii(char *);
 > 490		  printascii("start_kernel\n");
   491		}
   492		/*
   493		 * Set up the the initial canary ASAP:

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 11941 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160520/e4f54856/attachment.obj>
