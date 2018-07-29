From: lkp@intel.com (kbuild test robot)
Date: Mon, 30 Jul 2018 03:12:45 +0800
Subject: [PATCH v2 1/5] pinctrl: actions: define constructor generic to
 Actions Semi SoC's
In-Reply-To: <20180729182551.19383-2-sravanhome@gmail.com>
References: <20180729182551.19383-2-sravanhome@gmail.com>
Message-ID: <201807300323.a9ci7ngQ%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Saravanan,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on pinctrl/devel]
[also build test ERROR on next-20180727]
[cannot apply to v4.18-rc6]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Saravanan-Sekar/Add-Actions-Semi-S700-pinctrl-support/20180730-022827
base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git devel
config: sparc64-allmodconfig (attached as .config)
compiler: sparc64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=sparc64 

Note: the linux-review/Saravanan-Sekar/Add-Actions-Semi-S700-pinctrl-support/20180730-022827 HEAD edc8b81de011f2413aa90b738a8fad302e281785 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   drivers/pinctrl/actions/pinctrl-owl.c: In function 'owl_pad_pinconf_arg2val':
>> drivers/pinctrl/actions/pinctrl-owl.c:255:10: error: 'OWL_PINCONF_PULL_HOLD' undeclared (first use in this function); did you mean 'OWL_PINCONF_DRV_12MA'?
      *arg = OWL_PINCONF_PULL_HOLD;
             ^~~~~~~~~~~~~~~~~~~~~
             OWL_PINCONF_DRV_12MA
   drivers/pinctrl/actions/pinctrl-owl.c:255:10: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/pinctrl/actions/pinctrl-owl.c:258:10: error: 'OWL_PINCONF_PULL_HIZ' undeclared (first use in this function); did you mean 'OWL_PINCONF_PULL_HOLD'?
      *arg = OWL_PINCONF_PULL_HIZ;
             ^~~~~~~~~~~~~~~~~~~~
             OWL_PINCONF_PULL_HOLD
>> drivers/pinctrl/actions/pinctrl-owl.c:261:10: error: 'OWL_PINCONF_PULL_DOWN' undeclared (first use in this function); did you mean 'OWL_PINCONF_PULL_HOLD'?
      *arg = OWL_PINCONF_PULL_DOWN;
             ^~~~~~~~~~~~~~~~~~~~~
             OWL_PINCONF_PULL_HOLD
>> drivers/pinctrl/actions/pinctrl-owl.c:264:10: error: 'OWL_PINCONF_PULL_UP' undeclared (first use in this function); did you mean 'OWL_PINCONF_PULL_HIZ'?
      *arg = OWL_PINCONF_PULL_UP;
             ^~~~~~~~~~~~~~~~~~~
             OWL_PINCONF_PULL_HIZ
   drivers/pinctrl/actions/pinctrl-owl.c: In function 'owl_pad_pinconf_val2arg':
   drivers/pinctrl/actions/pinctrl-owl.c:282:18: error: 'OWL_PINCONF_PULL_HOLD' undeclared (first use in this function); did you mean 'OWL_PINCONF_DRV_12MA'?
      *arg = *arg == OWL_PINCONF_PULL_HOLD;
                     ^~~~~~~~~~~~~~~~~~~~~
                     OWL_PINCONF_DRV_12MA
   drivers/pinctrl/actions/pinctrl-owl.c:285:18: error: 'OWL_PINCONF_PULL_HIZ' undeclared (first use in this function); did you mean 'OWL_PINCONF_PULL_HOLD'?
      *arg = *arg == OWL_PINCONF_PULL_HIZ;
                     ^~~~~~~~~~~~~~~~~~~~
                     OWL_PINCONF_PULL_HOLD
   drivers/pinctrl/actions/pinctrl-owl.c:288:18: error: 'OWL_PINCONF_PULL_DOWN' undeclared (first use in this function); did you mean 'OWL_PINCONF_PULL_HOLD'?
      *arg = *arg == OWL_PINCONF_PULL_DOWN;
                     ^~~~~~~~~~~~~~~~~~~~~
                     OWL_PINCONF_PULL_HOLD
   drivers/pinctrl/actions/pinctrl-owl.c:291:18: error: 'OWL_PINCONF_PULL_UP' undeclared (first use in this function); did you mean 'OWL_PINCONF_PULL_HIZ'?
      *arg = *arg == OWL_PINCONF_PULL_UP;
                     ^~~~~~~~~~~~~~~~~~~
                     OWL_PINCONF_PULL_HIZ

