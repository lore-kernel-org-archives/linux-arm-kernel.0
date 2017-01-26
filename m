From: lkp@intel.com (kbuild test robot)
Date: Thu, 26 Jan 2017 19:57:35 +0800
Subject: [PATCH] regulator: constify regulator_ops structures
In-Reply-To: <1485427668-2816-1-git-send-email-bhumirks@gmail.com>
Message-ID: <201701261903.hqeTiDIx%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bhumika,

[auto build test ERROR on regulator/for-next]
[cannot apply to v4.10-rc5 next-20170125]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Bhumika-Goyal/regulator-constify-regulator_ops-structures/20170126-185451
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next
config: ia64-allmodconfig (attached as .config)
compiler: ia64-linux-gcc (GCC) 6.2.0
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=ia64 

All error/warnings (new ones prefixed by >>):

   drivers/regulator/anatop-regulator.c: In function 'anatop_regulator_probe':
>> drivers/regulator/anatop-regulator.c:310:24: error: assignment of member 'enable' in read-only object
       anatop_rops.enable  = regulator_enable_regmap;
                           ^
>> drivers/regulator/anatop-regulator.c:311:24: error: assignment of member 'disable' in read-only object
       anatop_rops.disable = regulator_disable_regmap;
                           ^
>> drivers/regulator/anatop-regulator.c:312:27: error: assignment of member 'is_enabled' in read-only object
       anatop_rops.is_enabled = regulator_is_enabled_regmap;
                              ^
--
>> drivers/regulator/qcom_spmi-regulator.c:350:11: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
      .ops  = &spmi_##_ops_val##_ops, \
              ^
>> drivers/regulator/qcom_spmi-regulator.c:1169:2: note: in expansion of macro 'SPMI_VREG'
     SPMI_VREG(BUCK,  GP_CTL,   0, INF, SMPS,   smps,   smps,   100000),
     ^~~~~~~~~
>> drivers/regulator/qcom_spmi-regulator.c:350:11: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
      .ops  = &spmi_##_ops_val##_ops, \
              ^
   drivers/regulator/qcom_spmi-regulator.c:1170:2: note: in expansion of macro 'SPMI_VREG'
     SPMI_VREG(LDO,   N300,     0, INF, LDO,    ldo,    nldo1,   10000),
     ^~~~~~~~~
>> drivers/regulator/qcom_spmi-regulator.c:350:11: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
      .ops  = &spmi_##_ops_val##_ops, \
              ^
   drivers/regulator/qcom_spmi-regulator.c:1171:2: note: in expansion of macro 'SPMI_VREG'
     SPMI_VREG(LDO,   N600,     0,   0, LDO,    ldo,    nldo2,   10000),
     ^~~~~~~~~
>> drivers/regulator/qcom_spmi-regulator.c:350:11: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
      .ops  = &spmi_##_ops_val##_ops, \
              ^
   drivers/regulator/qcom_spmi-regulator.c:1172:2: note: in expansion of macro 'SPMI_VREG'
     SPMI_VREG(LDO,   N1200,    0,   0, LDO,    ldo,    nldo2,   10000),
     ^~~~~~~~~
>> drivers/regulator/qcom_spmi-regulator.c:350:11: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
      .ops  = &spmi_##_ops_val##_ops, \
              ^
   drivers/regulator/qcom_spmi-regulator.c:1173:2: note: in expansion of macro 'SPMI_VREG'
     SPMI_VREG(LDO,   N600,     1, INF, LDO,    ldo,    nldo3,   10000),
     ^~~~~~~~~
>> drivers/regulator/qcom_spmi-regulator.c:350:11: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
      .ops  = &spmi_##_ops_val##_ops, \
              ^
   drivers/regulator/qcom_spmi-regulator.c:1174:2: note: in expansion of macro 'SPMI_VREG'
     SPMI_VREG(LDO,   N1200,    1, INF, LDO,    ldo,    nldo3,   10000),
     ^~~~~~~~~
>> drivers/regulator/qcom_spmi-regulator.c:350:11: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
      .ops  = &spmi_##_ops_val##_ops, \
              ^
   drivers/regulator/qcom_spmi-regulator.c:1175:2: note: in expansion of macro 'SPMI_VREG'
     SPMI_VREG(LDO,   N600_ST,  0,   0, LDO,    ldo,    nldo2,   10000),
     ^~~~~~~~~
>> drivers/regulator/qcom_spmi-regulator.c:350:11: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
      .ops  = &spmi_##_ops_val##_ops, \
              ^
   drivers/regulator/qcom_spmi-regulator.c:1176:2: note: in expansion of macro 'SPMI_VREG'
     SPMI_VREG(LDO,   N1200_ST, 0,   0, LDO,    ldo,    nldo2,   10000),
     ^~~~~~~~~
>> drivers/regulator/qcom_spmi-regulator.c:350:11: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
      .ops  = &spmi_##_ops_val##_ops, \
              ^
   drivers/regulator/qcom_spmi-regulator.c:1177:2: note: in expansion of macro 'SPMI_VREG'
     SPMI_VREG(LDO,   N600_ST,  1, INF, LDO,    ldo,    nldo3,   10000),
     ^~~~~~~~~
>> drivers/regulator/qcom_spmi-regulator.c:350:11: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
      .ops  = &spmi_##_ops_val##_ops, \
              ^
   drivers/regulator/qcom_spmi-regulator.c:1178:2: note: in expansion of macro 'SPMI_VREG'
     SPMI_VREG(LDO,   N1200_ST, 1, INF, LDO,    ldo,    nldo3,   10000),
     ^~~~~~~~~
