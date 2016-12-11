From: lkp@intel.com (kbuild test robot)
Date: Sun, 11 Dec 2016 14:13:13 +0800
Subject: [PATCH v5 3/3] fpga manager: Add cyclone-ps-spi driver for
 Altera FPGAs
In-Reply-To: <1778a82d1989d13919b24e47fa09eeb56b2cb8e5.1481139171.git.stillcompiling@gmail.com>
Message-ID: <201612111429.nYbHqrq3%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joshua,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.9-rc8]
[cannot apply to next-20161209]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Joshua-Clayton/lib-add-bitrev8x4/20161208-070638
config: arm64-allmodconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   In file included from drivers/fpga/cyclone-ps-spi.c:13:0:
   drivers/fpga/cyclone-ps-spi.c: In function 'rev_buf':
>> include/linux/bitrev.h:12:21: error: implicit declaration of function '__arch_bitrev8x4' [-Werror=implicit-function-declaration]
    #define __bitrev8x4 __arch_bitrev8x4
                        ^
   include/linux/bitrev.h:101:2: note: in expansion of macro '__bitrev8x4'
     __bitrev8x4(__x);    \
     ^~~~~~~~~~~
   drivers/fpga/cyclone-ps-spi.c:84:11: note: in expansion of macro 'bitrev8x4'
      *fw32 = bitrev8x4(*fw32);
              ^~~~~~~~~
   In file included from include/linux/delay.h:10:0,
                    from drivers/fpga/cyclone-ps-spi.c:14:
   drivers/fpga/cyclone-ps-spi.c: In function 'cyclonespi_write':
   include/linux/kernel.h:739:16: warning: comparison of distinct pointer types lacks a cast
     (void) (&min1 == &min2);   \
                   ^
   include/linux/kernel.h:742:2: note: in expansion of macro '__min'
     __min(typeof(x), typeof(y),   \
     ^~~~~
   drivers/fpga/cyclone-ps-spi.c:98:19: note: in expansion of macro 'min'
      size_t stride = min(fw_data_end - fw_data, SZ_4K);
                      ^~~
   cc1: some warnings being treated as errors

vim +/__arch_bitrev8x4 +12 include/linux/bitrev.h

556d2f05 Yalin Wang     2014-11-03   6  #ifdef CONFIG_HAVE_ARCH_BITREVERSE
556d2f05 Yalin Wang     2014-11-03   7  #include <asm/bitrev.h>
556d2f05 Yalin Wang     2014-11-03   8  
556d2f05 Yalin Wang     2014-11-03   9  #define __bitrev32 __arch_bitrev32
556d2f05 Yalin Wang     2014-11-03  10  #define __bitrev16 __arch_bitrev16
556d2f05 Yalin Wang     2014-11-03  11  #define __bitrev8 __arch_bitrev8
533d0eab Joshua Clayton 2016-12-07 @12  #define __bitrev8x4 __arch_bitrev8x4
a5cfc1ec Akinobu Mita   2006-12-08  13  
556d2f05 Yalin Wang     2014-11-03  14  #else
556d2f05 Yalin Wang     2014-11-03  15  extern u8 const byte_rev_table[256];

:::::: The code at line 12 was first introduced by commit
:::::: 533d0eabff8f37edfdec7fdf6e705fdecb297daa lib: add bitrev8x4()

:::::: TO: Joshua Clayton <stillcompiling@gmail.com>
:::::: CC: 0day robot <fengguang.wu@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 52456 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161211/4a13661a/attachment-0001.gz>
