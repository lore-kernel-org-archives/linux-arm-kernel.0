From: lkp@intel.com (kbuild test robot)
Date: Tue, 25 Jul 2017 06:10:40 +0800
Subject: [PATCH v3 3/5] iio: adc: sun4i-gpadc-iio: add support for H3
 thermal sensor
In-Reply-To: <20170723141354.42646-4-icenowy@aosc.io>
Message-ID: <201707250656.l5bNDgGa%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Icenowy,

[auto build test WARNING on robh/for-next]
[also build test WARNING on v4.13-rc2 next-20170724]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Icenowy-Zheng/IIO-based-thermal-sensor-driver-for-Allwinner-H3-SoC/20170725-035642
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: tile-allmodconfig (attached as .config)
compiler: tilegx-linux-gcc (GCC) 4.6.2
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=tile 

All warnings (new ones prefixed by >>):

   drivers/iio/adc/sun4i-gpadc-iio.c: In function 'sun8i_h3_gpadc_sample_start':
>> drivers/iio/adc/sun4i-gpadc-iio.c:415:8: warning: large integer implicitly truncated to unsigned type [-Woverflow]

vim +415 drivers/iio/adc/sun4i-gpadc-iio.c

   410	
   411	static int sun8i_h3_gpadc_sample_start(struct sun4i_gpadc_iio *info)
   412	{
   413		regmap_write(info->regmap, SUN8I_H3_GPADC_CTRL2,
   414			     SUN8I_H3_GPADC_CTRL2_TEMP_SENSE_EN |
 > 415			     SUN8I_H3_GPADC_CTRL2_T_ACQ1(31));
   416		regmap_write(info->regmap, SUN4I_GPADC_CTRL0,
   417			     SUN4I_GPADC_CTRL0_T_ACQ(31));
   418		regmap_write(info->regmap, SUN8I_H3_GPADC_CTRL3,
   419			     SUN4I_GPADC_CTRL3_FILTER_EN |
   420			     SUN4I_GPADC_CTRL3_FILTER_TYPE(1));
   421		regmap_write(info->regmap, SUN8I_H3_GPADC_INTC,
   422			     SUN8I_H3_GPADC_INTC_TEMP_PERIOD(800));
   423	
   424		return 0;
   425	}
   426	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 49775 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170725/2a09c8c9/attachment-0001.gz>
