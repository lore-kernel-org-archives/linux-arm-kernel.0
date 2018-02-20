From: fengguang.wu@intel.com (kbuild test robot)
Date: Wed, 21 Feb 2018 00:15:47 +0800
Subject: [stericsson:earlydebug 1/1] main.c:undefined reference to `printascii'
Message-ID: <201802210046.59uEBAs8%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git earlydebug
head:   c5c41ef842979735d1f655a307b6c72ab8ebb42b
commit: c5c41ef842979735d1f655a307b6c72ab8ebb42b [1/1] uglyhack printascii
config: arm-at91_dt_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout c5c41ef842979735d1f655a307b6c72ab8ebb42b
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   init/main.o: In function `start_kernel':
>> main.c:(.init.text+0x594): undefined reference to `printascii'
   kernel/printk/printk.o: In function `vprintk_emit':
>> printk.c:(.text+0x2038): undefined reference to `printascii'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 23600 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180221/a231e66d/attachment-0001.gz>