>> drivers/regulator/qcom_spmi-regulator.c:350:11: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
      .ops  = &spmi_##_ops_val##_ops, \
              ^
   drivers/regulator/qcom_spmi-regulator.c:1179:2: note: in expansion of macro 'SPMI_VREG'
     SPMI_VREG(LDO,   P50,      0, INF, LDO,    ldo,    pldo,     5000),
     ^~~~~~~~~
>> drivers/regulator/qcom_spmi-regulator.c:350:11: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
      .ops  = &spmi_##_ops_val##_ops, \
              ^
   drivers/regulator/qcom_spmi-regulator.c:1180:2: note: in expansion of macro 'SPMI_VREG'
     SPMI_VREG(LDO,   P150,     0, INF, LDO,    ldo,    pldo,    10000),
     ^~~~~~~~~
>> drivers/regulator/qcom_spmi-regulator.c:350:11: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
      .ops  = &spmi_##_ops_val##_ops, \
              ^
   drivers/regulator/qcom_spmi-regulator.c:1181:2: note: in expansion of macro 'SPMI_VREG'
     SPMI_VREG(LDO,   P300,     0, INF, LDO,    ldo,    pldo,    10000),
     ^~~~~~~~~
>> drivers/regulator/qcom_spmi-regulator.c:350:11: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
      .ops  = &spmi_##_ops_val##_ops, \
              ^
   drivers/regulator/qcom_spmi-regulator.c:1182:2: note: in expansion of macro 'SPMI_VREG'
     SPMI_VREG(LDO,   P600,     0, INF, LDO,    ldo,    pldo,    10000),
     ^~~~~~~~~
>> drivers/regulator/qcom_spmi-regulator.c:350:11: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
      .ops  = &spmi_##_ops_val##_ops, \
              ^
   drivers/regulator/qcom_spmi-regulator.c:1183:2: note: in expansion of macro 'SPMI_VREG'
     SPMI_VREG(LDO,   P1200,    0, INF, LDO,    ldo,    pldo,    10000),
     ^~~~~~~~~
>> drivers/regulator/qcom_spmi-regulator.c:350:11: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
      .ops  = &spmi_##_ops_val##_ops, \
              ^
   drivers/regulator/qcom_spmi-regulator.c:1184:2: note: in expansion of macro 'SPMI_VREG'
     SPMI_VREG(LDO,   LN,       0, INF, LN_LDO, ln_ldo, ln_ldo,      0),
     ^~~~~~~~~
>> drivers/regulator/qcom_spmi-regulator.c:350:11: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
      .ops  = &spmi_##_ops_val##_ops, \
              ^
   drivers/regulator/qcom_spmi-regulator.c:1185:2: note: in expansion of macro 'SPMI_VREG'
     SPMI_VREG(LDO,   LV_P50,   0, INF, LDO,    ldo,    pldo,     5000),
     ^~~~~~~~~
>> drivers/regulator/qcom_spmi-regulator.c:350:11: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
      .ops  = &spmi_##_ops_val##_ops, \
              ^
   drivers/regulator/qcom_spmi-regulator.c:1186:2: note: in expansion of macro 'SPMI_VREG'
     SPMI_VREG(LDO,   LV_P150,  0, INF, LDO,    ldo,    pldo,    10000),
     ^~~~~~~~~
>> drivers/regulator/qcom_spmi-regulator.c:350:11: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
      .ops  = &spmi_##_ops_val##_ops, \
              ^
   drivers/regulator/qcom_spmi-regulator.c:1187:2: note: in expansion of macro 'SPMI_VREG'
     SPMI_VREG(LDO,   LV_P300,  0, INF, LDO,    ldo,    pldo,    10000),
     ^~~~~~~~~

vim +/enable +310 drivers/regulator/anatop-regulator.c

ca7734ad Andrey Smirnov 2017-01-10  304  		u32 enable_bit;
ca7734ad Andrey Smirnov 2017-01-10  305  
605ebd35 Philipp Zabel  2014-02-11  306  		rdesc->ops = &anatop_rops;
ca7734ad Andrey Smirnov 2017-01-10  307  
ca7734ad Andrey Smirnov 2017-01-10  308  		if (!of_property_read_u32(np, "anatop-enable-bit",
ca7734ad Andrey Smirnov 2017-01-10  309  					  &enable_bit)) {
ca7734ad Andrey Smirnov 2017-01-10 @310  			anatop_rops.enable  = regulator_enable_regmap;
ca7734ad Andrey Smirnov 2017-01-10 @311  			anatop_rops.disable = regulator_disable_regmap;
ca7734ad Andrey Smirnov 2017-01-10 @312  			anatop_rops.is_enabled = regulator_is_enabled_regmap;
ca7734ad Andrey Smirnov 2017-01-10  313  
ca7734ad Andrey Smirnov 2017-01-10  314  			rdesc->enable_reg = sreg->control_reg;
ca7734ad Andrey Smirnov 2017-01-10  315  			rdesc->enable_mask = BIT(enable_bit);

:::::: The code at line 310 was first introduced by commit
:::::: ca7734ad77b4ffb83a03c80b8d64d40c7ef49263 regulator: anatop: Add support for "anatop-enable-bit"

:::::: TO: Andrey Smirnov <andrew.smirnov@gmail.com>
:::::: CC: Mark Brown <broonie@kernel.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 45045 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170126/80a9414a/attachment-0001.gz>
