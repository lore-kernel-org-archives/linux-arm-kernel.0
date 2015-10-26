From: lkp@intel.com (kbuild test robot)
Date: Tue, 27 Oct 2015 06:11:50 +0800
Subject: [PATCH 08/10] pwm: core: add pulse feature to the PWM framework
In-Reply-To: <1445895161-2317-9-git-send-email-o.schinagl@ultimaker.com>
Message-ID: <201510270604.Wd08v8a2%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olliver,

[auto build test WARNING on pwm/for-next -- if it's inappropriate base, please suggest rules for selecting the more suitable base]

url:    https://github.com/0day-ci/linux/commits/Olliver-Schinagl/pwm-lpc18xx_pwm-use-pwm_set_chip_data/20151027-053853
config: arm-at91_dt_defconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All warnings (new ones prefixed by >>):

>> drivers/pwm/pwm-atmel-tcb.c:359:2: warning: initialization from incompatible pointer type
     .config = atmel_tcb_pwm_config,
     ^
   drivers/pwm/pwm-atmel-tcb.c:359:2: warning: (near initialization for 'atmel_tcb_pwm_ops.config')

vim +359 drivers/pwm/pwm-atmel-tcb.c

9421bade Boris BREZILLON 2013-01-08  343  	}
9421bade Boris BREZILLON 2013-01-08  344  
9421bade Boris BREZILLON 2013-01-08  345  	tcbpwm->period = period;
9421bade Boris BREZILLON 2013-01-08  346  	tcbpwm->div = i;
9421bade Boris BREZILLON 2013-01-08  347  	tcbpwm->duty = duty;
9421bade Boris BREZILLON 2013-01-08  348  
9421bade Boris BREZILLON 2013-01-08  349  	/* If the PWM is enabled, call enable to apply the new conf */
5c31252c Boris Brezillon 2015-07-01  350  	if (pwm_is_enabled(pwm))
9421bade Boris BREZILLON 2013-01-08  351  		atmel_tcb_pwm_enable(chip, pwm);
9421bade Boris BREZILLON 2013-01-08  352  
9421bade Boris BREZILLON 2013-01-08  353  	return 0;
9421bade Boris BREZILLON 2013-01-08  354  }
9421bade Boris BREZILLON 2013-01-08  355  
9421bade Boris BREZILLON 2013-01-08  356  static const struct pwm_ops atmel_tcb_pwm_ops = {
9421bade Boris BREZILLON 2013-01-08  357  	.request = atmel_tcb_pwm_request,
9421bade Boris BREZILLON 2013-01-08  358  	.free = atmel_tcb_pwm_free,
9421bade Boris BREZILLON 2013-01-08 @359  	.config = atmel_tcb_pwm_config,
9421bade Boris BREZILLON 2013-01-08  360  	.set_polarity = atmel_tcb_pwm_set_polarity,
9421bade Boris BREZILLON 2013-01-08  361  	.enable = atmel_tcb_pwm_enable,
9421bade Boris BREZILLON 2013-01-08  362  	.disable = atmel_tcb_pwm_disable,
83c80dc5 Axel Lin        2013-03-31  363  	.owner = THIS_MODULE,
9421bade Boris BREZILLON 2013-01-08  364  };
9421bade Boris BREZILLON 2013-01-08  365  
9421bade Boris BREZILLON 2013-01-08  366  static int atmel_tcb_pwm_probe(struct platform_device *pdev)
9421bade Boris BREZILLON 2013-01-08  367  {

:::::: The code at line 359 was first introduced by commit
:::::: 9421bade0765d8ffb86b8a99213b611278a3542a pwm: atmel: add Timer Counter Block PWM driver

:::::: TO: Boris BREZILLON <linux-arm@overkiz.com>
:::::: CC: Thierry Reding <thierry.reding@avionic-design.de>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 20010 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151027/811ada4f/attachment-0001.obj>
