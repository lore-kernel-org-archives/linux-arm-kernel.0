From: lkp@intel.com (kbuild test robot)
Date: Fri, 16 Oct 2015 10:42:17 +0800
Subject: [RESEND PATCH] pwm-backlight: fix the panel power sequence
In-Reply-To: <1444959454-1516-1-git-send-email-yh.huang@mediatek.com>
Message-ID: <201510161036.Q5q8ayZx%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi YH,

[auto build test ERROR on pwm/for-next -- if it's inappropriate base, please suggest rules for selecting the more suitable base]

url:    https://github.com/0day-ci/linux/commits/YH-Huang/pwm-backlight-fix-the-panel-power-sequence/20151016-093957
config: i386-allmodconfig (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/video/backlight/pwm_bl.c: In function 'pwm_backlight_probe':
>> drivers/video/backlight/pwm_bl.c:245:20: error: too few arguments to function 'devm_gpiod_get_optional'
     pb->enable_gpio = devm_gpiod_get_optional(&pdev->dev, "enable");
                       ^
   In file included from drivers/video/backlight/pwm_bl.c:13:0:
   include/linux/gpio/consumer.h:80:32: note: declared here
    struct gpio_desc *__must_check devm_gpiod_get_optional(struct device *dev,
                                   ^

vim +/devm_gpiod_get_optional +245 drivers/video/backlight/pwm_bl.c

   239		pb->notify_after = data->notify_after;
   240		pb->check_fb = data->check_fb;
   241		pb->exit = data->exit;
   242		pb->dev = &pdev->dev;
   243		pb->enabled = false;
   244	
 > 245		pb->enable_gpio = devm_gpiod_get_optional(&pdev->dev, "enable");
   246		if (IS_ERR(pb->enable_gpio)) {
   247			ret = PTR_ERR(pb->enable_gpio);
   248			goto err_alloc;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 51512 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151016/2b0d9788/attachment-0001.obj>
