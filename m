From: lkp@intel.com (kbuild test robot)
Date: Wed, 9 Mar 2016 21:07:40 +0800
Subject: [PATCH 1/4] gpio: Add AXP209 GPIO driver
In-Reply-To: <1457520614-32239-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <201603092136.Tokx1OhO%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

[auto build test ERROR on gpio/for-next]
[also build test ERROR on next-20160309]
[cannot apply to v4.5-rc7]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Maxime-Ripard/Add-AXP209-GPIO-driver/20160309-190907
base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git for-next
config: i386-allmodconfig (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/gpio/gpio-axp209.c: In function 'axp20x_gpio_probe':
>> drivers/gpio/gpio-axp209.c:126:12: error: 'struct gpio_chip' has no member named 'dev'
     gpio->chip.dev   = &pdev->dev;
               ^

vim +126 drivers/gpio/gpio-axp209.c

   120		gpio = devm_kzalloc(&pdev->dev, sizeof(*gpio), GFP_KERNEL);
   121		if (!gpio)
   122			return -ENOMEM;
   123	
   124		gpio->chip.base			= -1;
   125		gpio->chip.can_sleep		= true;
 > 126		gpio->chip.dev			= &pdev->dev;
   127		gpio->chip.label		= dev_name(&pdev->dev);
   128		gpio->chip.owner		= THIS_MODULE;
   129		gpio->chip.get			= axp20x_gpio_get;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 53561 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160309/62f43fa8/attachment-0001.obj>
