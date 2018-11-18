From: lkp@intel.com (kbuild test robot)
Date: Mon, 19 Nov 2018 01:00:04 +0800
Subject: [PATCH 2/3] soc: imx: gpcv2: Make regmap access table variant
 specific.
In-Reply-To: <20181117181206.10267-3-andrew.smirnov@gmail.com>
References: <20181117181206.10267-3-andrew.smirnov@gmail.com>
Message-ID: <201811190031.DIN4VacD%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrey,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on shawnguo/for-next]
[also build test ERROR on v4.20-rc2 next-20181116]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Andrey-Smirnov/soc-imx-gpcv2-Remove-static-qualifier-from-domain_data/20181118-213909
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git for-next
config: arm-multi_v7_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=arm 

All error/warnings (new ones prefixed by >>):

>> drivers/soc/imx/gpcv2.c:217:17: error: 'yes_ranges' undeclared here (not in a function); did you mean 'imx7_yes_ranges'?
      .yes_ranges = yes_ranges,
                    ^~~~~~~~~~
                    imx7_yes_ranges
   In file included from include/linux/kernel.h:15:0,
                    from include/linux/list.h:9,
                    from include/linux/kobject.h:19,
                    from include/linux/device.h:16,
                    from include/linux/node.h:18,
                    from include/linux/cpu.h:17,
                    from include/linux/of_device.h:5,
                    from drivers/soc/imx/gpcv2.c:11:
   include/linux/build_bug.h:29:45: error: bit-field '<anonymous>' width not an integer constant
    #define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:(-!!(e)); }))
                                                ^
>> include/linux/compiler.h:379:28: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
    #define __must_be_array(a) BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
                               ^~~~~~~~~~~~~~~~~
   include/linux/kernel.h:72:59: note: in expansion of macro '__must_be_array'
    #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
                                                              ^~~~~~~~~~~~~~~
>> drivers/soc/imx/gpcv2.c:218:19: note: in expansion of macro 'ARRAY_SIZE'
      .n_yes_ranges = ARRAY_SIZE(yes_ranges),
                      ^~~~~~~~~~
--
   drivers/soc//imx/gpcv2.c:217:17: error: 'yes_ranges' undeclared here (not in a function); did you mean 'imx7_yes_ranges'?
      .yes_ranges = yes_ranges,
                    ^~~~~~~~~~
                    imx7_yes_ranges
   In file included from include/linux/kernel.h:15:0,
                    from include/linux/list.h:9,
                    from include/linux/kobject.h:19,
                    from include/linux/device.h:16,
                    from include/linux/node.h:18,
                    from include/linux/cpu.h:17,
                    from include/linux/of_device.h:5,
                    from drivers/soc//imx/gpcv2.c:11:
   include/linux/build_bug.h:29:45: error: bit-field '<anonymous>' width not an integer constant
    #define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:(-!!(e)); }))
                                                ^
>> include/linux/compiler.h:379:28: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
    #define __must_be_array(a) BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
                               ^~~~~~~~~~~~~~~~~
   include/linux/kernel.h:72:59: note: in expansion of macro '__must_be_array'
    #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
                                                              ^~~~~~~~~~~~~~~
   drivers/soc//imx/gpcv2.c:218:19: note: in expansion of macro 'ARRAY_SIZE'
      .n_yes_ranges = ARRAY_SIZE(yes_ranges),
                      ^~~~~~~~~~

vim +217 drivers/soc/imx/gpcv2.c

   212	
   213	static const struct imx_pgc_domain_data imx7_pgc_domain_data = {
   214		.domains = imx7_pgc_domains,
   215		.domains_num = ARRAY_SIZE(imx7_pgc_domains),
   216		.access_table = {
 > 217			.yes_ranges	= yes_ranges,
 > 218			.n_yes_ranges	= ARRAY_SIZE(yes_ranges),
   219		},
   220	};
   221	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 44774 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181119/256642d2/attachment-0001.gz>
