From: fengguang.wu@intel.com (kbuild test robot)
Date: Tue, 9 Aug 2016 04:41:52 +0800
Subject: [stericsson:earlydebug 1/1] init_task.c:undefined reference to
 `printascii'
Message-ID: <201608090449.QX1Sd29G%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git earlydebug
head:   be0c05be25fea7ef592e5c4c613bc1489b012d65
commit: be0c05be25fea7ef592e5c4c613bc1489b012d65 [1/1] uglyhack printascii
config: arm-imx_v6_v7_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 5.4.0-6) 5.4.0 20160609
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout be0c05be25fea7ef592e5c4c613bc1489b012d65
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   init/built-in.o: In function `start_kernel':
>> init_task.c:(.init.text+0x644): undefined reference to `printascii'
   kernel/built-in.o: In function `vprintk_emit':
>> memremap.c:(.text+0x58a48): undefined reference to `printascii'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 30174 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160809/27f0995e/attachment-0001.obj>
