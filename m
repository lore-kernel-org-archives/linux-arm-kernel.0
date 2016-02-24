From: lkp@intel.com (kbuild test robot)
Date: Thu, 25 Feb 2016 02:28:45 +0800
Subject: [PATCH 15/50] pinctrl: mvebu: Use devm_pinctrl_register() for
 pinctrl registration
In-Reply-To: <1456319775-3216-16-git-send-email-ldewangan@nvidia.com>
Message-ID: <201602250248.psr4kejZ%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laxman,

[auto build test ERROR on pinctrl/for-next]
[also build test ERROR on v4.5-rc5 next-20160224]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Laxman-Dewangan/pinctrl-Add-and-use-devm_-apis-for-pinctrl_-register-unregister/20160225-002237
base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git for-next
config: arm-multi_v5_defconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   drivers/built-in.o: In function `orion_pinctrl_remove':
>> drivers/pinctrl/mvebu/pinctrl-orion.c:244: undefined reference to `mvebu_pinctrl_remove'

vim +244 drivers/pinctrl/mvebu/pinctrl-orion.c

fd67f884 Thomas Petazzoni 2014-04-22  238  
fd67f884 Thomas Petazzoni 2014-04-22  239  	return mvebu_pinctrl_probe(pdev);
fd67f884 Thomas Petazzoni 2014-04-22  240  }
fd67f884 Thomas Petazzoni 2014-04-22  241  
fd67f884 Thomas Petazzoni 2014-04-22  242  static int orion_pinctrl_remove(struct platform_device *pdev)
fd67f884 Thomas Petazzoni 2014-04-22  243  {
fd67f884 Thomas Petazzoni 2014-04-22 @244  	return mvebu_pinctrl_remove(pdev);
fd67f884 Thomas Petazzoni 2014-04-22  245  }
fd67f884 Thomas Petazzoni 2014-04-22  246  
fd67f884 Thomas Petazzoni 2014-04-22  247  static struct platform_driver orion_pinctrl_driver = {

:::::: The code at line 244 was first introduced by commit
:::::: fd67f884782a281eb033e40b0f8eae623416035e pinctrl: mvebu: new driver for Orion platforms

:::::: TO: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
:::::: CC: Linus Walleij <linus.walleij@linaro.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 22481 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160225/2aca0525/attachment-0001.obj>
