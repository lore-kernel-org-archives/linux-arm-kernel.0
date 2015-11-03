From: fengguang.wu@intel.com (kbuild test robot)
Date: Tue, 3 Nov 2015 23:50:36 +0800
Subject: [stericsson:earlydebug 1/1] init/main.c:513: undefined reference to
 `printascii'
Message-ID: <201511032334.CI3No7y1%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git earlydebug
head:   92ab8295496c4d4c50cefce1c13863ce8eda7741
commit: 92ab8295496c4d4c50cefce1c13863ce8eda7741 [1/1] uglyhack printascii
config: blackfin-BF561-EZKIT-SMP_defconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 92ab8295496c4d4c50cefce1c13863ce8eda7741
        # save the attached .config to linux build tree
        make.cross ARCH=blackfin 

All errors (new ones prefixed by >>):

   init/built-in.o: In function `start_kernel':
>> init/main.c:513: undefined reference to `printascii'

vim +513 init/main.c

   507		set_task_stack_end_magic(&init_task);
   508		smp_setup_processor_id();
   509		debug_objects_early_init();
   510	
   511		{
   512		  extern void printascii(char *);
 > 513		  printascii("start_kernel\n");
   514		}
   515		/*
   516		 * Set up the the initial canary ASAP:

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 9928 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151103/34cf89dc/attachment.obj>
