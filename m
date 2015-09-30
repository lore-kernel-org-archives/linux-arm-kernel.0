From: lkp@intel.com (kbuild test robot)
Date: Wed, 30 Sep 2015 14:52:34 +0800
Subject: [PATCH 1/2] regulator: act8865: support output voltage by
 VSET2[] bits
In-Reply-To: <1443595158-550-2-git-send-email-wenyou.yang@atmel.com>
Message-ID: <201509301442.0ZyMwfNo%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wenyou,

[auto build test results on v4.3-rc3 -- if it's inappropriate base, please ignore]

config: i386-randconfig-r0-201539 (attached as .config)
reproduce:
  git checkout 2470179cdcc3b8eebdb6abd5aecbbe6e2804fb33
  # save the attached .config to linux build tree
  make ARCH=i386 

All error/warnings (new ones prefixed by >>):

>> drivers/regulator/act8865-regulator.c:265:48: error: macro "ACT88xx_REG" requires 5 arguments, but only 4 given
     ACT88xx_REG("DCDC_REG1", ACT8865, DCDC1, VSET2),
                                                   ^
>> drivers/regulator/act8865-regulator.c:265:2: error: 'ACT88xx_REG' undeclared here (not in a function)
     ACT88xx_REG("DCDC_REG1", ACT8865, DCDC1, VSET2),
     ^
   drivers/regulator/act8865-regulator.c:266:48: error: macro "ACT88xx_REG" requires 5 arguments, but only 4 given
     ACT88xx_REG("DCDC_REG2", ACT8865, DCDC2, VSET2),
                                                   ^
   drivers/regulator/act8865-regulator.c:267:48: error: macro "ACT88xx_REG" requires 5 arguments, but only 4 given
     ACT88xx_REG("DCDC_REG3", ACT8865, DCDC3, VSET2),
                                                   ^
   drivers/regulator/act8865-regulator.c:268:45: error: macro "ACT88xx_REG" requires 5 arguments, but only 4 given
     ACT88xx_REG("LDO_REG1", ACT8865, LDO1, VSET),
                                                ^
   drivers/regulator/act8865-regulator.c:269:45: error: macro "ACT88xx_REG" requires 5 arguments, but only 4 given
     ACT88xx_REG("LDO_REG2", ACT8865, LDO2, VSET),
                                                ^
   drivers/regulator/act8865-regulator.c:270:45: error: macro "ACT88xx_REG" requires 5 arguments, but only 4 given
     ACT88xx_REG("LDO_REG3", ACT8865, LDO3, VSET),
                                                ^
   drivers/regulator/act8865-regulator.c:271:45: error: macro "ACT88xx_REG" requires 5 arguments, but only 4 given
     ACT88xx_REG("LDO_REG4", ACT8865, LDO4, VSET),
                                                ^

vim +/ACT88xx_REG +265 drivers/regulator/act8865-regulator.c

   259		ACT88xx_REG("LDO_REG2", ACT8865, LDO2, VSET, "inl45"),
   260		ACT88xx_REG("LDO_REG3", ACT8865, LDO3, VSET, "inl67"),
   261		ACT88xx_REG("LDO_REG4", ACT8865, LDO4, VSET, "inl67"),
   262	};
   263	
   264	static const struct regulator_desc act8865_alt_regulators[] = {
 > 265		ACT88xx_REG("DCDC_REG1", ACT8865, DCDC1, VSET2),
   266		ACT88xx_REG("DCDC_REG2", ACT8865, DCDC2, VSET2),
   267		ACT88xx_REG("DCDC_REG3", ACT8865, DCDC3, VSET2),
   268		ACT88xx_REG("LDO_REG1", ACT8865, LDO1, VSET),

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 24380 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150930/3c6c4aed/attachment-0001.obj>
