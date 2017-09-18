From: fengguang.wu@intel.com (kbuild test robot)
Date: Tue, 19 Sep 2017 06:15:44 +0800
Subject: [nomadik:i2c-gpio-descriptors 12/19]
 arch/arm/mach-sa1100/simpad.c:330:27: note: in expansion of macro
 'GPIO_GPIO21'
Message-ID: <201709190642.WAcWiXTe%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git i2c-gpio-descriptors
head:   1aac5fb7b595170dc7943b8da83fe73d1f5c6052
commit: 903a5946b2c6329e9eee224fe2934d071ce7c3d3 [12/19] i2c: gpio: Convert to use descriptors
config: arm-sa1100 (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 903a5946b2c6329e9eee224fe2934d071ce7c3d3
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All warnings (new ones prefixed by >>):

   In file included from arch/arm/mach-sa1100/simpad.c:19:0:
>> arch/arm/mach-sa1100/include/mach/SA-1100.h:1117:18: warning: large integer implicitly truncated to unsigned type [-Woverflow]
                     (0x00000001 << (Nb))
                     ^
   include/linux/gpio/machine.h:55:16: note: in definition of macro 'GPIO_LOOKUP_IDX'
     .chip_hwnum = _chip_hwnum,                                        \
                   ^~~~~~~~~~~
>> arch/arm/mach-sa1100/include/mach/SA-1100.h:1139:21: note: in expansion of macro 'GPIO_GPIO'
    #define GPIO_GPIO21 GPIO_GPIO (21) /* GPIO [21]                       */
                        ^~~~~~~~~
>> arch/arm/mach-sa1100/simpad.c:330:27: note: in expansion of macro 'GPIO_GPIO21'
      GPIO_LOOKUP_IDX("gpio", GPIO_GPIO21, NULL, 0, GPIO_ACTIVE_HIGH),
                              ^~~~~~~~~~~
>> arch/arm/mach-sa1100/include/mach/SA-1100.h:1117:18: warning: large integer implicitly truncated to unsigned type [-Woverflow]
                     (0x00000001 << (Nb))
                     ^
   include/linux/gpio/machine.h:55:16: note: in definition of macro 'GPIO_LOOKUP_IDX'
     .chip_hwnum = _chip_hwnum,                                        \
                   ^~~~~~~~~~~
   arch/arm/mach-sa1100/include/mach/SA-1100.h:1143:21: note: in expansion of macro 'GPIO_GPIO'
    #define GPIO_GPIO25 GPIO_GPIO (25) /* GPIO [25]                       */
                        ^~~~~~~~~
>> arch/arm/mach-sa1100/simpad.c:331:27: note: in expansion of macro 'GPIO_GPIO25'
      GPIO_LOOKUP_IDX("gpio", GPIO_GPIO25, NULL, 1, GPIO_ACTIVE_HIGH),
                              ^~~~~~~~~~~

vim +/GPIO_GPIO21 +330 arch/arm/mach-sa1100/simpad.c

   323	
   324	/*
   325	 * i2c
   326	 */
   327	static struct gpiod_lookup_table simpad_i2c_gpiod_table = {
   328		.dev_id = "i2c-gpio",
   329		.table = {
 > 330			GPIO_LOOKUP_IDX("gpio", GPIO_GPIO21, NULL, 0, GPIO_ACTIVE_HIGH),
 > 331			GPIO_LOOKUP_IDX("gpio", GPIO_GPIO25, NULL, 1, GPIO_ACTIVE_HIGH),
   332		},
   333	};
   334	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 24023 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170919/77e4e33d/attachment-0001.gz>
