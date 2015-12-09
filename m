From: lkp@intel.com (kbuild test robot)
Date: Thu, 10 Dec 2015 03:10:15 +0800
Subject: [PATCH] net/macb: add support for resetting PHY using GPIO
In-Reply-To: <1449683383-5022-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <201512100344.GU1RHCCK%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

[auto build test ERROR on net-next/master]
[also build test ERROR on v4.4-rc4 next-20151209]

url:    https://github.com/0day-ci/linux/commits/Gregory-CLEMENT/net-macb-add-support-for-resetting-PHY-using-GPIO/20151210-015931
config: x86_64-acpi-redef (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers/net/ethernet/cadence/macb.c: In function 'macb_probe':
>> drivers/net/ethernet/cadence/macb.c:2930:2: error: implicit declaration of function 'macb_reset_phy' [-Werror=implicit-function-declaration]
     macb_reset_phy(bp, np, 1);
     ^
   cc1: some warnings being treated as errors

vim +/macb_reset_phy +2930 drivers/net/ethernet/cadence/macb.c

  2924		mac = of_get_mac_address(np);
  2925		if (mac)
  2926			memcpy(bp->dev->dev_addr, mac, ETH_ALEN);
  2927		else
  2928			macb_get_hwaddr(bp);
  2929	
> 2930		macb_reset_phy(bp, np, 1);
  2931	
  2932		err = of_get_phy_mode(np);
  2933		if (err < 0) {

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 27072 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151210/17b6fd58/attachment-0001.obj>
