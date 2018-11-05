From: lkp@intel.com (kbuild test robot)
Date: Mon, 5 Nov 2018 20:20:35 +0800
Subject: [stericsson:earlydebug 1/1] main.c:undefined reference to `printascii'
Message-ID: <201811052034.ml1jUYJj%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git earlydebug
head:   d651322316cbd4dc0dfacc2d63651dc4893eaa3e
commit: d651322316cbd4dc0dfacc2d63651dc4893eaa3e [1/1] uglyhack printascii
config: arm-eseries_pxa_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout d651322316cbd4dc0dfacc2d63651dc4893eaa3e
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   init/main.o: In function `start_kernel':
>> main.c:(.init.text+0x534): undefined reference to `printascii'
   kernel/printk/printk.o: In function `vprintk_store':
>> printk.c:(.text+0x2978): undefined reference to `printascii'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 14252 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181105/fef89e55/attachment-0001.gz>
