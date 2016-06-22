From: fengguang.wu@intel.com (kbuild test robot)
Date: Thu, 23 Jun 2016 02:41:08 +0800
Subject: [arm64:for-next/core 5/12] ubsan.c:undefined reference to `__ashlti3'
Message-ID: <201606230207.Hzx423fS%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux for-next/core
head:   d770b5a04790a4ec1c0864621eef95f5afe773cf
commit: 6b14c517a2a866c8407e9864c1cd3fcc6fed55ab [5/12] arm64: Add support ARCH_SUPPORTS_INT128
config: arm64-allyesconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 5.3.1-8) 5.3.1 20160205
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 6b14c517a2a866c8407e9864c1cd3fcc6fed55ab
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

Note: the arm64/for-next/core HEAD d770b5a04790a4ec1c0864621eef95f5afe773cf builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   lib/built-in.o: In function `get_signed_val':
>> ubsan.c:(.text.unlikely+0x1568): undefined reference to `__ashlti3'
>> ubsan.c:(.text.unlikely+0x1570): undefined reference to `__ashrti3'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 50245 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160623/5a72762e/attachment-0001.obj>
