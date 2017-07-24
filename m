From: lkp@intel.com (kbuild test robot)
Date: Tue, 25 Jul 2017 06:14:36 +0800
Subject: [PATCH v3 3/5] iio: adc: sun4i-gpadc-iio: add support for H3
 thermal sensor
In-Reply-To: <20170723141354.42646-4-icenowy@aosc.io>
Message-ID: <201707250651.1AOl3egI%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Icenowy,

[auto build test WARNING on robh/for-next]
[also build test WARNING on v4.13-rc2 next-20170724]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Icenowy-Zheng/IIO-based-thermal-sensor-driver-for-Allwinner-H3-SoC/20170725-035642
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: sparc64-allmodconfig (attached as .config)
compiler: sparc64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=sparc64 

All warnings (new ones prefixed by >>):

   In file included from include/linux/kernel.h:10:0,
                    from include/linux/clk.h:16,
                    from drivers/iio/adc/sun4i-gpadc-iio.c:25:
   drivers/iio/adc/sun4i-gpadc-iio.c: In function 'sun8i_h3_gpadc_sample_start':
   include/linux/bitops.h:6:19: warning: large integer implicitly truncated to unsigned type [-Woverflow]
    #define BIT(nr)   (1UL << (nr))
                      ^
>> include/linux/mfd/sun4i-gpadc.h:57:45: note: in expansion of macro 'BIT'
    #define SUN8I_H3_GPADC_CTRL2_TEMP_SENSE_EN  BIT(0)
                                                ^~~
>> drivers/iio/adc/sun4i-gpadc-iio.c:414:8: note: in expansion of macro 'SUN8I_H3_GPADC_CTRL2_TEMP_SENSE_EN'
           SUN8I_H3_GPADC_CTRL2_TEMP_SENSE_EN |
           ^
--
   In file included from include/linux/kernel.h:10:0,
                    from include/linux/clk.h:16,
                    from drivers/iio//adc/sun4i-gpadc-iio.c:25:
   drivers/iio//adc/sun4i-gpadc-iio.c: In function 'sun8i_h3_gpadc_sample_start':
   include/linux/bitops.h:6:19: warning: large integer implicitly truncated to unsigned type [-Woverflow]
    #define BIT(nr)   (1UL << (nr))
                      ^
>> include/linux/mfd/sun4i-gpadc.h:57:45: note: in expansion of macro 'BIT'
    #define SUN8I_H3_GPADC_CTRL2_TEMP_SENSE_EN  BIT(0)
                                                ^~~
   drivers/iio//adc/sun4i-gpadc-iio.c:414:8: note: in expansion of macro 'SUN8I_H3_GPADC_CTRL2_TEMP_SENSE_EN'
           SUN8I_H3_GPADC_CTRL2_TEMP_SENSE_EN |
           ^

vim +/BIT +57 include/linux/mfd/sun4i-gpadc.h

    56	
  > 57	#define SUN8I_H3_GPADC_CTRL2_TEMP_SENSE_EN		BIT(0)
    58	#define SUN8I_H3_GPADC_CTRL2_T_ACQ1(x)			((GENMASK(15, 0) * (x)) << 16)
    59	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 51321 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170725/0e4dc25e/attachment-0001.gz>
