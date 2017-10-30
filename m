From: lkp@intel.com (kbuild test robot)
Date: Mon, 30 Oct 2017 18:02:06 +0800
Subject: [PATCH v2 1/2] media: i2c: Add the ov7740 image sensor driver
In-Reply-To: <20171027074220.23839-2-wenyou.yang@microchip.com>
References: <20171027074220.23839-2-wenyou.yang@microchip.com>
Message-ID: <201710301745.IcembUO9%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wenyou,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linuxtv-media/master]
[also build test WARNING on v4.14-rc7 next-20171018]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Wenyou-Yang/media-i2c-Add-the-ov7740-image-sensor-driver/20171030-140347
base:   git://linuxtv.org/media_tree.git master
config: sh-allmodconfig (attached as .config)
compiler: sh4-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=sh 

All warnings (new ones prefixed by >>):

>> drivers/media/i2c/ov7740.c:57:0: warning: "REG_REG15" redefined
    #define REG_REG15 0x15
    
   In file included from arch/sh/include/asm/ptrace_32.h:4:0,
                    from arch/sh/include/uapi/asm/ptrace.h:30,
                    from arch/sh/include/asm/ptrace.h:13,
                    from include/linux/irq.h:28,
                    from include/linux/gpio/driver.h:6,
                    from include/asm-generic/gpio.h:12,
                    from arch/sh/include/asm/gpio.h:23,
                    from include/linux/gpio.h:48,
                    from drivers/media/i2c/ov7740.c:16:
   arch/sh/include/uapi/asm/ptrace_32.h:20:0: note: this is the location of the previous definition
    #define REG_REG15 15
    
   In file included from drivers/media/i2c/ov7740.c:21:0:
   drivers/media/i2c/ov7740.c: In function 'ov7740_set_ctrl':
   include/linux/regmap.h:73:2: warning: 'val' may be used uninitialized in this function [-Wmaybe-uninitialized]
     regmap_update_bits_base(map, reg, mask, val, NULL, false, false)
     ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/i2c/ov7740.c:512:5: note: 'val' was declared here
     u8 val;
        ^~~

vim +/REG_REG15 +57 drivers/media/i2c/ov7740.c

    55	
    56	#define REG_REG14	0x14
  > 57	#define REG_REG15	0x15
    58	#define REG15_GAIN_MSB	0x03
    59	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 46548 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171030/928ea05a/attachment-0001.gz>
