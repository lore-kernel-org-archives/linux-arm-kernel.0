From: lkp@intel.com (kbuild test robot)
Date: Sat, 29 Oct 2016 02:50:50 +0800
Subject: [PATCH v2 1/5] lib: add bitrev8x4()
In-Reply-To: <bc92eb1507448731163ae67fc888668d327f9168.1477669745.git.stillcompiling@gmail.com>
Message-ID: <201610290238.7mbLvCQP%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joshua,

[auto build test WARNING on linus/master]
[also build test WARNING on v4.9-rc2 next-20161028]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
[Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
[Check https://git-scm.com/docs/git-format-patch for more information]

url:    https://github.com/0day-ci/linux/commits/Joshua-Clayton/lib-add-bitrev8x4/20161029-012535
config: arm-s5pv210_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All warnings (new ones prefixed by >>):

   In file included from include/linux/bitrev.h:7:0,
                    from include/linux/crc32.h:9,
                    from lib/crc32.c:29:
   arch/arm/include/asm/bitrev.h: In function '__arch_bitrev8x4':
>> arch/arm/include/asm/bitrev.h:23:1: warning: no return statement in function returning non-void [-Wreturn-type]
    }
    ^

vim +23 arch/arm/include/asm/bitrev.h

     7		return x;
     8	}
     9	
    10	static __always_inline __attribute_const__ u16 __arch_bitrev16(u16 x)
    11	{
    12		return __arch_bitrev32((u32)x) >> 16;
    13	}
    14	
    15	static __always_inline __attribute_const__ u8 __arch_bitrev8(u8 x)
    16	{
    17		return __arch_bitrev32((u32)x) >> 24;
    18	}
    19	
    20	static __always_inline __attribute_const__ u32 __arch_bitrev8x4(u32 x)
    21	{
    22		__asm__ ("rbit %0, %1; rev %0, %0" : "=r" (x) : "r" (x));
  > 23	}
    24	
    25	#endif

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 10244 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161029/c7c967b4/attachment-0001.gz>
