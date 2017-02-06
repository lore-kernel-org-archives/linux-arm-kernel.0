From: fengguang.wu@intel.com (kbuild test robot)
Date: Tue, 7 Feb 2017 03:23:29 +0800
Subject: [hisi:topic-lpc-4.10-libio 134/148]
 arch/blackfin/kernel/module.c:7:40: error: 'mod' undeclared
Message-ID: <201702070325.7CZrNAwn%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/hisilicon/linux-hisi topic-lpc-4.10-libio
head:   06443d85dc35b64a704f7be84cc538281a1598f4
commit: 0ccaa690913e8dc13f3bbdfff3c059dc3c2ae936 [134/148] LPC: Add the ACPI LPC support
config: blackfin-TCM-BF537_defconfig (attached as .config)
compiler: bfin-uclinux-gcc (GCC) 6.2.0
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 0ccaa690913e8dc13f3bbdfff3c059dc3c2ae936
        # save the attached .config to linux build tree
        make.cross ARCH=blackfin 

All error/warnings (new ones prefixed by >>):

   include/linux/ratelimit.h: In function 'ratelimit_state_exit':
>> arch/blackfin/kernel/module.c:7:40: error: 'mod' undeclared (first use in this function)
    #define pr_fmt(fmt) "module %s: " fmt, mod->name
                                           ^
   include/linux/printk.h:294:22: note: in expansion of macro 'pr_fmt'
     printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
                         ^~~~~~
   include/linux/printk.h:295:17: note: in expansion of macro 'pr_warning'
    #define pr_warn pr_warning
                    ^~~~~~~~~~
>> include/linux/ratelimit.h:61:3: note: in expansion of macro 'pr_warn'
      pr_warn("%s: %d output lines suppressed due to ratelimiting\n",
      ^~~~~~~
   arch/blackfin/kernel/module.c:7:40: note: each undeclared identifier is reported only once for each function it appears in
    #define pr_fmt(fmt) "module %s: " fmt, mod->name
                                           ^
   include/linux/printk.h:294:22: note: in expansion of macro 'pr_fmt'
     printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
                         ^~~~~~
   include/linux/printk.h:295:17: note: in expansion of macro 'pr_warning'
    #define pr_warn pr_warning
                    ^~~~~~~~~~
>> include/linux/ratelimit.h:61:3: note: in expansion of macro 'pr_warn'
      pr_warn("%s: %d output lines suppressed due to ratelimiting\n",
      ^~~~~~~

vim +/mod +7 arch/blackfin/kernel/module.c

1394f032 Bryan Wu    2007-05-06   1  /*
96f1050d Robin Getz  2009-09-24   2   * Copyright 2004-2009 Analog Devices Inc.
1394f032 Bryan Wu    2007-05-06   3   *
96f1050d Robin Getz  2009-09-24   4   * Licensed under the GPL-2 or later
1394f032 Bryan Wu    2007-05-06   5   */
1394f032 Bryan Wu    2007-05-06   6  
b75a9e6b Joe Perches 2010-10-20  @7  #define pr_fmt(fmt) "module %s: " fmt, mod->name
1394f032 Bryan Wu    2007-05-06   8  
1394f032 Bryan Wu    2007-05-06   9  #include <linux/moduleloader.h>
1394f032 Bryan Wu    2007-05-06  10  #include <linux/elf.h>
1394f032 Bryan Wu    2007-05-06  11  #include <linux/vmalloc.h>
1394f032 Bryan Wu    2007-05-06  12  #include <linux/fs.h>
1394f032 Bryan Wu    2007-05-06  13  #include <linux/string.h>
1394f032 Bryan Wu    2007-05-06  14  #include <linux/kernel.h>
1394f032 Bryan Wu    2007-05-06  15  #include <asm/dma.h>

:::::: The code at line 7 was first introduced by commit
:::::: b75a9e6bfba5c7343391ac1bacd44d6652dde8da Blackfin: use more standard pr_fmt in the module loader

:::::: TO: Joe Perches <joe@perches.com>
:::::: CC: Mike Frysinger <vapier@gentoo.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 10658 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170207/2a29c6eb/attachment-0001.gz>
