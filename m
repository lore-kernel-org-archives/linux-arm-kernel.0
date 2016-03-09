From: lkp@intel.com (kbuild test robot)
Date: Thu, 10 Mar 2016 07:18:58 +0800
Subject: [PATCH 07/13] thermal: convert mtk_thermal to use
 devm_thermal_zone_of_sensor_register
In-Reply-To: <1457559336-17652-8-git-send-email-edubezval@gmail.com>
Message-ID: <201603100707.CFd3FIvK%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eduardo,

[auto build test ERROR on soc-thermal/next]
[also build test ERROR on next-20160309]
[cannot apply to thermal/next v4.5-rc7]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Eduardo-Valentin/thermal-convert-users-of-thermal_zone_of_sensor_register-to-devm_/20160310-054318
base:   https://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal next
config: parisc-allyesconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=parisc 

All errors (new ones prefixed by >>):

   drivers/thermal/mtk_thermal.c: In function 'mtk_thermal_probe':
>> drivers/thermal/mtk_thermal.c:575:2: error: implicit declaration of function 'devm_thermal_zone_of_sensor_register' [-Werror=implicit-function-declaration]
     devm_thermal_zone_of_sensor_register(&pdev->dev, 0, mt,
     ^
   cc1: some warnings being treated as errors

vim +/devm_thermal_zone_of_sensor_register +575 drivers/thermal/mtk_thermal.c

   569		for (i = 0; i < MT8173_NUM_ZONES; i++)
   570			mtk_thermal_init_bank(mt, i, apmixed_phys_base,
   571					      auxadc_phys_base);
   572	
   573		platform_set_drvdata(pdev, mt);
   574	
 > 575		devm_thermal_zone_of_sensor_register(&pdev->dev, 0, mt,
   576						     &mtk_thermal_ops);
   577	
   578		return 0;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 43726 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160310/c73f7ba9/attachment-0001.obj>
