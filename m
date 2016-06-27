From: lkp@intel.com (kbuild test robot)
Date: Mon, 27 Jun 2016 20:20:10 +0800
Subject: [PATCH v2 1/8] mfd: tps65218: Remove redundant read wrapper
In-Reply-To: <1467025305-13464-2-git-send-email-j-keerthy@ti.com>
Message-ID: <201606272018.UTkpVQyW%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test ERROR on robh/for-next]
[also build test ERROR on v4.7-rc5 next-20160624]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Keerthy/mfd-regulator-tps65218-Clean-ups/20160627-191539
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: x86_64-randconfig-n0-06271854 (attached as .config)
compiler: gcc-6 (Debian 6.1.1-1) 6.1.1 20160430
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers/input/misc/tps65218-pwrbutton.c: In function 'tps65218_pwr_irq':
>> drivers/input/misc/tps65218-pwrbutton.c:39:10: error: implicit declaration of function 'tps65218_reg_read' [-Werror=implicit-function-declaration]
     error = tps65218_reg_read(pwr->tps, TPS65218_REG_STATUS, &reg);
             ^~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/tps65218_reg_read +39 drivers/input/misc/tps65218-pwrbutton.c

5fafed3e Felipe Balbi 2014-12-27  33  static irqreturn_t tps65218_pwr_irq(int irq, void *_pwr)
5fafed3e Felipe Balbi 2014-12-27  34  {
5fafed3e Felipe Balbi 2014-12-27  35  	struct tps65218_pwrbutton *pwr = _pwr;
5fafed3e Felipe Balbi 2014-12-27  36  	unsigned int reg;
5fafed3e Felipe Balbi 2014-12-27  37  	int error;
5fafed3e Felipe Balbi 2014-12-27  38  
5fafed3e Felipe Balbi 2014-12-27 @39  	error = tps65218_reg_read(pwr->tps, TPS65218_REG_STATUS, &reg);
5fafed3e Felipe Balbi 2014-12-27  40  	if (error) {
5fafed3e Felipe Balbi 2014-12-27  41  		dev_err(pwr->dev, "can't read register: %d\n", error);
5fafed3e Felipe Balbi 2014-12-27  42  		goto out;

:::::: The code at line 39 was first introduced by commit
:::::: 5fafed3e5612e9f308d20dc94adf5fc3d4a1a2a8 Input: add tps65218 power button driver

:::::: TO: Felipe Balbi <balbi@ti.com>
:::::: CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 22474 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160627/d843ba3a/attachment-0001.obj>
