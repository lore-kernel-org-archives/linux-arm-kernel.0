From: fengguang.wu@intel.com (kbuild test robot)
Date: Wed, 29 Nov 2017 04:08:46 +0800
Subject: [stericsson:earlydebug 1/1] main.c:undefined reference to `printascii'
Message-ID: <201711290440.2cL5TqiJ%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git earlydebug
head:   15a1a5ef4038297935f97586a2e994123dc56980
commit: 15a1a5ef4038297935f97586a2e994123dc56980 [1/1] uglyhack printascii
config: arm-mvebu_v5_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 15a1a5ef4038297935f97586a2e994123dc56980
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   init/main.o: In function `start_kernel':
>> main.c:(.init.text+0x580): undefined reference to `printascii'
   kernel/printk/printk.o: In function `vprintk_emit':
>> printk.c:(.text+0x277c): undefined reference to `printascii'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 23627 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171129/8e28f283/attachment-0001.gz>
