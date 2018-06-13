From: lkp@intel.com (kbuild test robot)
Date: Wed, 13 Jun 2018 17:07:19 +0800
Subject: [PATCH 2/2] mtd: rawnand: meson: add support for Amlogic NAND
 flash controller
In-Reply-To: <20180613161314.14894-3-yixun.lan@amlogic.com>
References: <20180613161314.14894-3-yixun.lan@amlogic.com>
Message-ID: <201806131700.twRxl242%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Liang,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on mtd/nand/next]
[also build test ERROR on v4.17 next-20180613]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Yixun-Lan/mtd-rawnand-meson-add-Amlogic-NAND-driver-support/20180613-161917
base:   git://git.infradead.org/linux-mtd.git nand/next
config: sparc64-allyesconfig (attached as .config)
compiler: sparc64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=sparc64 

All error/warnings (new ones prefixed by >>):

   In file included from drivers/mtd/nand/raw/meson_nand.c:21:0:
>> drivers/clk/meson/clk-regmap.h:22:16: error: field 'hw' has incomplete type
     struct clk_hw hw;
                   ^~
>> drivers/mtd/nand/raw/meson_nand.c:951:2: error: field name not in record or union initializer
     .hw.init = &(struct clk_init_data) {
     ^
   drivers/mtd/nand/raw/meson_nand.c:951:2: note: (near initialization for 'sd_emmc_c_ext_clk0_sel')
>> drivers/mtd/nand/raw/meson_nand.c:952:4: error: 'struct clk_init_data' has no member named 'name'
      .name = "sd_emmc_c_nand_clk_mux",
       ^~~~
>> drivers/mtd/nand/raw/meson_nand.c:952:11: warning: excess elements in struct initializer
      .name = "sd_emmc_c_nand_clk_mux",
              ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/mtd/nand/raw/meson_nand.c:952:11: note: (near initialization for '(anonymous)')
>> drivers/mtd/nand/raw/meson_nand.c:953:4: error: 'struct clk_init_data' has no member named 'ops'
      .ops = &clk_regmap_mux_ops,
       ^~~
   drivers/mtd/nand/raw/meson_nand.c:953:10: warning: excess elements in struct initializer
      .ops = &clk_regmap_mux_ops,
             ^
   drivers/mtd/nand/raw/meson_nand.c:953:10: note: (near initialization for '(anonymous)')
>> drivers/mtd/nand/raw/meson_nand.c:954:4: error: 'struct clk_init_data' has no member named 'parent_names'
      .parent_names = sd_emmc_ext_clk0_parent_names,
       ^~~~~~~~~~~~
   drivers/mtd/nand/raw/meson_nand.c:954:19: warning: excess elements in struct initializer
      .parent_names = sd_emmc_ext_clk0_parent_names,
                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/mtd/nand/raw/meson_nand.c:954:19: note: (near initialization for '(anonymous)')
>> drivers/mtd/nand/raw/meson_nand.c:955:4: error: 'struct clk_init_data' has no member named 'num_parents'
      .num_parents = ARRAY_SIZE(sd_emmc_ext_clk0_parent_names),
       ^~~~~~~~~~~
   In file included from include/linux/list.h:9:0,
                    from include/linux/kobject.h:19,
                    from include/linux/device.h:16,
                    from include/linux/platform_device.h:14,
                    from drivers/mtd/nand/raw/meson_nand.c:9:
>> include/linux/kernel.h:71:25: warning: excess elements in struct initializer
    #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
                            ^
>> drivers/mtd/nand/raw/meson_nand.c:955:18: note: in expansion of macro 'ARRAY_SIZE'
      .num_parents = ARRAY_SIZE(sd_emmc_ext_clk0_parent_names),
                     ^~~~~~~~~~
   include/linux/kernel.h:71:25: note: (near initialization for '(anonymous)')
    #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
                            ^
>> drivers/mtd/nand/raw/meson_nand.c:955:18: note: in expansion of macro 'ARRAY_SIZE'
      .num_parents = ARRAY_SIZE(sd_emmc_ext_clk0_parent_names),
                     ^~~~~~~~~~
>> drivers/mtd/nand/raw/meson_nand.c:956:4: error: 'struct clk_init_data' has no member named 'flags'
      .flags = CLK_SET_RATE_PARENT,
       ^~~~~
>> drivers/mtd/nand/raw/meson_nand.c:956:12: error: 'CLK_SET_RATE_PARENT' undeclared here (not in a function); did you mean 'DL_STATE_DORMANT'?
      .flags = CLK_SET_RATE_PARENT,
               ^~~~~~~~~~~~~~~~~~~
               DL_STATE_DORMANT
   drivers/mtd/nand/raw/meson_nand.c:956:12: warning: excess elements in struct initializer
   drivers/mtd/nand/raw/meson_nand.c:956:12: note: (near initialization for '(anonymous)')
>> drivers/mtd/nand/raw/meson_nand.c:951:37: error: invalid use of undefined type 'struct clk_init_data'
     .hw.init = &(struct clk_init_data) {
                                        ^
>> drivers/mtd/nand/raw/meson_nand.c:965:12: error: 'CLK_DIVIDER_ROUND_CLOSEST' undeclared here (not in a function); did you mean 'DIV_ROUND_CLOSEST'?
      .flags = CLK_DIVIDER_ROUND_CLOSEST | CLK_DIVIDER_ONE_BASED,
               ^~~~~~~~~~~~~~~~~~~~~~~~~
               DIV_ROUND_CLOSEST
>> drivers/mtd/nand/raw/meson_nand.c:965:40: error: 'CLK_DIVIDER_ONE_BASED' undeclared here (not in a function); did you mean 'CLK_DIVIDER_ROUND_CLOSEST'?
      .flags = CLK_DIVIDER_ROUND_CLOSEST | CLK_DIVIDER_ONE_BASED,
                                           ^~~~~~~~~~~~~~~~~~~~~
                                           CLK_DIVIDER_ROUND_CLOSEST
   drivers/mtd/nand/raw/meson_nand.c:967:2: error: field name not in record or union initializer
     .hw.init = &(struct clk_init_data) {
     ^
   drivers/mtd/nand/raw/meson_nand.c:967:2: note: (near initialization for 'sd_emmc_c_ext_clk0_div')
   drivers/mtd/nand/raw/meson_nand.c:968:4: error: 'struct clk_init_data' has no member named 'name'
      .name = "sd_emmc_c_nand_clk_div",
       ^~~~
   drivers/mtd/nand/raw/meson_nand.c:968:11: warning: excess elements in struct initializer
      .name = "sd_emmc_c_nand_clk_div",
              ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/mtd/nand/raw/meson_nand.c:968:11: note: (near initialization for '(anonymous)')
   drivers/mtd/nand/raw/meson_nand.c:969:4: error: 'struct clk_init_data' has no member named 'ops'
      .ops = &clk_regmap_divider_ops,
       ^~~
   drivers/mtd/nand/raw/meson_nand.c:969:10: warning: excess elements in struct initializer
      .ops = &clk_regmap_divider_ops,
             ^
   drivers/mtd/nand/raw/meson_nand.c:969:10: note: (near initialization for '(anonymous)')
   drivers/mtd/nand/raw/meson_nand.c:970:4: error: 'struct clk_init_data' has no member named 'parent_names'
      .parent_names = (const char *[]){ "sd_emmc_c_nand_clk_mux" },
       ^~~~~~~~~~~~
   drivers/mtd/nand/raw/meson_nand.c:970:19: warning: excess elements in struct initializer
      .parent_names = (const char *[]){ "sd_emmc_c_nand_clk_mux" },
                      ^
   drivers/mtd/nand/raw/meson_nand.c:970:19: note: (near initialization for '(anonymous)')
   drivers/mtd/nand/raw/meson_nand.c:971:4: error: 'struct clk_init_data' has no member named 'num_parents'
      .num_parents = 1,
       ^~~~~~~~~~~
   drivers/mtd/nand/raw/meson_nand.c:971:18: warning: excess elements in struct initializer
      .num_parents = 1,
                     ^
   drivers/mtd/nand/raw/meson_nand.c:971:18: note: (near initialization for '(anonymous)')
   drivers/mtd/nand/raw/meson_nand.c:972:4: error: 'struct clk_init_data' has no member named 'flags'
      .flags = CLK_SET_RATE_PARENT,
       ^~~~~
   drivers/mtd/nand/raw/meson_nand.c:972:12: warning: excess elements in struct initializer
      .flags = CLK_SET_RATE_PARENT,
               ^~~~~~~~~~~~~~~~~~~
   drivers/mtd/nand/raw/meson_nand.c:972:12: note: (near initialization for '(anonymous)')
   drivers/mtd/nand/raw/meson_nand.c: In function 'meson_nfc_clk_init':
>> drivers/mtd/nand/raw/meson_nand.c:1007:38: error: implicit declaration of function '__clk_get_name'; did you mean 'clk_get_rate'? [-Werror=implicit-function-declaration]
      sd_emmc_ext_clk0_parent_names[i] = __clk_get_name(clk);
                                         ^~~~~~~~~~~~~~
                                         clk_get_rate
>> drivers/mtd/nand/raw/meson_nand.c:1007:36: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
      sd_emmc_ext_clk0_parent_names[i] = __clk_get_name(clk);
                                       ^
>> drivers/mtd/nand/raw/meson_nand.c:1011:8: error: implicit declaration of function 'devm_clk_register'; did you mean 'device_register'? [-Werror=implicit-function-declaration]
     clk = devm_clk_register(nfc->dev, &mux->hw);
           ^~~~~~~~~~~~~~~~~
           device_register
   cc1: some warnings being treated as errors
--
   In file included from drivers/mtd//nand/raw/meson_nand.c:21:0:
>> drivers/clk/meson/clk-regmap.h:22:16: error: field 'hw' has incomplete type
     struct clk_hw hw;
                   ^~
   drivers/mtd//nand/raw/meson_nand.c:951:2: error: field name not in record or union initializer
     .hw.init = &(struct clk_init_data) {
     ^
   drivers/mtd//nand/raw/meson_nand.c:951:2: note: (near initialization for 'sd_emmc_c_ext_clk0_sel')
   drivers/mtd//nand/raw/meson_nand.c:952:4: error: 'struct clk_init_data' has no member named 'name'
      .name = "sd_emmc_c_nand_clk_mux",
       ^~~~
   drivers/mtd//nand/raw/meson_nand.c:952:11: warning: excess elements in struct initializer
      .name = "sd_emmc_c_nand_clk_mux",
              ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/mtd//nand/raw/meson_nand.c:952:11: note: (near initialization for '(anonymous)')
   drivers/mtd//nand/raw/meson_nand.c:953:4: error: 'struct clk_init_data' has no member named 'ops'
      .ops = &clk_regmap_mux_ops,
       ^~~
   drivers/mtd//nand/raw/meson_nand.c:953:10: warning: excess elements in struct initializer
      .ops = &clk_regmap_mux_ops,
             ^
   drivers/mtd//nand/raw/meson_nand.c:953:10: note: (near initialization for '(anonymous)')
   drivers/mtd//nand/raw/meson_nand.c:954:4: error: 'struct clk_init_data' has no member named 'parent_names'
      .parent_names = sd_emmc_ext_clk0_parent_names,
       ^~~~~~~~~~~~
   drivers/mtd//nand/raw/meson_nand.c:954:19: warning: excess elements in struct initializer
      .parent_names = sd_emmc_ext_clk0_parent_names,
                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/mtd//nand/raw/meson_nand.c:954:19: note: (near initialization for '(anonymous)')
   drivers/mtd//nand/raw/meson_nand.c:955:4: error: 'struct clk_init_data' has no member named 'num_parents'
      .num_parents = ARRAY_SIZE(sd_emmc_ext_clk0_parent_names),
       ^~~~~~~~~~~
   In file included from include/linux/list.h:9:0,
                    from include/linux/kobject.h:19,
                    from include/linux/device.h:16,
                    from include/linux/platform_device.h:14,
                    from drivers/mtd//nand/raw/meson_nand.c:9:
>> include/linux/kernel.h:71:25: warning: excess elements in struct initializer
    #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
                            ^
   drivers/mtd//nand/raw/meson_nand.c:955:18: note: in expansion of macro 'ARRAY_SIZE'
      .num_parents = ARRAY_SIZE(sd_emmc_ext_clk0_parent_names),
                     ^~~~~~~~~~
   include/linux/kernel.h:71:25: note: (near initialization for '(anonymous)')
    #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
                            ^
   drivers/mtd//nand/raw/meson_nand.c:955:18: note: in expansion of macro 'ARRAY_SIZE'
      .num_parents = ARRAY_SIZE(sd_emmc_ext_clk0_parent_names),
                     ^~~~~~~~~~
   drivers/mtd//nand/raw/meson_nand.c:956:4: error: 'struct clk_init_data' has no member named 'flags'
      .flags = CLK_SET_RATE_PARENT,
       ^~~~~
   drivers/mtd//nand/raw/meson_nand.c:956:12: error: 'CLK_SET_RATE_PARENT' undeclared here (not in a function); did you mean 'DL_STATE_DORMANT'?
      .flags = CLK_SET_RATE_PARENT,
               ^~~~~~~~~~~~~~~~~~~
               DL_STATE_DORMANT
   drivers/mtd//nand/raw/meson_nand.c:956:12: warning: excess elements in struct initializer
   drivers/mtd//nand/raw/meson_nand.c:956:12: note: (near initialization for '(anonymous)')
   drivers/mtd//nand/raw/meson_nand.c:951:37: error: invalid use of undefined type 'struct clk_init_data'
     .hw.init = &(struct clk_init_data) {
                                        ^
   drivers/mtd//nand/raw/meson_nand.c:965:12: error: 'CLK_DIVIDER_ROUND_CLOSEST' undeclared here (not in a function); did you mean 'DIV_ROUND_CLOSEST'?
      .flags = CLK_DIVIDER_ROUND_CLOSEST | CLK_DIVIDER_ONE_BASED,
               ^~~~~~~~~~~~~~~~~~~~~~~~~
               DIV_ROUND_CLOSEST
   drivers/mtd//nand/raw/meson_nand.c:965:40: error: 'CLK_DIVIDER_ONE_BASED' undeclared here (not in a function); did you mean 'CLK_DIVIDER_ROUND_CLOSEST'?
      .flags = CLK_DIVIDER_ROUND_CLOSEST | CLK_DIVIDER_ONE_BASED,
                                           ^~~~~~~~~~~~~~~~~~~~~
                                           CLK_DIVIDER_ROUND_CLOSEST
   drivers/mtd//nand/raw/meson_nand.c:967:2: error: field name not in record or union initializer
     .hw.init = &(struct clk_init_data) {
     ^
   drivers/mtd//nand/raw/meson_nand.c:967:2: note: (near initialization for 'sd_emmc_c_ext_clk0_div')
   drivers/mtd//nand/raw/meson_nand.c:968:4: error: 'struct clk_init_data' has no member named 'name'
      .name = "sd_emmc_c_nand_clk_div",
       ^~~~
   drivers/mtd//nand/raw/meson_nand.c:968:11: warning: excess elements in struct initializer
      .name = "sd_emmc_c_nand_clk_div",
              ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/mtd//nand/raw/meson_nand.c:968:11: note: (near initialization for '(anonymous)')
   drivers/mtd//nand/raw/meson_nand.c:969:4: error: 'struct clk_init_data' has no member named 'ops'
      .ops = &clk_regmap_divider_ops,
       ^~~
   drivers/mtd//nand/raw/meson_nand.c:969:10: warning: excess elements in struct initializer
      .ops = &clk_regmap_divider_ops,
             ^
   drivers/mtd//nand/raw/meson_nand.c:969:10: note: (near initialization for '(anonymous)')
   drivers/mtd//nand/raw/meson_nand.c:970:4: error: 'struct clk_init_data' has no member named 'parent_names'
      .parent_names = (const char *[]){ "sd_emmc_c_nand_clk_mux" },
       ^~~~~~~~~~~~
   drivers/mtd//nand/raw/meson_nand.c:970:19: warning: excess elements in struct initializer
      .parent_names = (const char *[]){ "sd_emmc_c_nand_clk_mux" },
                      ^
   drivers/mtd//nand/raw/meson_nand.c:970:19: note: (near initialization for '(anonymous)')
   drivers/mtd//nand/raw/meson_nand.c:971:4: error: 'struct clk_init_data' has no member named 'num_parents'
      .num_parents = 1,
       ^~~~~~~~~~~
   drivers/mtd//nand/raw/meson_nand.c:971:18: warning: excess elements in struct initializer
      .num_parents = 1,
                     ^
   drivers/mtd//nand/raw/meson_nand.c:971:18: note: (near initialization for '(anonymous)')
   drivers/mtd//nand/raw/meson_nand.c:972:4: error: 'struct clk_init_data' has no member named 'flags'
      .flags = CLK_SET_RATE_PARENT,
       ^~~~~
   drivers/mtd//nand/raw/meson_nand.c:972:12: warning: excess elements in struct initializer
      .flags = CLK_SET_RATE_PARENT,
               ^~~~~~~~~~~~~~~~~~~
   drivers/mtd//nand/raw/meson_nand.c:972:12: note: (near initialization for '(anonymous)')
   drivers/mtd//nand/raw/meson_nand.c: In function 'meson_nfc_clk_init':
   drivers/mtd//nand/raw/meson_nand.c:1007:38: error: implicit declaration of function '__clk_get_name'; did you mean 'clk_get_rate'? [-Werror=implicit-function-declaration]
      sd_emmc_ext_clk0_parent_names[i] = __clk_get_name(clk);
                                         ^~~~~~~~~~~~~~
                                         clk_get_rate
   drivers/mtd//nand/raw/meson_nand.c:1007:36: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
      sd_emmc_ext_clk0_parent_names[i] = __clk_get_name(clk);
                                       ^
   drivers/mtd//nand/raw/meson_nand.c:1011:8: error: implicit declaration of function 'devm_clk_register'; did you mean 'device_register'? [-Werror=implicit-function-declaration]
     clk = devm_clk_register(nfc->dev, &mux->hw);
           ^~~~~~~~~~~~~~~~~
           device_register
   cc1: some warnings being treated as errors

vim +/hw +22 drivers/clk/meson/clk-regmap.h

ea11dda9 Jerome Brunet 2018-02-12  10  
ea11dda9 Jerome Brunet 2018-02-12  11  /**
ea11dda9 Jerome Brunet 2018-02-12  12   * struct clk_regmap - regmap backed clock
ea11dda9 Jerome Brunet 2018-02-12  13   *
ea11dda9 Jerome Brunet 2018-02-12  14   * @hw:		handle between common and hardware-specific interfaces
ea11dda9 Jerome Brunet 2018-02-12  15   * @map:	pointer to the regmap structure controlling the clock
ea11dda9 Jerome Brunet 2018-02-12  16   * @data:	data specific to the clock type
ea11dda9 Jerome Brunet 2018-02-12  17   *
ea11dda9 Jerome Brunet 2018-02-12  18   * Clock which is controlled by regmap backed registers. The actual type of
ea11dda9 Jerome Brunet 2018-02-12  19   * of the clock is controlled by the clock_ops and data.
ea11dda9 Jerome Brunet 2018-02-12  20   */
ea11dda9 Jerome Brunet 2018-02-12  21  struct clk_regmap {
ea11dda9 Jerome Brunet 2018-02-12 @22  	struct clk_hw	hw;
ea11dda9 Jerome Brunet 2018-02-12  23  	struct regmap	*map;
ea11dda9 Jerome Brunet 2018-02-12  24  	void		*data;
ea11dda9 Jerome Brunet 2018-02-12  25  };
ea11dda9 Jerome Brunet 2018-02-12  26  

:::::: The code at line 22 was first introduced by commit
:::::: ea11dda9e091aba0fe6497108477699286a2d036 clk: meson: add regmap clocks

:::::: TO: Jerome Brunet <jbrunet@baylibre.com>
:::::: CC: Neil Armstrong <narmstrong@baylibre.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 53278 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180613/76026361/attachment-0001.gz>