vim +255 drivers/pinctrl/actions/pinctrl-owl.c

2242ddfb Manivannan Sadhasivam 2018-04-04  248  
2242ddfb Manivannan Sadhasivam 2018-04-04  249  static int owl_pad_pinconf_arg2val(const struct owl_padinfo *info,
2242ddfb Manivannan Sadhasivam 2018-04-04  250  				unsigned int param,
2242ddfb Manivannan Sadhasivam 2018-04-04  251  				u32 *arg)
2242ddfb Manivannan Sadhasivam 2018-04-04  252  {
2242ddfb Manivannan Sadhasivam 2018-04-04  253  	switch (param) {
2242ddfb Manivannan Sadhasivam 2018-04-04  254  	case PIN_CONFIG_BIAS_BUS_HOLD:
2242ddfb Manivannan Sadhasivam 2018-04-04 @255  		*arg = OWL_PINCONF_PULL_HOLD;
2242ddfb Manivannan Sadhasivam 2018-04-04  256  		break;
2242ddfb Manivannan Sadhasivam 2018-04-04  257  	case PIN_CONFIG_BIAS_HIGH_IMPEDANCE:
2242ddfb Manivannan Sadhasivam 2018-04-04 @258  		*arg = OWL_PINCONF_PULL_HIZ;
2242ddfb Manivannan Sadhasivam 2018-04-04  259  		break;
2242ddfb Manivannan Sadhasivam 2018-04-04  260  	case PIN_CONFIG_BIAS_PULL_DOWN:
2242ddfb Manivannan Sadhasivam 2018-04-04 @261  		*arg = OWL_PINCONF_PULL_DOWN;
2242ddfb Manivannan Sadhasivam 2018-04-04  262  		break;
2242ddfb Manivannan Sadhasivam 2018-04-04  263  	case PIN_CONFIG_BIAS_PULL_UP:
2242ddfb Manivannan Sadhasivam 2018-04-04 @264  		*arg = OWL_PINCONF_PULL_UP;
2242ddfb Manivannan Sadhasivam 2018-04-04  265  		break;
2242ddfb Manivannan Sadhasivam 2018-04-04  266  	case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
2242ddfb Manivannan Sadhasivam 2018-04-04  267  		*arg = (*arg >= 1 ? 1 : 0);
2242ddfb Manivannan Sadhasivam 2018-04-04  268  		break;
2242ddfb Manivannan Sadhasivam 2018-04-04  269  	default:
2242ddfb Manivannan Sadhasivam 2018-04-04  270  		return -ENOTSUPP;
2242ddfb Manivannan Sadhasivam 2018-04-04  271  	}
2242ddfb Manivannan Sadhasivam 2018-04-04  272  
2242ddfb Manivannan Sadhasivam 2018-04-04  273  	return 0;
2242ddfb Manivannan Sadhasivam 2018-04-04  274  }
2242ddfb Manivannan Sadhasivam 2018-04-04  275  

:::::: The code at line 255 was first introduced by commit
:::::: 2242ddfbf4d699b58d12467bbebae167d7563700 pinctrl: actions: Add Actions S900 pinctrl driver

:::::: TO: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
:::::: CC: Linus Walleij <linus.walleij@linaro.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 54284 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180730/2b0b1bcd/attachment-0001.gz>
