From: lkp@intel.com (kbuild test robot)
Date: Thu, 19 Jul 2018 16:01:56 +0800
Subject: [PATCH] pinctrl: uniphier: add spi pin-mux settings
In-Reply-To: <1531981249-26329-1-git-send-email-hayashibara.keiji@socionext.com>
References: <1531981249-26329-1-git-send-email-hayashibara.keiji@socionext.com>
Message-ID: <201807191518.CFD3QbbB%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kunihiko,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on pinctrl/devel]
[also build test WARNING on v4.18-rc5 next-20180718]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Keiji-Hayashibara/pinctrl-uniphier-add-spi-pin-mux-settings/20180719-144943
base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git devel
config: mips-allyesconfig (attached as .config)
compiler: mips-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=mips 

All warnings (new ones prefixed by >>):

   In file included from drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c:21:0:
   drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c:629:27: error: 'spi0_groups' undeclared here (not in a function); did you mean 'spi_groups'?
     UNIPHIER_PINMUX_FUNCTION(spi0),
                              ^
   drivers/pinctrl/uniphier/pinctrl-uniphier.h:188:13: note: in definition of macro 'UNIPHIER_PINMUX_FUNCTION'
      .groups = func##_groups,    \
                ^~~~
   In file included from include/linux/kernel.h:15:0,
                    from drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c:16:
   include/linux/build_bug.h:29:45: error: bit-field '<anonymous>' width not an integer constant
    #define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:(-!!(e)); }))
                                                ^
   include/linux/compiler-gcc.h:65:28: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
    #define __must_be_array(a) BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
                               ^~~~~~~~~~~~~~~~~
   include/linux/kernel.h:72:59: note: in expansion of macro '__must_be_array'
    #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
                                                              ^~~~~~~~~~~~~~~
>> drivers/pinctrl/uniphier/pinctrl-uniphier.h:189:17: note: in expansion of macro 'ARRAY_SIZE'
      .num_groups = ARRAY_SIZE(func##_groups),  \
                    ^~~~~~~~~~
>> drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c:629:2: note: in expansion of macro 'UNIPHIER_PINMUX_FUNCTION'
     UNIPHIER_PINMUX_FUNCTION(spi0),
     ^~~~~~~~~~~~~~~~~~~~~~~~

vim +/UNIPHIER_PINMUX_FUNCTION +629 drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c

   618	
   619	static const struct uniphier_pinmux_function uniphier_sld8_functions[] = {
   620		UNIPHIER_PINMUX_FUNCTION(emmc),
   621		UNIPHIER_PINMUX_FUNCTION(ether_mii),
   622		UNIPHIER_PINMUX_FUNCTION(ether_rmii),
   623		UNIPHIER_PINMUX_FUNCTION(i2c0),
   624		UNIPHIER_PINMUX_FUNCTION(i2c1),
   625		UNIPHIER_PINMUX_FUNCTION(i2c2),
   626		UNIPHIER_PINMUX_FUNCTION(i2c3),
   627		UNIPHIER_PINMUX_FUNCTION(nand),
   628		UNIPHIER_PINMUX_FUNCTION(sd),
 > 629		UNIPHIER_PINMUX_FUNCTION(spi0),
   630		UNIPHIER_PINMUX_FUNCTION(system_bus),
   631		UNIPHIER_PINMUX_FUNCTION(uart0),
   632		UNIPHIER_PINMUX_FUNCTION(uart1),
   633		UNIPHIER_PINMUX_FUNCTION(uart2),
   634		UNIPHIER_PINMUX_FUNCTION(uart3),
   635		UNIPHIER_PINMUX_FUNCTION(usb0),
   636		UNIPHIER_PINMUX_FUNCTION(usb1),
   637		UNIPHIER_PINMUX_FUNCTION(usb2),
   638	};
   639	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 56512 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180719/c843a948/attachment-0001.gz>
