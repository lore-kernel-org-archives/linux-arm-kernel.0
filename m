From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Thu,  9 Jul 2015 18:11:29 +0530
Subject: [PATCH 0/3] regulator: 88pm800: Add 88pm860 regulator support
Message-ID: <1436445692-10656-1-git-send-email-vaibhav.hiremath@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

88PM860 falls under 88pm800 family of devices, with additional feature
enhancements, like,
 - 88pm860 had additional BUCK regulator (BUCK6 and BUCK1B)
 - Additional LDO (LDO20)
 - different voltage and current capability

This patch adds 88PM860 related buck/ldo voltage/current data to
the driver, and creates the regulator match table.

With the addition of 88pm860 device, the naming convention of
voltage tables would no longer be mapped to respective ldos/bucks,
so this patch also renames to more generic name.

This patch-series also includes, 
  PATCH [2/3] - fix LDO vsel_mask value
  PATCH [3/3] - Add dev_info to show probe success status

Testing:
  - Boot tested on PXA1928 based platform, where all BUCK's and LDO's got
    registered successfully 
  - Verified that MMC driver is getting regulator successfully

TODO:
  - Validation on 88PM800 device, looking for some help here, as I do
    not have any platform with 88PM800 device.


Vaibhav Hiremath (2):
  regulator: 88pm800: Add 88pm860 regulator support
  regulator: 88pm800: Add dev_info to show probe success status

Yi Zhang (1):
  regulator: 88pm800: fix LDO vsel_mask value

 drivers/regulator/88pm800.c | 197 ++++++++++++++++++++++++++++++++++----------
 include/linux/mfd/88pm80x.h |   3 +
 2 files changed, 156 insertions(+), 44 deletions(-)

-- 
1.9.1
