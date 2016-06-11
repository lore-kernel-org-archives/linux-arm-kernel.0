From: lkp@intel.com (kbuild test robot)
Date: Sun, 12 Jun 2016 05:08:13 +0800
Subject: [PATCH v3,4/5] usb: Add MediaTek USB3 DRD Driver
In-Reply-To: <1465543962-11678-5-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <201606120512.cHS58YAk%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test ERROR on usb/usb-testing]
[also build test ERROR on v4.7-rc2 next-20160609]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Chunfeng-Yun/usb-Add-MediaTek-USB3-DRD-Driver/20160610-153559
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
config: blackfin-allmodconfig (attached as .config)
compiler: bfin-uclinux-gcc (GCC) 4.6.3
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=blackfin 

All errors (new ones prefixed by >>):

   drivers/usb/mtu3/mtu3_dr.c: In function 'ssusb_mode_sysfs_switch':
>> drivers/usb/mtu3/mtu3_dr.c:271:3: error: implicit declaration of function 'pinctrl_select_state' [-Werror=implicit-function-declaration]
   cc1: some warnings being treated as errors

vim +/pinctrl_select_state +271 drivers/usb/mtu3/mtu3_dr.c

   265		struct otg_switch_mtk *otg_sx = &ssusb->otg_switch;
   266	
   267		if (!otg_sx->manual_drd_enabled)
   268			return;
   269	
   270		if (to_host)
 > 271			pinctrl_select_state(otg_sx->id_pinctrl, otg_sx->id_ground);
   272		else
   273			pinctrl_select_state(otg_sx->id_pinctrl, otg_sx->id_float);
   274	}

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 40649 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160612/bb680ca8/attachment-0001.obj>
