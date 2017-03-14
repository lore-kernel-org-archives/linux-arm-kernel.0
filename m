From: lkp@intel.com (kbuild test robot)
Date: Tue, 14 Mar 2017 13:10:22 +0800
Subject: [PATCH V7 6/7] LIBIO: Support the dynamically logical PIO
 registration of ACPI host I/O
In-Reply-To: <1489372963-9000-7-git-send-email-yuanzhichang@hisilicon.com>
Message-ID: <201703141330.2iWD3b4I%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi zhichang.yuan,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.11-rc2 next-20170310]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/zhichang-yuan/LPC-legacy-ISA-I-O-support/20170314-114635
config: blackfin-allmodconfig (attached as .config)
compiler: bfin-uclinux-gcc (GCC) 6.2.0
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=blackfin 

All error/warnings (new ones prefixed by >>):

   include/linux/ratelimit.h: In function 'ratelimit_state_exit':
>> arch/blackfin/kernel/module.c:7:40: error: 'mod' undeclared (first use in this function)
    #define pr_fmt(fmt) "module %s: " fmt, mod->name
                                           ^
   include/linux/printk.h:303:22: note: in expansion of macro 'pr_fmt'
     printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
                         ^~~~~~
   include/linux/printk.h:304:17: note: in expansion of macro 'pr_warning'
    #define pr_warn pr_warning
                    ^~~~~~~~~~
>> include/linux/ratelimit.h:61:3: note: in expansion of macro 'pr_warn'
      pr_warn("%s: %d output lines suppressed due to ratelimiting\n",
      ^~~~~~~
   arch/blackfin/kernel/module.c:7:40: note: each undeclared identifier is reported only once for each function it appears in
    #define pr_fmt(fmt) "module %s: " fmt, mod->name
                                           ^
   include/linux/printk.h:303:22: note: in expansion of macro 'pr_fmt'
     printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
                         ^~~~~~
   include/linux/printk.h:304:17: note: in expansion of macro 'pr_warning'
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
Size: 43892 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170314/96f1018c/attachment-0001.gz>
