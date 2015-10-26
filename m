From: lkp@intel.com (kbuild test robot)
Date: Tue, 27 Oct 2015 06:10:29 +0800
Subject: [PATCH 08/10] pwm: core: add pulse feature to the PWM framework
In-Reply-To: <1445895161-2317-9-git-send-email-o.schinagl@ultimaker.com>
Message-ID: <201510270600.lCMWUXoI%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olliver,

[auto build test ERROR on pwm/for-next -- if it's inappropriate base, please suggest rules for selecting the more suitable base]

url:    https://github.com/0day-ci/linux/commits/Olliver-Schinagl/pwm-lpc18xx_pwm-use-pwm_set_chip_data/20151027-053853
config: i386-randconfig-s1-201543 (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/input/misc/max77693-haptic.c: In function 'max77693_haptic_set_duty_cycle':
>> drivers/input/misc/max77693-haptic.c:76:10: error: too few arguments to function 'pwm_config'
     error = pwm_config(haptic->pwm_dev, delta, haptic->pwm_dev->period);
             ^
   In file included from drivers/input/misc/max77693-haptic.c:23:0:
   include/linux/pwm.h:25:5: note: declared here
    int pwm_config(struct pwm_device *pwm, int duty_ns,
        ^
--
   drivers/input/misc/max8997_haptic.c: In function 'max8997_haptic_set_duty_cycle':
>> drivers/input/misc/max8997_haptic.c:76:9: error: too few arguments to function 'pwm_config'
      ret = pwm_config(chip->pwm, duty, chip->pwm_period);
            ^
   In file included from drivers/input/misc/max8997_haptic.c:29:0:
   include/linux/pwm.h:25:5: note: declared here
    int pwm_config(struct pwm_device *pwm, int duty_ns,
        ^

vim +/pwm_config +76 drivers/input/misc/max77693-haptic.c

a3b3ca75 Jaewon Kim 2014-09-11  70  
a3b3ca75 Jaewon Kim 2014-09-11  71  static int max77693_haptic_set_duty_cycle(struct max77693_haptic *haptic)
a3b3ca75 Jaewon Kim 2014-09-11  72  {
a3b3ca75 Jaewon Kim 2014-09-11  73  	int delta = (haptic->pwm_dev->period + haptic->pwm_duty) / 2;
a3b3ca75 Jaewon Kim 2014-09-11  74  	int error;
a3b3ca75 Jaewon Kim 2014-09-11  75  
a3b3ca75 Jaewon Kim 2014-09-11 @76  	error = pwm_config(haptic->pwm_dev, delta, haptic->pwm_dev->period);
a3b3ca75 Jaewon Kim 2014-09-11  77  	if (error) {
a3b3ca75 Jaewon Kim 2014-09-11  78  		dev_err(haptic->dev, "failed to configure pwm: %d\n", error);
a3b3ca75 Jaewon Kim 2014-09-11  79  		return error;

:::::: The code at line 76 was first introduced by commit
:::::: a3b3ca753cdc92c7d5f57404afed3115b3b79cc6 Input: add haptic driver on max77693

:::::: TO: Jaewon Kim <jaewon02.kim@samsung.com>
:::::: CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 24764 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151027/7b41532a/attachment-0001.obj>
