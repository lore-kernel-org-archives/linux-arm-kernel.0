From: lkp@intel.com (kbuild test robot)
Date: Mon, 27 Jun 2016 12:51:11 +0800
Subject: [PATCH 18/21] usb: chipidea: msm: Add reset controller for PHY
 POR bit
In-Reply-To: <20160626072838.28082-19-stephen.boyd@linaro.org>
Message-ID: <201606271249.bdZD6C5w%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test ERROR on peter.chen-usb/ci-for-usb-next]
[also build test ERROR on v4.7-rc5 next-20160624]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Stephen-Boyd/Support-qcom-s-HSIC-USB-and-rewrite-USB2-HS-phy-support/20160627-102637
base:   https://git.kernel.org/pub/scm/linux/kernel/git/peter.chen/usb ci-for-usb-next
config: arm-multi_v5_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 5.3.1-8) 5.3.1 20160205
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   drivers/built-in.o: In function `ci_hdrc_msm_remove':
>> drivers/usb/chipidea/ci_hdrc_msm.c:275: undefined reference to `reset_controller_unregister'

vim +275 drivers/usb/chipidea/ci_hdrc_msm.c

   269	
   270		pm_runtime_put(&pdev->dev);
   271		pm_runtime_disable(&pdev->dev);
   272		ci_hdrc_remove_device(ci->ci);
   273		clk_disable_unprepare(ci->iface_clk);
   274		clk_disable_unprepare(ci->core_clk);
 > 275		reset_controller_unregister(&ci->rcdev);
   276	
   277		return 0;
   278	}

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 23385 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160627/6d6296a1/attachment-0001.obj>
