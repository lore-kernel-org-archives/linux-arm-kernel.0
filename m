From: lkp@intel.com (kbuild test robot)
Date: Fri, 29 Dec 2017 14:42:39 +0800
Subject: [PATCH v6 2/8] module: use relative references for __ksymtab
 entries
In-Reply-To: <20171227085033.22389-3-ard.biesheuvel@linaro.org>
References: <20171227085033.22389-3-ard.biesheuvel@linaro.org>
Message-ID: <201712291444.pvaH0N3Y%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.15-rc5 next-20171222]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Ard-Biesheuvel/add-support-for-relative-references-in-special-sections/20171228-171634
config: s390-gcov_defconfig (attached as .config)
compiler: s390x-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=s390 

All errors (new ones prefixed by >>):

>> arch/s390/kernel/ebcdic.o:(.data+0x118): undefined reference to `__gcov_merge_add'
   arch/s390/kernel/ebcdic.o: In function `_GLOBAL__sub_I_00100_0__ascebc':
>> ebcdic.c:(.text.startup+0xe): undefined reference to `__gcov_init'
   arch/s390/kernel/ebcdic.o: In function `_GLOBAL__sub_D_00100_1__ascebc':
>> ebcdic.c:(.text.exit+0x8): undefined reference to `__gcov_exit'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 17457 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171229/24576561/attachment.gz>
