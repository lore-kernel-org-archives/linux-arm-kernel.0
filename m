From: lkp@intel.com (kbuild test robot)
Date: Sun, 18 Jun 2017 12:56:16 +0800
Subject: [PATCH 3/5] soc: bcm: brcmstb: Add support for S2/S3/S5 suspend
 states (ARM)
In-Reply-To: <20170616213703.21487-4-f.fainelli@gmail.com>
Message-ID: <201706181226.985X4SQm%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Brian,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.12-rc5 next-20170616]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Florian-Fainelli/Broadcom-STB-S2-S3-S5-support-for-ARM-and-MIPS/20170618-091951
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   drivers/soc/bcm/brcmstb/pm/s2-arm.S: Assembler messages:
>> drivers/soc/bcm/brcmstb/pm/s2-arm.S:35: Error: selected processor does not support `dsb' in ARM mode

vim +35 drivers/soc/bcm/brcmstb/pm/s2-arm.S

    29	ENTRY(brcmstb_pm_do_s2)
    30		stmfd	sp!, {r4-r11, lr}
    31		mov	AON_CTRL_REG, r0
    32		mov	DDR_PHY_STATUS_REG, r1
    33	
    34		/* Flush memory transactions */
  > 35		dsb
    36	
    37		/* Cache DDR_PHY_STATUS_REG translation */
    38		ldr	r0, [DDR_PHY_STATUS_REG]

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 62410 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170618/4c19ae92/attachment-0001.gz>
