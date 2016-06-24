From: lkp@intel.com (kbuild test robot)
Date: Fri, 24 Jun 2016 19:22:43 +0800
Subject: [PATCH 2/7] power: act8945a_charger: Improve
In-Reply-To: <1466752660-2922-3-git-send-email-wenyou.yang@atmel.com>
Message-ID: <201606241928.mtok89jV%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test ERROR on battery/master]
[also build test ERROR on v4.7-rc4 next-20160624]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Wenyou-Yang/power-act8945a_charger-Improvements/20160624-153641
base:   git://git.infradead.org/battery-2.6.git master
config: x86_64-randconfig-s1-06241859 (attached as .config)
compiler: gcc-6 (Debian 6.1.1-1) 6.1.1 20160430
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

Note: the linux-review/Wenyou-Yang/power-act8945a_charger-Improvements/20160624-153641 HEAD 07219a8e44d2a15ec36d4a85dc98229c8cc6d858 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   drivers/power/act8945a_charger.c: In function 'act8945a_charger_config':
>> drivers/power/act8945a_charger.c:279:2: error: 'ret' undeclared (first use in this function)
     ret = regmap_read(regmap, ACT8945A_APCH_CFG, &tmp);
     ^~~
   drivers/power/act8945a_charger.c:279:2: note: each undeclared identifier is reported only once for each function it appears in

vim +/ret +279 drivers/power/act8945a_charger.c

   273	
   274		if (!np) {
   275			dev_err(dev, "no charger of node\n");
   276			return -EINVAL;
   277		}
   278	
 > 279		ret = regmap_read(regmap, ACT8945A_APCH_CFG, &tmp);
   280		if (ret)
   281			return ret;
   282	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 29557 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160624/91933601/attachment-0001.obj>
