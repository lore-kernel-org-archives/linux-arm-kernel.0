From: fengguang.wu@intel.com (kbuild test robot)
Date: Tue, 13 Jun 2017 11:30:54 +0800
Subject: [nomadik:gemini-dir-685-clktest 28/29] init/main.c:500: undefined
 reference to `printascii'
Message-ID: <201706131152.3aDNjz9o%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git gemini-dir-685-clktest
head:   bf2d6e77266d68cf2c5bbee1bd4419f4c90ebaaf
commit: d750f1a49f2c0a88e4eac22a536532239af4735b [28/29] uglyhack printascii
config: arm-efm32_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout d750f1a49f2c0a88e4eac22a536532239af4735b
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   init/built-in.o: In function `start_kernel':
>> init/main.c:500: undefined reference to `printascii'
   kernel/built-in.o: In function `vprintk_emit':
>> kernel/printk/printk.c:1733: undefined reference to `printascii'

vim +500 init/main.c

   494		smp_setup_processor_id();
   495		debug_objects_early_init();
   496	
   497	#ifdef CONFIG_ARM
   498		{
   499		  extern void printascii(char *);
 > 500		  printascii("start_kernel\n");
   501		}
   502	#endif
   503		/*

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 11336 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170613/6b5d7ea8/attachment-0001.gz>
