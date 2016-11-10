From: lkp@intel.com (kbuild test robot)
Date: Thu, 10 Nov 2016 15:41:40 +0800
Subject: [PATCH 1/2] mfd: pm8921: add support to pm8821
In-Reply-To: <1478622577-20699-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <201611101507.6LoqLlKA%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Srinivas,

[auto build test ERROR on ljones-mfd/for-mfd-next]
[also build test ERROR on v4.9-rc4 next-20161110]
[cannot apply to robh/for-next]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Srinivas-Kandagatla/mfd-pm8921-add-support-to-pm8821/20161109-013248
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
config: arm-pxa_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All error/warnings (new ones prefixed by >>):

   drivers/mfd/pm8921-core.c: In function 'pm8921_probe':
>> drivers/mfd/pm8921-core.c:630:58: warning: dereferencing 'void *' pointer
     data = of_match_node(pm8921_id_table, pdev->dev.of_node)->data;
                                                             ^~
>> drivers/mfd/pm8921-core.c:630:58: error: request for member 'data' in something not a structure or union

vim +/data +630 drivers/mfd/pm8921-core.c

   624		const struct pm8xxx_data *data;
   625		int irq, rc;
   626		unsigned int val;
   627		u32 rev;
   628		struct pm_irq_chip *chip;
   629	
 > 630		data = of_match_node(pm8921_id_table, pdev->dev.of_node)->data;
   631		if (!data) {
   632			dev_err(&pdev->dev, "No matching driver data found\n");
   633			return -EINVAL;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 30088 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161110/a54a422b/attachment-0001.gz>
