From: fengguang.wu@intel.com (kbuild test robot)
Date: Tue, 9 Aug 2016 04:37:26 +0800
Subject: [stericsson:earlydebug 1/1] init/main.c:491: undefined reference to
 `printascii'
Message-ID: <201608090423.CO80OEEQ%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git earlydebug
head:   be0c05be25fea7ef592e5c4c613bc1489b012d65
commit: be0c05be25fea7ef592e5c4c613bc1489b012d65 [1/1] uglyhack printascii
config: arm-omap2plus_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 5.4.0-6) 5.4.0 20160609
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout be0c05be25fea7ef592e5c4c613bc1489b012d65
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   init/built-in.o: In function `start_kernel':
>> init/main.c:491: undefined reference to `printascii'
>> init/built-in.o:(.debug_addr+0x154): undefined reference to `printascii'
   kernel/built-in.o: In function `vprintk_emit':
>> kernel/printk/printk.c:1823: undefined reference to `printascii'
>> kernel/built-in.o:(.debug_addr+0x29bc4): undefined reference to `printascii'

vim +491 init/main.c

   485		smp_setup_processor_id();
   486		debug_objects_early_init();
   487	
   488	#ifdef CONFIG_ARM
   489		{
   490		  extern void printascii(char *);
 > 491		  printascii("start_kernel\n");
   492		}
   493	#endif
   494		/*

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 28189 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160809/4ccba68b/attachment-0001.obj>
