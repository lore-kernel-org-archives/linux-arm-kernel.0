From: lkp@intel.com (kbuild test robot)
Date: Fri, 6 Apr 2018 18:17:27 +0800
Subject: [stericsson:earlydebug 1/1] main.c:undefined reference to `printascii'
Message-ID: <201804061819.S7m5cVtd%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git earlydebug
head:   d4c6fbc5c32480ae0ad658cc92307ae10629c05a
commit: d4c6fbc5c32480ae0ad658cc92307ae10629c05a [1/1] uglyhack printascii
config: arm-at91_dt_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout d4c6fbc5c32480ae0ad658cc92307ae10629c05a
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   init/main.o: In function `start_kernel':
>> main.c:(.init.text+0x594): undefined reference to `printascii'
   kernel/printk/printk.o: In function `vprintk_emit':
>> printk.c:(.text+0x203c): undefined reference to `printascii'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 23719 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180406/be812ca9/attachment-0001.gz>
