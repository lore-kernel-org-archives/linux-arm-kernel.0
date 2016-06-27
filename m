From: lkp@intel.com (kbuild test robot)
Date: Mon, 27 Jun 2016 19:51:14 +0800
Subject: [PATCH v2 1/8] mfd: tps65218: Remove redundant read wrapper
In-Reply-To: <1467025305-13464-2-git-send-email-j-keerthy@ti.com>
Message-ID: <201606271916.m2XMilb6%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test ERROR on robh/for-next]
[also build test ERROR on v4.7-rc5 next-20160624]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Keerthy/mfd-regulator-tps65218-Clean-ups/20160627-191539
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: i386-randconfig-a0-201626 (attached as .config)
compiler: gcc-6 (Debian 6.1.1-1) 6.1.1 20160430
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/gpio/gpio-tps65218.c: In function 'tps65218_gpio_get':
>> drivers/gpio/gpio-tps65218.c:33:8: error: implicit declaration of function 'tps65218_reg_read' [-Werror=implicit-function-declaration]
     ret = tps65218_reg_read(tps65218, TPS65218_REG_ENABLE2, &val);
           ^~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/tps65218_reg_read +33 drivers/gpio/gpio-tps65218.c

c366c76a Nicolas Saenz Julienne 2016-01-30  27  {
c366c76a Nicolas Saenz Julienne 2016-01-30  28  	struct tps65218_gpio *tps65218_gpio = gpiochip_get_data(gc);
c366c76a Nicolas Saenz Julienne 2016-01-30  29  	struct tps65218 *tps65218 = tps65218_gpio->tps65218;
c366c76a Nicolas Saenz Julienne 2016-01-30  30  	unsigned int val;
c366c76a Nicolas Saenz Julienne 2016-01-30  31  	int ret;
c366c76a Nicolas Saenz Julienne 2016-01-30  32  
c366c76a Nicolas Saenz Julienne 2016-01-30 @33  	ret = tps65218_reg_read(tps65218, TPS65218_REG_ENABLE2, &val);
c366c76a Nicolas Saenz Julienne 2016-01-30  34  	if (ret)
c366c76a Nicolas Saenz Julienne 2016-01-30  35  		return ret;
c366c76a Nicolas Saenz Julienne 2016-01-30  36  

:::::: The code at line 33 was first introduced by commit
:::::: c366c76a2c41d0c545e51b53056b21515db32e77 gpio: add tps65218 gpio

:::::: TO: Nicolas Saenz Julienne <nicolassaenzj@gmail.com>
:::::: CC: Linus Walleij <linus.walleij@linaro.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 21936 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160627/458b34d5/attachment-0001.obj>
