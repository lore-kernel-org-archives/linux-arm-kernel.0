From: fengguang.wu@intel.com (kbuild test robot)
Date: Tue, 13 Jun 2017 11:24:52 +0800
Subject: [nomadik:gemini-dir-685-clktest 28/29] init_task.c:undefined
 reference to `printascii'
Message-ID: <201706131148.pc13fzyQ%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git gemini-dir-685-clktest
head:   bf2d6e77266d68cf2c5bbee1bd4419f4c90ebaaf
commit: d750f1a49f2c0a88e4eac22a536532239af4735b [28/29] uglyhack printascii
config: arm-at91_dt_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout d750f1a49f2c0a88e4eac22a536532239af4735b
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   init/built-in.o: In function `start_kernel':
>> init_task.c:(.init.text+0x57c): undefined reference to `printascii'
   kernel/built-in.o: In function `vprintk_emit':
>> memremap.c:(.text+0x28628): undefined reference to `printascii'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 22772 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170613/42fd28ee/attachment-0001.gz>
