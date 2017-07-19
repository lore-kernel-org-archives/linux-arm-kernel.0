From: lkp@intel.com (kbuild test robot)
Date: Wed, 19 Jul 2017 21:25:20 +0800
Subject: [PATCH v2 2/2] pinctrl: sunxi: add support of R40 to A10 pinctrl
 driver
In-Reply-To: <20170718074254.20732-3-icenowy@aosc.io>
Message-ID: <201707192110.5Cu1WZB9%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Icenowy,

[auto build test ERROR on pinctrl/devel]
[also build test ERROR on v4.13-rc1]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Icenowy-Zheng/pinctrl-sunxi-add-a-missing-function-of-A10-A20-pinctrl-driver/20170719-062420
base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git devel
config: arm-sunxi_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> drivers/pinctrl//sunxi/pinctrl-sun4i-a10.c:357:1: error: macro "SUNXI_FUNCTION_VARIANT" requires 3 arguments, but only 2 given
          PINCTRL_SUN8I_R40)),
    ^     ~
   In file included from drivers/pinctrl//sunxi/pinctrl-sun4i-a10.c:19:0:
>> drivers/pinctrl//sunxi/pinctrl-sun4i-a10.c:356:5: error: 'SUNXI_FUNCTION_VARIANT' undeclared here (not in a function)
        SUNXI_FUNCTION_VARIANT(0x4, "pwm" /* PWM5 */
        ^
   drivers/pinctrl//sunxi/pinctrl-sunxi.h:149:4: note: in definition of macro 'SUNXI_PIN'
       __VA_ARGS__, { } },   \
       ^~~~~~~~~~~

vim +/SUNXI_FUNCTION_VARIANT +357 drivers/pinctrl//sunxi/pinctrl-sun4i-a10.c

    20	
    21	static const struct sunxi_desc_pin sun4i_a10_pins[] = {
    22		SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 0),
    23			  SUNXI_FUNCTION(0x0, "gpio_in"),
    24			  SUNXI_FUNCTION(0x1, "gpio_out"),
    25			  SUNXI_FUNCTION(0x2, "emac"),		/* ERXD3 */
    26			  SUNXI_FUNCTION(0x3, "spi1"),		/* CS0 */
    27			  SUNXI_FUNCTION(0x4, "uart2"),		/* RTS */
    28			  SUNXI_FUNCTION_VARIANT(0x5, "gmac",	/* GRXD3 */
    29						 PINCTRL_SUN7I_A20 |
    30						 PINCTRL_SUN8I_R40)),
    31		SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 1),
    32			  SUNXI_FUNCTION(0x0, "gpio_in"),
    33			  SUNXI_FUNCTION(0x1, "gpio_out"),
    34			  SUNXI_FUNCTION(0x2, "emac"),		/* ERXD2 */
    35			  SUNXI_FUNCTION(0x3, "spi1"),		/* CLK */
    36			  SUNXI_FUNCTION(0x4, "uart2"),		/* CTS */
    37			  SUNXI_FUNCTION_VARIANT(0x5, "gmac",	/* GRXD2 */
    38						 PINCTRL_SUN7I_A20 |
    39						 PINCTRL_SUN8I_R40)),
    40		SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 2),
    41			  SUNXI_FUNCTION(0x0, "gpio_in"),
    42			  SUNXI_FUNCTION(0x1, "gpio_out"),
    43			  SUNXI_FUNCTION(0x2, "emac"),		/* ERXD1 */
    44			  SUNXI_FUNCTION(0x3, "spi1"),		/* MOSI */
    45			  SUNXI_FUNCTION(0x4, "uart2"),		/* TX */
    46			  SUNXI_FUNCTION_VARIANT(0x5, "gmac",	/* GRXD1 */
    47						 PINCTRL_SUN7I_A20 |
    48						 PINCTRL_SUN8I_R40)),
    49		SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 3),
    50			  SUNXI_FUNCTION(0x0, "gpio_in"),
    51			  SUNXI_FUNCTION(0x1, "gpio_out"),
    52			  SUNXI_FUNCTION(0x2, "emac"),		/* ERXD0 */
    53			  SUNXI_FUNCTION(0x3, "spi1"),		/* MISO */
    54			  SUNXI_FUNCTION(0x4, "uart2"),		/* RX */
    55			  SUNXI_FUNCTION_VARIANT(0x5, "gmac",	/* GRXD0 */
    56						 PINCTRL_SUN7I_A20 |
    57						 PINCTRL_SUN8I_R40)),
    58		SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 4),
    59			  SUNXI_FUNCTION(0x0, "gpio_in"),
    60			  SUNXI_FUNCTION(0x1, "gpio_out"),
    61			  SUNXI_FUNCTION(0x2, "emac"),		/* ETXD3 */
    62			  SUNXI_FUNCTION(0x3, "spi1"),		/* CS1 */
    63			  SUNXI_FUNCTION_VARIANT(0x5, "gmac",	/* GTXD3 */
    64						 PINCTRL_SUN7I_A20 |
    65						 PINCTRL_SUN8I_R40)),
    66		SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 5),
    67			  SUNXI_FUNCTION(0x0, "gpio_in"),
    68			  SUNXI_FUNCTION(0x1, "gpio_out"),
    69			  SUNXI_FUNCTION(0x2, "emac"),		/* ETXD2 */
    70			  SUNXI_FUNCTION(0x3, "spi3"),		/* CS0 */
    71			  SUNXI_FUNCTION_VARIANT(0x5, "gmac",	/* GTXD2 */
    72						 PINCTRL_SUN7I_A20 |
    73						 PINCTRL_SUN8I_R40)),
    74		SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 6),
    75			  SUNXI_FUNCTION(0x0, "gpio_in"),
    76			  SUNXI_FUNCTION(0x1, "gpio_out"),
    77			  SUNXI_FUNCTION(0x2, "emac"),		/* ETXD1 */
    78			  SUNXI_FUNCTION(0x3, "spi3"),		/* CLK */
    79			  SUNXI_FUNCTION_VARIANT(0x5, "gmac",	/* GTXD1 */
    80						 PINCTRL_SUN7I_A20 |
    81						 PINCTRL_SUN8I_R40)),
    82		SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 7),
    83			  SUNXI_FUNCTION(0x0, "gpio_in"),
    84			  SUNXI_FUNCTION(0x1, "gpio_out"),
    85			  SUNXI_FUNCTION(0x2, "emac"),		/* ETXD0 */
    86			  SUNXI_FUNCTION(0x3, "spi3"),		/* MOSI */
    87			  SUNXI_FUNCTION_VARIANT(0x5, "gmac",	/* GTXD0 */
    88						 PINCTRL_SUN7I_A20 |
    89						 PINCTRL_SUN8I_R40)),
    90		SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 8),
    91			  SUNXI_FUNCTION(0x0, "gpio_in"),
    92			  SUNXI_FUNCTION(0x1, "gpio_out"),
    93			  SUNXI_FUNCTION(0x2, "emac"),		/* ERXCK */
    94			  SUNXI_FUNCTION(0x3, "spi3"),		/* MISO */
    95			  SUNXI_FUNCTION_VARIANT(0x5, "gmac",	/* GRXCK */
    96						 PINCTRL_SUN7I_A20 |
    97						 PINCTRL_SUN8I_R40)),
    98		SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 9),
    99			  SUNXI_FUNCTION(0x0, "gpio_in"),
   100			  SUNXI_FUNCTION(0x1, "gpio_out"),
   101			  SUNXI_FUNCTION(0x2, "emac"),		/* ERXERR */
   102			  SUNXI_FUNCTION(0x3, "spi3"),		/* CS1 */
   103			  SUNXI_FUNCTION_VARIANT(0x5, "gmac",	/* GNULL / ERXERR */
   104						 PINCTRL_SUN7I_A20 |
   105						 PINCTRL_SUN8I_R40),
   106			  SUNXI_FUNCTION_VARIANT(0x6, "i2s1",	/* MCLK */
   107						 PINCTRL_SUN7I_A20 |
   108						 PINCTRL_SUN8I_R40)),
   109		SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 10),
   110			  SUNXI_FUNCTION(0x0, "gpio_in"),
   111			  SUNXI_FUNCTION(0x1, "gpio_out"),
   112			  SUNXI_FUNCTION(0x2, "emac"),		/* ERXDV */
   113			  SUNXI_FUNCTION(0x4, "uart1"),		/* TX */
   114			  SUNXI_FUNCTION_VARIANT(0x5, "gmac",	/* GRXDV */
   115						 PINCTRL_SUN7I_A20 |
   116						 PINCTRL_SUN8I_R40)),
   117		SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 11),
   118			  SUNXI_FUNCTION(0x0, "gpio_in"),
   119			  SUNXI_FUNCTION(0x1, "gpio_out"),
   120			  SUNXI_FUNCTION(0x2, "emac"),		/* EMDC */
   121			  SUNXI_FUNCTION(0x4, "uart1"),		/* RX */
   122			  SUNXI_FUNCTION_VARIANT(0x5, "gmac",	/* EMDC */
   123						 PINCTRL_SUN7I_A20 |
   124						 PINCTRL_SUN8I_R40)),
   125		SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 12),
   126			  SUNXI_FUNCTION(0x0, "gpio_in"),
   127			  SUNXI_FUNCTION(0x1, "gpio_out"),
   128			  SUNXI_FUNCTION(0x2, "emac"),		/* EMDIO */
   129			  SUNXI_FUNCTION(0x3, "uart6"),		/* TX */
   130			  SUNXI_FUNCTION(0x4, "uart1"),		/* RTS */
   131			  SUNXI_FUNCTION_VARIANT(0x5, "gmac",	/* EMDIO */
   132						 PINCTRL_SUN7I_A20 |
   133						 PINCTRL_SUN8I_R40)),
   134		SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 13),
   135			  SUNXI_FUNCTION(0x0, "gpio_in"),
   136			  SUNXI_FUNCTION(0x1, "gpio_out"),
   137			  SUNXI_FUNCTION(0x2, "emac"),		/* ETXEN */
   138			  SUNXI_FUNCTION(0x3, "uart6"),		/* RX */
   139			  SUNXI_FUNCTION(0x4, "uart1"),		/* CTS */
   140			  SUNXI_FUNCTION_VARIANT(0x5, "gmac",	/* GTXCTL / ETXEN */
   141						 PINCTRL_SUN7I_A20 |
   142						 PINCTRL_SUN8I_R40)),
   143		SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 14),
   144			  SUNXI_FUNCTION(0x0, "gpio_in"),
   145			  SUNXI_FUNCTION(0x1, "gpio_out"),
   146			  SUNXI_FUNCTION(0x2, "emac"),		/* ETXCK */
   147			  SUNXI_FUNCTION(0x3, "uart7"),		/* TX */
   148			  SUNXI_FUNCTION(0x4, "uart1"),		/* DTR */
   149			  SUNXI_FUNCTION_VARIANT(0x5, "gmac",	/* GNULL / ETXCK */
   150						 PINCTRL_SUN7I_A20 |
   151						 PINCTRL_SUN8I_R40),
   152			  SUNXI_FUNCTION_VARIANT(0x6, "i2s1",	/* BCLK */
   153						 PINCTRL_SUN7I_A20 |
   154						 PINCTRL_SUN8I_R40)),
   155		SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 15),
   156			  SUNXI_FUNCTION(0x0, "gpio_in"),
   157			  SUNXI_FUNCTION(0x1, "gpio_out"),
   158			  SUNXI_FUNCTION(0x2, "emac"),		/* ECRS */
   159			  SUNXI_FUNCTION(0x3, "uart7"),		/* RX */
   160			  SUNXI_FUNCTION(0x4, "uart1"),		/* DSR */
   161			  SUNXI_FUNCTION_VARIANT(0x5, "gmac",	/* GTXCK / ECRS */
   162						 PINCTRL_SUN7I_A20 |
   163						 PINCTRL_SUN8I_R40),
   164			  SUNXI_FUNCTION_VARIANT(0x6, "i2s1",	/* LRCK */
   165						 PINCTRL_SUN7I_A20 |
   166						 PINCTRL_SUN8I_R40)),
   167		SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 16),
   168			  SUNXI_FUNCTION(0x0, "gpio_in"),
   169			  SUNXI_FUNCTION(0x1, "gpio_out"),
   170			  SUNXI_FUNCTION(0x2, "emac"),		/* ECOL */
   171			  SUNXI_FUNCTION(0x3, "can"),		/* TX */
   172			  SUNXI_FUNCTION(0x4, "uart1"),		/* DCD */
   173			  SUNXI_FUNCTION_VARIANT(0x5, "gmac",	/* GCLKIN / ECOL */
   174						 PINCTRL_SUN7I_A20 |
   175						 PINCTRL_SUN8I_R40),
   176			  SUNXI_FUNCTION_VARIANT(0x6, "i2s1",	/* DO */
   177						 PINCTRL_SUN7I_A20 |
   178						 PINCTRL_SUN8I_R40)),
   179		SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 17),
   180			  SUNXI_FUNCTION(0x0, "gpio_in"),
   181			  SUNXI_FUNCTION(0x1, "gpio_out"),
   182			  SUNXI_FUNCTION(0x2, "emac"),		/* ETXERR */
   183			  SUNXI_FUNCTION(0x3, "can"),		/* RX */
   184			  SUNXI_FUNCTION(0x4, "uart1"),		/* RING */
   185			  SUNXI_FUNCTION_VARIANT(0x5, "gmac",	/* GNULL / ETXERR */
   186						 PINCTRL_SUN7I_A20 |
   187						 PINCTRL_SUN8I_R40),
   188			  SUNXI_FUNCTION_VARIANT(0x6, "i2s1",	/* DI */
   189						 PINCTRL_SUN7I_A20 |
   190						 PINCTRL_SUN8I_R40)),
   191		/* Hole */
   192		SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 0),
   193			  SUNXI_FUNCTION(0x0, "gpio_in"),
   194			  SUNXI_FUNCTION(0x1, "gpio_out"),
   195			  SUNXI_FUNCTION(0x2, "i2c0"),		/* SCK */
   196			  SUNXI_FUNCTION_VARIANT(0x3, "pll_lock_dbg",
   197						 PINCTRL_SUN8I_R40)),
   198		SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 1),
   199			  SUNXI_FUNCTION(0x0, "gpio_in"),
   200			  SUNXI_FUNCTION(0x1, "gpio_out"),
   201			  SUNXI_FUNCTION(0x2, "i2c0")),		/* SDA */
   202		SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 2),
   203			  SUNXI_FUNCTION(0x0, "gpio_in"),
   204			  SUNXI_FUNCTION(0x1, "gpio_out"),
   205			  SUNXI_FUNCTION_VARIANT(0x2, "pwm",	/* PWM0 */
   206						 PINCTRL_SUN4I_A10 |
   207						 PINCTRL_SUN7I_A20),
   208			  SUNXI_FUNCTION_VARIANT(0x3, "pwm",	/* PWM0 */
   209						 PINCTRL_SUN8I_R40)),
   210		SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 3),
   211			  SUNXI_FUNCTION(0x0, "gpio_in"),
   212			  SUNXI_FUNCTION(0x1, "gpio_out"),
   213			  SUNXI_FUNCTION_VARIANT(0x2, "ir0",	/* TX */
   214						 PINCTRL_SUN4I_A10 |
   215						 PINCTRL_SUN7I_A20),
   216			  SUNXI_FUNCTION_VARIANT(0x3, "pwm",	/* PWM1 */
   217						 PINCTRL_SUN8I_R40),
   218			/*
   219			 * The SPDIF block is not referenced at all in the A10 user
   220			 * manual. However it is described in the code leaked and the
   221			 * pin descriptions are declared in the A20 user manual which
   222			 * is pin compatible with this device.
   223			 */
   224			  SUNXI_FUNCTION(0x4, "spdif")),        /* SPDIF MCLK */
   225		SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 4),
   226			  SUNXI_FUNCTION(0x0, "gpio_in"),
   227			  SUNXI_FUNCTION(0x1, "gpio_out"),
   228			  SUNXI_FUNCTION(0x2, "ir0")),		/* RX */
   229		SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 5),
   230			  SUNXI_FUNCTION(0x0, "gpio_in"),
   231			  SUNXI_FUNCTION(0x1, "gpio_out"),
   232			  /*
   233			   * On A10 there's only one I2S controller and the pin group
   234			   * is simply named "i2s". On A20 there's two and thus it's
   235			   * renamed to "i2s0". Deal with these name here, in order
   236			   * to satisfy existing device trees.
   237			   */
   238			  SUNXI_FUNCTION_VARIANT(0x2, "i2s",	/* MCLK */
   239						 PINCTRL_SUN4I_A10),
   240			  SUNXI_FUNCTION_VARIANT(0x2, "i2s0",	/* MCLK */
   241						 PINCTRL_SUN7I_A20 |
   242						 PINCTRL_SUN8I_R40),
   243			  SUNXI_FUNCTION(0x3, "ac97")),		/* MCLK */
   244		SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 6),
   245			  SUNXI_FUNCTION(0x0, "gpio_in"),
   246			  SUNXI_FUNCTION(0x1, "gpio_out"),
   247			  SUNXI_FUNCTION_VARIANT(0x2, "i2s",	/* BCLK */
   248						 PINCTRL_SUN4I_A10),
   249			  SUNXI_FUNCTION_VARIANT(0x2, "i2s0",	/* BCLK */
   250						 PINCTRL_SUN7I_A20 |
   251						 PINCTRL_SUN8I_R40),
   252			  SUNXI_FUNCTION(0x3, "ac97")),		/* BCLK */
   253		SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 7),
   254			  SUNXI_FUNCTION(0x0, "gpio_in"),
   255			  SUNXI_FUNCTION(0x1, "gpio_out"),
   256			  SUNXI_FUNCTION_VARIANT(0x2, "i2s",	/* LRCK */
   257						 PINCTRL_SUN4I_A10),
   258			  SUNXI_FUNCTION_VARIANT(0x2, "i2s0",	/* LRCK */
   259						 PINCTRL_SUN7I_A20 |
   260						 PINCTRL_SUN8I_R40),
   261			  SUNXI_FUNCTION(0x3, "ac97")),		/* SYNC */
   262		SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 8),
   263			  SUNXI_FUNCTION(0x0, "gpio_in"),
   264			  SUNXI_FUNCTION(0x1, "gpio_out"),
   265			  SUNXI_FUNCTION_VARIANT(0x2, "i2s",	/* DO0 */
   266						 PINCTRL_SUN4I_A10),
   267			  SUNXI_FUNCTION_VARIANT(0x2, "i2s0",	/* DO0 */
   268						 PINCTRL_SUN7I_A20 |
   269						 PINCTRL_SUN8I_R40),
   270			  SUNXI_FUNCTION(0x3, "ac97")),		/* DO */
   271		SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 9),
   272			  SUNXI_FUNCTION(0x0, "gpio_in"),
   273			  SUNXI_FUNCTION(0x1, "gpio_out"),
   274			  SUNXI_FUNCTION_VARIANT(0x2, "i2s",	/* DO1 */
   275						 PINCTRL_SUN4I_A10),
   276			  SUNXI_FUNCTION_VARIANT(0x2, "i2s0",	/* DO1 */
   277						 PINCTRL_SUN7I_A20 |
   278						 PINCTRL_SUN8I_R40),
   279			  SUNXI_FUNCTION_VARIANT(0x4, "pwm",	/* PWM6 */
   280						 PINCTRL_SUN8I_R40)),
   281		SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 10),
   282			  SUNXI_FUNCTION(0x0, "gpio_in"),
   283			  SUNXI_FUNCTION(0x1, "gpio_out"),
   284			  SUNXI_FUNCTION_VARIANT(0x2, "i2s",	/* DO2 */
   285						 PINCTRL_SUN4I_A10),
   286			  SUNXI_FUNCTION_VARIANT(0x2, "i2s0",	/* DO2 */
   287						 PINCTRL_SUN7I_A20 |
   288						 PINCTRL_SUN8I_R40),
   289			  SUNXI_FUNCTION_VARIANT(0x4, "pwm",	/* PWM7 */
   290						 PINCTRL_SUN8I_R40)),
   291		SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 11),
   292			  SUNXI_FUNCTION(0x0, "gpio_in"),
   293			  SUNXI_FUNCTION(0x1, "gpio_out"),
   294			  SUNXI_FUNCTION_VARIANT(0x2, "i2s",	/* DO3 */
   295						 PINCTRL_SUN4I_A10),
   296			  SUNXI_FUNCTION_VARIANT(0x2, "i2s0",	/* DO3 */
   297						 PINCTRL_SUN7I_A20 |
   298						 PINCTRL_SUN8I_R40)),
   299		SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 12),
   300			  SUNXI_FUNCTION(0x0, "gpio_in"),
   301			  SUNXI_FUNCTION(0x1, "gpio_out"),
   302			  SUNXI_FUNCTION_VARIANT(0x2, "i2s",	/* DI */
   303						 PINCTRL_SUN4I_A10),
   304			  SUNXI_FUNCTION_VARIANT(0x2, "i2s0",	/* DI */
   305						 PINCTRL_SUN7I_A20 |
   306						 PINCTRL_SUN8I_R40),
   307			  SUNXI_FUNCTION(0x3, "ac97"),		/* DI */
   308			/* Undocumented mux function on A10 - See SPDIF MCLK above */
   309			  SUNXI_FUNCTION_VARIANT(0x4, "spdif",	/* SPDIF IN */
   310						 PINCTRL_SUN4I_A10 |
   311						 PINCTRL_SUN7I_A20)),
   312		SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 13),
   313			  SUNXI_FUNCTION(0x0, "gpio_in"),
   314			  SUNXI_FUNCTION(0x1, "gpio_out"),
   315			  SUNXI_FUNCTION(0x2, "spi2"),		/* CS1 */
   316			/* Undocumented mux function on A10 - See SPDIF MCLK above */
   317			  SUNXI_FUNCTION(0x4, "spdif")),        /* SPDIF OUT */
   318		SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 14),
   319			  SUNXI_FUNCTION(0x0, "gpio_in"),
   320			  SUNXI_FUNCTION(0x1, "gpio_out"),
   321			  SUNXI_FUNCTION(0x2, "spi2"),		/* CS0 */
   322			  SUNXI_FUNCTION(0x3, "jtag")),		/* MS0 */
   323		SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 15),
   324			  SUNXI_FUNCTION(0x0, "gpio_in"),
   325			  SUNXI_FUNCTION(0x1, "gpio_out"),
   326			  SUNXI_FUNCTION(0x2, "spi2"),		/* CLK */
   327			  SUNXI_FUNCTION(0x3, "jtag")),		/* CK0 */
   328		SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 16),
   329			  SUNXI_FUNCTION(0x0, "gpio_in"),
   330			  SUNXI_FUNCTION(0x1, "gpio_out"),
   331			  SUNXI_FUNCTION(0x2, "spi2"),		/* MOSI */
   332			  SUNXI_FUNCTION(0x3, "jtag")),		/* DO0 */
   333		SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 17),
   334			  SUNXI_FUNCTION(0x0, "gpio_in"),
   335			  SUNXI_FUNCTION(0x1, "gpio_out"),
   336			  SUNXI_FUNCTION(0x2, "spi2"),		/* MISO */
   337			  SUNXI_FUNCTION(0x3, "jtag")),		/* DI0 */
   338		SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 18),
   339			  SUNXI_FUNCTION(0x0, "gpio_in"),
   340			  SUNXI_FUNCTION(0x1, "gpio_out"),
   341			  SUNXI_FUNCTION(0x2, "i2c1")),		/* SCK */
   342		SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 19),
   343			  SUNXI_FUNCTION(0x0, "gpio_in"),
   344			  SUNXI_FUNCTION(0x1, "gpio_out"),
   345			  SUNXI_FUNCTION(0x2, "i2c1")),		/* SDA */
   346		SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 20),
   347			  SUNXI_FUNCTION(0x0, "gpio_in"),
   348			  SUNXI_FUNCTION(0x1, "gpio_out"),
   349			  SUNXI_FUNCTION(0x2, "i2c2"),		/* SCK */
   350			  SUNXI_FUNCTION_VARIANT(0x4, "pwm",	/* PWM4 */
   351						 PINCTRL_SUN8I_R40)),
   352		SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 21),
   353			  SUNXI_FUNCTION(0x0, "gpio_in"),
   354			  SUNXI_FUNCTION(0x1, "gpio_out"),
   355			  SUNXI_FUNCTION(0x2, "i2c2"),		/* SDA */
 > 356			  SUNXI_FUNCTION_VARIANT(0x4, "pwm"	/* PWM5 */
 > 357						 PINCTRL_SUN8I_R40)),
   358		SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 22),
   359			  SUNXI_FUNCTION(0x0, "gpio_in"),
   360			  SUNXI_FUNCTION(0x1, "gpio_out"),
   361			  SUNXI_FUNCTION(0x2, "uart0"),		/* TX */
   362			  SUNXI_FUNCTION_VARIANT(0x3, "ir1",	/* TX */
   363						 PINCTRL_SUN4I_A10 |
   364						 PINCTRL_SUN7I_A20)),
   365		SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 23),
   366			  SUNXI_FUNCTION(0x0, "gpio_in"),
   367			  SUNXI_FUNCTION(0x1, "gpio_out"),
   368			  SUNXI_FUNCTION(0x2, "uart0"),		/* RX */
   369			  SUNXI_FUNCTION(0x3, "ir1")),		/* RX */
   370		/* Hole */
   371		SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 0),
   372			  SUNXI_FUNCTION(0x0, "gpio_in"),
   373			  SUNXI_FUNCTION(0x1, "gpio_out"),
   374			  SUNXI_FUNCTION(0x2, "nand0"),		/* NWE */
   375			  SUNXI_FUNCTION(0x3, "spi0")),		/* MOSI */
   376		SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 1),
   377			  SUNXI_FUNCTION(0x0, "gpio_in"),
   378			  SUNXI_FUNCTION(0x1, "gpio_out"),
   379			  SUNXI_FUNCTION(0x2, "nand0"),		/* NALE */
   380			  SUNXI_FUNCTION(0x3, "spi0")),		/* MISO */
   381		SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 2),
   382			  SUNXI_FUNCTION(0x0, "gpio_in"),
   383			  SUNXI_FUNCTION(0x1, "gpio_out"),
   384			  SUNXI_FUNCTION(0x2, "nand0"),		/* NCLE */
   385			  SUNXI_FUNCTION(0x3, "spi0")),		/* SCK */
   386		SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 3),
   387			  SUNXI_FUNCTION(0x0, "gpio_in"),
   388			  SUNXI_FUNCTION(0x1, "gpio_out"),
   389			  SUNXI_FUNCTION(0x2, "nand0")),	/* NCE1 */
   390		SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 4),
   391			  SUNXI_FUNCTION(0x0, "gpio_in"),
   392			  SUNXI_FUNCTION(0x1, "gpio_out"),
   393			  SUNXI_FUNCTION(0x2, "nand0")),	/* NCE0 */
   394		SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 5),
   395			  SUNXI_FUNCTION(0x0, "gpio_in"),
   396			  SUNXI_FUNCTION(0x1, "gpio_out"),
   397			  SUNXI_FUNCTION(0x2, "nand0"),		/* NRE# */
   398			  SUNXI_FUNCTION_VARIANT(0x3, "mmc2",	/* DS */
   399						 PINCTRL_SUN8I_R40)),
   400		SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 6),
   401			  SUNXI_FUNCTION(0x0, "gpio_in"),
   402			  SUNXI_FUNCTION(0x1, "gpio_out"),
   403			  SUNXI_FUNCTION(0x2, "nand0"),		/* NRB0 */
   404			  SUNXI_FUNCTION(0x3, "mmc2")),		/* CMD */
   405		SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 7),
   406			  SUNXI_FUNCTION(0x0, "gpio_in"),
   407			  SUNXI_FUNCTION(0x1, "gpio_out"),
   408			  SUNXI_FUNCTION(0x2, "nand0"),		/* NRB1 */
   409			  SUNXI_FUNCTION(0x3, "mmc2")),		/* CLK */
   410		SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 8),
   411			  SUNXI_FUNCTION(0x0, "gpio_in"),
   412			  SUNXI_FUNCTION(0x1, "gpio_out"),
   413			  SUNXI_FUNCTION(0x2, "nand0"),		/* NDQ0 */
   414			  SUNXI_FUNCTION(0x3, "mmc2")),		/* D0 */
   415		SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 9),
   416			  SUNXI_FUNCTION(0x0, "gpio_in"),
   417			  SUNXI_FUNCTION(0x1, "gpio_out"),
   418			  SUNXI_FUNCTION(0x2, "nand0"),		/* NDQ1 */
   419			  SUNXI_FUNCTION(0x3, "mmc2")),		/* D1 */
   420		SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 10),
   421			  SUNXI_FUNCTION(0x0, "gpio_in"),
   422			  SUNXI_FUNCTION(0x1, "gpio_out"),
   423			  SUNXI_FUNCTION(0x2, "nand0"),		/* NDQ2 */
   424			  SUNXI_FUNCTION(0x3, "mmc2")),		/* D2 */
   425		SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 11),
   426			  SUNXI_FUNCTION(0x0, "gpio_in"),
   427			  SUNXI_FUNCTION(0x1, "gpio_out"),
   428			  SUNXI_FUNCTION(0x2, "nand0"),		/* NDQ3 */
   429			  SUNXI_FUNCTION(0x3, "mmc2")),		/* D3 */
   430		SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 12),
   431			  SUNXI_FUNCTION(0x0, "gpio_in"),
   432			  SUNXI_FUNCTION(0x1, "gpio_out"),
   433			  SUNXI_FUNCTION(0x2, "nand0"),		/* NDQ4 */
   434			  SUNXI_FUNCTION_VARIANT(0x3, "mmc2",	/* D4 */
   435						 PINCTRL_SUN8I_R40)),
   436		SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 13),
   437			  SUNXI_FUNCTION(0x0, "gpio_in"),
   438			  SUNXI_FUNCTION(0x1, "gpio_out"),
   439			  SUNXI_FUNCTION(0x2, "nand0"),		/* NDQ5 */
   440			  SUNXI_FUNCTION_VARIANT(0x3, "mmc2",	/* D5 */
   441						 PINCTRL_SUN8I_R40)),
   442		SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 14),
   443			  SUNXI_FUNCTION(0x0, "gpio_in"),
   444			  SUNXI_FUNCTION(0x1, "gpio_out"),
   445			  SUNXI_FUNCTION(0x2, "nand0"),		/* NDQ6 */
   446			  SUNXI_FUNCTION_VARIANT(0x3, "mmc2",	/* D6 */
   447						 PINCTRL_SUN8I_R40)),
   448		SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 15),
   449			  SUNXI_FUNCTION(0x0, "gpio_in"),
   450			  SUNXI_FUNCTION(0x1, "gpio_out"),
   451			  SUNXI_FUNCTION(0x2, "nand0"),		/* NDQ7 */
   452			  SUNXI_FUNCTION_VARIANT(0x3, "mmc2",	/* D7 */
   453						 PINCTRL_SUN8I_R40)),
   454		SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 16),
   455			  SUNXI_FUNCTION(0x0, "gpio_in"),
   456			  SUNXI_FUNCTION(0x1, "gpio_out"),
   457			  SUNXI_FUNCTION(0x2, "nand0")),	/* NWP */
   458		SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 17),
   459			  SUNXI_FUNCTION(0x0, "gpio_in"),
   460			  SUNXI_FUNCTION(0x1, "gpio_out"),
   461			  SUNXI_FUNCTION(0x2, "nand0")),	/* NCE2 */
   462		SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 18),
   463			  SUNXI_FUNCTION(0x0, "gpio_in"),
   464			  SUNXI_FUNCTION(0x1, "gpio_out"),
   465			  SUNXI_FUNCTION(0x2, "nand0")),	/* NCE3 */
   466		SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 19),
   467			  SUNXI_FUNCTION(0x0, "gpio_in"),
   468			  SUNXI_FUNCTION(0x1, "gpio_out"),
   469			  SUNXI_FUNCTION(0x2, "nand0"),		/* NCE4 */
   470			  SUNXI_FUNCTION(0x3, "spi2")),		/* CS0 */
   471		SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 20),
   472			  SUNXI_FUNCTION(0x0, "gpio_in"),
   473			  SUNXI_FUNCTION(0x1, "gpio_out"),
   474			  SUNXI_FUNCTION(0x2, "nand0"),		/* NCE5 */
   475			  SUNXI_FUNCTION(0x3, "spi2")),		/* CLK */
   476		SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 21),
   477			  SUNXI_FUNCTION(0x0, "gpio_in"),
   478			  SUNXI_FUNCTION(0x1, "gpio_out"),
   479			  SUNXI_FUNCTION(0x2, "nand0"),		/* NCE6 */
   480			  SUNXI_FUNCTION(0x3, "spi2")),		/* MOSI */
   481		SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 22),
   482			  SUNXI_FUNCTION(0x0, "gpio_in"),
   483			  SUNXI_FUNCTION(0x1, "gpio_out"),
   484			  SUNXI_FUNCTION(0x2, "nand0"),		/* NCE7 */
   485			  SUNXI_FUNCTION(0x3, "spi2")),		/* MISO */
   486		SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 23),
   487			  SUNXI_FUNCTION(0x0, "gpio_in"),
   488			  SUNXI_FUNCTION(0x1, "gpio_out"),
   489			  SUNXI_FUNCTION(0x3, "spi0")),		/* CS0 */
   490		SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 24),
   491			  SUNXI_FUNCTION(0x0, "gpio_in"),
   492			  SUNXI_FUNCTION(0x1, "gpio_out"),
   493			  SUNXI_FUNCTION(0x2, "nand0"),		/* NDQS */
   494			  SUNXI_FUNCTION_VARIANT(0x3, "mmc2",	/* RST */
   495						 PINCTRL_SUN8I_R40)),
   496		/* Hole */
   497		SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 0),
   498			  SUNXI_FUNCTION(0x0, "gpio_in"),
   499			  SUNXI_FUNCTION(0x1, "gpio_out"),
   500			  SUNXI_FUNCTION(0x2, "lcd0"),		/* D0 */
   501			  SUNXI_FUNCTION(0x3, "lvds0")),	/* VP0 */
   502		SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 1),
   503			  SUNXI_FUNCTION(0x0, "gpio_in"),
   504			  SUNXI_FUNCTION(0x1, "gpio_out"),
   505			  SUNXI_FUNCTION(0x2, "lcd0"),		/* D1 */
   506			  SUNXI_FUNCTION(0x3, "lvds0")),	/* VN0 */
   507		SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 2),
   508			  SUNXI_FUNCTION(0x0, "gpio_in"),
   509			  SUNXI_FUNCTION(0x1, "gpio_out"),
   510			  SUNXI_FUNCTION(0x2, "lcd0"),		/* D2 */
   511			  SUNXI_FUNCTION(0x3, "lvds0")),	/* VP1 */
   512		SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 3),
   513			  SUNXI_FUNCTION(0x0, "gpio_in"),
   514			  SUNXI_FUNCTION(0x1, "gpio_out"),
   515			  SUNXI_FUNCTION(0x2, "lcd0"),		/* D3 */
   516			  SUNXI_FUNCTION(0x3, "lvds0")),	/* VN1 */
   517		SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 4),
   518			  SUNXI_FUNCTION(0x0, "gpio_in"),
   519			  SUNXI_FUNCTION(0x1, "gpio_out"),
   520			  SUNXI_FUNCTION(0x2, "lcd0"),		/* D4 */
   521			  SUNXI_FUNCTION(0x3, "lvds0")),	/* VP2 */
   522		SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 5),
   523			  SUNXI_FUNCTION(0x0, "gpio_in"),
   524			  SUNXI_FUNCTION(0x1, "gpio_out"),
   525			  SUNXI_FUNCTION(0x2, "lcd0"),		/* D5 */
   526			  SUNXI_FUNCTION(0x3, "lvds0")),	/* VN2 */
   527		SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 6),
   528			  SUNXI_FUNCTION(0x0, "gpio_in"),
   529			  SUNXI_FUNCTION(0x1, "gpio_out"),
   530			  SUNXI_FUNCTION(0x2, "lcd0"),		/* D6 */
   531			  SUNXI_FUNCTION(0x3, "lvds0")),	/* VPC */
   532		SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 7),
   533			  SUNXI_FUNCTION(0x0, "gpio_in"),
   534			  SUNXI_FUNCTION(0x1, "gpio_out"),
   535			  SUNXI_FUNCTION(0x2, "lcd0"),		/* D7 */
   536			  SUNXI_FUNCTION(0x3, "lvds0")),	/* VNC */
   537		SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 8),
   538			  SUNXI_FUNCTION(0x0, "gpio_in"),
   539			  SUNXI_FUNCTION(0x1, "gpio_out"),
   540			  SUNXI_FUNCTION(0x2, "lcd0"),		/* D8 */
   541			  SUNXI_FUNCTION(0x3, "lvds0")),	/* VP3 */
   542		SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 9),
   543			  SUNXI_FUNCTION(0x0, "gpio_in"),
   544			  SUNXI_FUNCTION(0x1, "gpio_out"),
   545			  SUNXI_FUNCTION(0x2, "lcd0"),		/* D9 */
   546			  SUNXI_FUNCTION(0x3, "lvds0")),	/* VM3 */
   547		SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 10),
   548			  SUNXI_FUNCTION(0x0, "gpio_in"),
   549			  SUNXI_FUNCTION(0x1, "gpio_out"),
   550			  SUNXI_FUNCTION(0x2, "lcd0"),		/* D10 */
   551			  SUNXI_FUNCTION(0x3, "lvds1")),	/* VP0 */
   552		SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 11),
   553			  SUNXI_FUNCTION(0x0, "gpio_in"),
   554			  SUNXI_FUNCTION(0x1, "gpio_out"),
   555			  SUNXI_FUNCTION(0x2, "lcd0"),		/* D11 */
   556			  SUNXI_FUNCTION(0x3, "lvds1")),	/* VN0 */
   557		SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 12),
   558			  SUNXI_FUNCTION(0x0, "gpio_in"),
   559			  SUNXI_FUNCTION(0x1, "gpio_out"),
   560			  SUNXI_FUNCTION(0x2, "lcd0"),		/* D12 */
   561			  SUNXI_FUNCTION(0x3, "lvds1")),	/* VP1 */
   562		SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 13),
   563			  SUNXI_FUNCTION(0x0, "gpio_in"),
   564			  SUNXI_FUNCTION(0x1, "gpio_out"),
   565			  SUNXI_FUNCTION(0x2, "lcd0"),		/* D13 */
   566			  SUNXI_FUNCTION(0x3, "lvds1")),	/* VN1 */
   567		SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 14),
   568			  SUNXI_FUNCTION(0x0, "gpio_in"),
   569			  SUNXI_FUNCTION(0x1, "gpio_out"),
   570			  SUNXI_FUNCTION(0x2, "lcd0"),		/* D14 */
   571			  SUNXI_FUNCTION(0x3, "lvds1")),	/* VP2 */
   572		SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 15),
   573			  SUNXI_FUNCTION(0x0, "gpio_in"),
   574			  SUNXI_FUNCTION(0x1, "gpio_out"),
   575			  SUNXI_FUNCTION(0x2, "lcd0"),		/* D15 */
   576			  SUNXI_FUNCTION(0x3, "lvds1")),	/* VN2 */
   577		SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 16),
   578			  SUNXI_FUNCTION(0x0, "gpio_in"),
   579			  SUNXI_FUNCTION(0x1, "gpio_out"),
   580			  SUNXI_FUNCTION(0x2, "lcd0"),		/* D16 */
   581			  SUNXI_FUNCTION(0x3, "lvds1")),	/* VPC */
   582		SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 17),
   583			  SUNXI_FUNCTION(0x0, "gpio_in"),
   584			  SUNXI_FUNCTION(0x1, "gpio_out"),
   585			  SUNXI_FUNCTION(0x2, "lcd0"),		/* D17 */
   586			  SUNXI_FUNCTION(0x3, "lvds1")),	/* VNC */
   587		SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 18),
   588			  SUNXI_FUNCTION(0x0, "gpio_in"),
   589			  SUNXI_FUNCTION(0x1, "gpio_out"),
   590			  SUNXI_FUNCTION(0x2, "lcd0"),		/* D18 */
   591			  SUNXI_FUNCTION(0x3, "lvds1")),	/* VP3 */
   592		SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 19),
   593			  SUNXI_FUNCTION(0x0, "gpio_in"),
   594			  SUNXI_FUNCTION(0x1, "gpio_out"),
   595			  SUNXI_FUNCTION(0x2, "lcd0"),		/* D19 */
   596			  SUNXI_FUNCTION(0x3, "lvds1")),	/* VN3 */
   597		SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 20),
   598			  SUNXI_FUNCTION(0x0, "gpio_in"),
   599			  SUNXI_FUNCTION(0x1, "gpio_out"),
   600			  SUNXI_FUNCTION(0x2, "lcd0"),		/* D20 */
   601			  SUNXI_FUNCTION(0x3, "csi1")),		/* MCLK */
   602		SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 21),
   603			  SUNXI_FUNCTION(0x0, "gpio_in"),
   604			  SUNXI_FUNCTION(0x1, "gpio_out"),
   605			  SUNXI_FUNCTION(0x2, "lcd0"),		/* D21 */
   606			  SUNXI_FUNCTION(0x3, "sim")),		/* VPPEN */
   607		SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 22),
   608			  SUNXI_FUNCTION(0x0, "gpio_in"),
   609			  SUNXI_FUNCTION(0x1, "gpio_out"),
   610			  SUNXI_FUNCTION(0x2, "lcd0"),		/* D22 */
   611			  SUNXI_FUNCTION(0x3, "sim")),		/* VPPPP */
   612		SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 23),
   613			  SUNXI_FUNCTION(0x0, "gpio_in"),
   614			  SUNXI_FUNCTION(0x1, "gpio_out"),
   615			  SUNXI_FUNCTION(0x2, "lcd0"),		/* D23 */
   616			  SUNXI_FUNCTION(0x3, "sim")),		/* DET */
   617		SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 24),
   618			  SUNXI_FUNCTION(0x0, "gpio_in"),
   619			  SUNXI_FUNCTION(0x1, "gpio_out"),
   620			  SUNXI_FUNCTION(0x2, "lcd0"),		/* CLK */
   621			  SUNXI_FUNCTION(0x3, "sim")),		/* VCCEN */
   622		SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 25),
   623			  SUNXI_FUNCTION(0x0, "gpio_in"),
   624			  SUNXI_FUNCTION(0x1, "gpio_out"),
   625			  SUNXI_FUNCTION(0x2, "lcd0"),		/* DE */
   626			  SUNXI_FUNCTION(0x3, "sim")),		/* RST */
   627		SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 26),
   628			  SUNXI_FUNCTION(0x0, "gpio_in"),
   629			  SUNXI_FUNCTION(0x1, "gpio_out"),
   630			  SUNXI_FUNCTION(0x2, "lcd0"),		/* HSYNC */
   631			  SUNXI_FUNCTION(0x3, "sim")),		/* SCK */
   632		SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 27),
   633			  SUNXI_FUNCTION(0x0, "gpio_in"),
   634			  SUNXI_FUNCTION(0x1, "gpio_out"),
   635			  SUNXI_FUNCTION(0x2, "lcd0"),		/* VSYNC */
   636			  SUNXI_FUNCTION(0x3, "sim")),		/* SDA */
   637		/* Hole */
   638		SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 0),
   639			  SUNXI_FUNCTION(0x0, "gpio_in"),
   640			  SUNXI_FUNCTION(0x1, "gpio_out"),
   641			  SUNXI_FUNCTION(0x2, "ts0"),		/* CLK */
   642			  SUNXI_FUNCTION(0x3, "csi0")),		/* PCK */
   643		SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 1),
   644			  SUNXI_FUNCTION(0x0, "gpio_in"),
   645			  SUNXI_FUNCTION(0x1, "gpio_out"),
   646			  SUNXI_FUNCTION(0x2, "ts0"),		/* ERR */
   647			  SUNXI_FUNCTION(0x3, "csi0")),		/* CK */
   648		SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 2),
   649			  SUNXI_FUNCTION(0x0, "gpio_in"),
   650			  SUNXI_FUNCTION(0x1, "gpio_out"),
   651			  SUNXI_FUNCTION(0x2, "ts0"),		/* SYNC */
   652			  SUNXI_FUNCTION(0x3, "csi0")),		/* HSYNC */
   653		SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 3),
   654			  SUNXI_FUNCTION(0x0, "gpio_in"),
   655			  SUNXI_FUNCTION(0x1, "gpio_out"),
   656			  SUNXI_FUNCTION(0x2, "ts0"),		/* DVLD */
   657			  SUNXI_FUNCTION(0x3, "csi0")),		/* VSYNC */
   658		SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 4),
   659			  SUNXI_FUNCTION(0x0, "gpio_in"),
   660			  SUNXI_FUNCTION(0x1, "gpio_out"),
   661			  SUNXI_FUNCTION(0x2, "ts0"),		/* D0 */
   662			  SUNXI_FUNCTION(0x3, "csi0")),		/* D0 */
   663		SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 5),
   664			  SUNXI_FUNCTION(0x0, "gpio_in"),
   665			  SUNXI_FUNCTION(0x1, "gpio_out"),
   666			  SUNXI_FUNCTION(0x2, "ts0"),		/* D1 */
   667			  SUNXI_FUNCTION(0x3, "csi0"),		/* D1 */
   668			  SUNXI_FUNCTION(0x4, "sim")),		/* VPPEN */
   669		SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 6),
   670			  SUNXI_FUNCTION(0x0, "gpio_in"),
   671			  SUNXI_FUNCTION(0x1, "gpio_out"),
   672			  SUNXI_FUNCTION(0x2, "ts0"),		/* D2 */
   673			  SUNXI_FUNCTION(0x3, "csi0")),		/* D2 */
   674		SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 7),
   675			  SUNXI_FUNCTION(0x0, "gpio_in"),
   676			  SUNXI_FUNCTION(0x1, "gpio_out"),
   677			  SUNXI_FUNCTION(0x2, "ts0"),		/* D3 */
   678			  SUNXI_FUNCTION(0x3, "csi0")),		/* D3 */
   679		SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 8),
   680			  SUNXI_FUNCTION(0x0, "gpio_in"),
   681			  SUNXI_FUNCTION(0x1, "gpio_out"),
   682			  SUNXI_FUNCTION(0x2, "ts0"),		/* D4 */
   683			  SUNXI_FUNCTION(0x3, "csi0")),		/* D4 */
   684		SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 9),
   685			  SUNXI_FUNCTION(0x0, "gpio_in"),
   686			  SUNXI_FUNCTION(0x1, "gpio_out"),
   687			  SUNXI_FUNCTION(0x2, "ts0"),		/* D5 */
   688			  SUNXI_FUNCTION(0x3, "csi0")),		/* D5 */
   689		SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 10),
   690			  SUNXI_FUNCTION(0x0, "gpio_in"),
   691			  SUNXI_FUNCTION(0x1, "gpio_out"),
   692			  SUNXI_FUNCTION(0x2, "ts0"),		/* D6 */
   693			  SUNXI_FUNCTION(0x3, "csi0")),		/* D6 */
   694		SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 11),
   695			  SUNXI_FUNCTION(0x0, "gpio_in"),
   696			  SUNXI_FUNCTION(0x1, "gpio_out"),
   697			  SUNXI_FUNCTION(0x2, "ts0"),		/* D7 */
   698			  SUNXI_FUNCTION(0x3, "csi0")),		/* D7 */
   699		/* Hole */
   700		SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 0),
   701			  SUNXI_FUNCTION(0x0, "gpio_in"),
   702			  SUNXI_FUNCTION(0x1, "gpio_out"),
   703			  SUNXI_FUNCTION(0x2, "mmc0"),		/* D1 */
   704			  SUNXI_FUNCTION(0x4, "jtag")),		/* MSI */
   705		SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 1),
   706			  SUNXI_FUNCTION(0x0, "gpio_in"),
   707			  SUNXI_FUNCTION(0x1, "gpio_out"),
   708			  SUNXI_FUNCTION(0x2, "mmc0"),		/* D0 */
   709			  SUNXI_FUNCTION(0x4, "jtag")),		/* DI1 */
   710		SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 2),
   711			  SUNXI_FUNCTION(0x0, "gpio_in"),
   712			  SUNXI_FUNCTION(0x1, "gpio_out"),
   713			  SUNXI_FUNCTION(0x2, "mmc0"),		/* CLK */
   714			  SUNXI_FUNCTION(0x4, "uart0")),	/* TX */
   715		SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 3),
   716			  SUNXI_FUNCTION(0x0, "gpio_in"),
   717			  SUNXI_FUNCTION(0x1, "gpio_out"),
   718			  SUNXI_FUNCTION(0x2, "mmc0"),		/* CMD */
   719			  SUNXI_FUNCTION(0x4, "jtag")),		/* DO1 */
   720		SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 4),
   721			  SUNXI_FUNCTION(0x0, "gpio_in"),
   722			  SUNXI_FUNCTION(0x1, "gpio_out"),
   723			  SUNXI_FUNCTION(0x2, "mmc0"),		/* D3 */
   724			  SUNXI_FUNCTION(0x4, "uart0")),	/* RX */
   725		SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 5),
   726			  SUNXI_FUNCTION(0x0, "gpio_in"),
   727			  SUNXI_FUNCTION(0x1, "gpio_out"),
   728			  SUNXI_FUNCTION(0x2, "mmc0"),		/* D2 */
   729			  SUNXI_FUNCTION(0x4, "jtag")),		/* CK1 */
   730		/* Hole */
   731		SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 0),
   732			  SUNXI_FUNCTION(0x0, "gpio_in"),
   733			  SUNXI_FUNCTION(0x1, "gpio_out"),
   734			  SUNXI_FUNCTION(0x2, "ts1"),		/* CLK */
   735			  SUNXI_FUNCTION(0x3, "csi1"),		/* PCK */
   736			  SUNXI_FUNCTION(0x4, "mmc1")),		/* CMD */
   737		SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 1),
   738			  SUNXI_FUNCTION(0x0, "gpio_in"),
   739			  SUNXI_FUNCTION(0x1, "gpio_out"),
   740			  SUNXI_FUNCTION(0x2, "ts1"),		/* ERR */
   741			  SUNXI_FUNCTION(0x3, "csi1"),		/* CK */
   742			  SUNXI_FUNCTION(0x4, "mmc1")),		/* CLK */
   743		SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 2),
   744			  SUNXI_FUNCTION(0x0, "gpio_in"),
   745			  SUNXI_FUNCTION(0x1, "gpio_out"),
   746			  SUNXI_FUNCTION(0x2, "ts1"),		/* SYNC */
   747			  SUNXI_FUNCTION(0x3, "csi1"),		/* HSYNC */
   748			  SUNXI_FUNCTION(0x4, "mmc1")),		/* D0 */
   749		SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 3),
   750			  SUNXI_FUNCTION(0x0, "gpio_in"),
   751			  SUNXI_FUNCTION(0x1, "gpio_out"),
   752			  SUNXI_FUNCTION(0x2, "ts1"),		/* DVLD */
   753			  SUNXI_FUNCTION(0x3, "csi1"),		/* VSYNC */
   754			  SUNXI_FUNCTION(0x4, "mmc1")),		/* D1 */
   755		SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 4),
   756			  SUNXI_FUNCTION(0x0, "gpio_in"),
   757			  SUNXI_FUNCTION(0x1, "gpio_out"),
   758			  SUNXI_FUNCTION(0x2, "ts1"),		/* D0 */
   759			  SUNXI_FUNCTION(0x3, "csi1"),		/* D0 */
   760			  SUNXI_FUNCTION(0x4, "mmc1"),		/* D2 */
   761			  SUNXI_FUNCTION(0x5, "csi0")),		/* D8 */
   762		SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 5),
   763			  SUNXI_FUNCTION(0x0, "gpio_in"),
   764			  SUNXI_FUNCTION(0x1, "gpio_out"),
   765			  SUNXI_FUNCTION(0x2, "ts1"),		/* D1 */
   766			  SUNXI_FUNCTION(0x3, "csi1"),		/* D1 */
   767			  SUNXI_FUNCTION(0x4, "mmc1"),		/* D3 */
   768			  SUNXI_FUNCTION(0x5, "csi0")),		/* D9 */
   769		SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 6),
   770			  SUNXI_FUNCTION(0x0, "gpio_in"),
   771			  SUNXI_FUNCTION(0x1, "gpio_out"),
   772			  SUNXI_FUNCTION(0x2, "ts1"),		/* D2 */
   773			  SUNXI_FUNCTION(0x3, "csi1"),		/* D2 */
   774			  SUNXI_FUNCTION(0x4, "uart3"),		/* TX */
   775			  SUNXI_FUNCTION(0x5, "csi0")),		/* D10 */
   776		SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 7),
   777			  SUNXI_FUNCTION(0x0, "gpio_in"),
   778			  SUNXI_FUNCTION(0x1, "gpio_out"),
   779			  SUNXI_FUNCTION(0x2, "ts1"),		/* D3 */
   780			  SUNXI_FUNCTION(0x3, "csi1"),		/* D3 */
   781			  SUNXI_FUNCTION(0x4, "uart3"),		/* RX */
   782			  SUNXI_FUNCTION(0x5, "csi0")),		/* D11 */
   783		SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 8),
   784			  SUNXI_FUNCTION(0x0, "gpio_in"),
   785			  SUNXI_FUNCTION(0x1, "gpio_out"),
   786			  SUNXI_FUNCTION(0x2, "ts1"),		/* D4 */
   787			  SUNXI_FUNCTION(0x3, "csi1"),		/* D4 */
   788			  SUNXI_FUNCTION(0x4, "uart3"),		/* RTS */
   789			  SUNXI_FUNCTION(0x5, "csi0")),		/* D12 */
   790		SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 9),
   791			  SUNXI_FUNCTION(0x0, "gpio_in"),
   792			  SUNXI_FUNCTION(0x1, "gpio_out"),
   793			  SUNXI_FUNCTION(0x2, "ts1"),		/* D5 */
   794			  SUNXI_FUNCTION(0x3, "csi1"),		/* D5 */
   795			  SUNXI_FUNCTION(0x4, "uart3"),		/* CTS */
   796			  SUNXI_FUNCTION(0x5, "csi0"),		/* D13 */
   797			  SUNXI_FUNCTION_VARIANT(0x6, "bist",	/* RESULT0 */
   798						 PINCTRL_SUN8I_R40)),
   799		SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 10),
   800			  SUNXI_FUNCTION(0x0, "gpio_in"),
   801			  SUNXI_FUNCTION(0x1, "gpio_out"),
   802			  SUNXI_FUNCTION(0x2, "ts1"),		/* D6 */
   803			  SUNXI_FUNCTION(0x3, "csi1"),		/* D6 */
   804			  SUNXI_FUNCTION(0x4, "uart4"),		/* TX */
   805			  SUNXI_FUNCTION(0x5, "csi0"),		/* D14 */
   806			  SUNXI_FUNCTION_VARIANT(0x6, "bist",	/* RESULT1 */
   807						 PINCTRL_SUN8I_R40)),
   808		SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 11),
   809			  SUNXI_FUNCTION(0x0, "gpio_in"),
   810			  SUNXI_FUNCTION(0x1, "gpio_out"),
   811			  SUNXI_FUNCTION(0x2, "ts1"),		/* D7 */
   812			  SUNXI_FUNCTION(0x3, "csi1"),		/* D7 */
   813			  SUNXI_FUNCTION(0x4, "uart4"),		/* RX */
   814			  SUNXI_FUNCTION(0x5, "csi0")),		/* D15 */
   815		/* Hole */
   816		SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 0),
   817			  SUNXI_FUNCTION(0x0, "gpio_in"),
   818			  SUNXI_FUNCTION(0x1, "gpio_out"),
   819			  SUNXI_FUNCTION(0x2, "lcd1"),		/* D0 */
   820			  SUNXI_FUNCTION_VARIANT(0x3, "pata",	/* ATAA0 */
   821						 PINCTRL_SUN4I_A10),
   822			  SUNXI_FUNCTION(0x4, "uart3"),		/* TX */
   823			  SUNXI_FUNCTION_IRQ(0x6, 0),		/* EINT0 */
   824			  SUNXI_FUNCTION(0x7, "csi1")),		/* D0 */
   825		SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 1),
   826			  SUNXI_FUNCTION(0x0, "gpio_in"),
   827			  SUNXI_FUNCTION(0x1, "gpio_out"),
   828			  SUNXI_FUNCTION(0x2, "lcd1"),		/* D1 */
   829			  SUNXI_FUNCTION_VARIANT(0x3, "pata",	/* ATAA1 */
   830						 PINCTRL_SUN4I_A10),
   831			  SUNXI_FUNCTION(0x4, "uart3"),		/* RX */
   832			  SUNXI_FUNCTION_IRQ(0x6, 1),		/* EINT1 */
   833			  SUNXI_FUNCTION(0x7, "csi1")),		/* D1 */
   834		SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 2),
   835			  SUNXI_FUNCTION(0x0, "gpio_in"),
   836			  SUNXI_FUNCTION(0x1, "gpio_out"),
   837			  SUNXI_FUNCTION(0x2, "lcd1"),		/* D2 */
   838			  SUNXI_FUNCTION_VARIANT(0x3, "pata",	/* ATAA2 */
   839						 PINCTRL_SUN4I_A10),
   840			  SUNXI_FUNCTION(0x4, "uart3"),		/* RTS */
   841			  SUNXI_FUNCTION_IRQ(0x6, 2),		/* EINT2 */
   842			  SUNXI_FUNCTION(0x7, "csi1")),		/* D2 */
   843		SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 3),
   844			  SUNXI_FUNCTION(0x0, "gpio_in"),
   845			  SUNXI_FUNCTION(0x1, "gpio_out"),
   846			  SUNXI_FUNCTION(0x2, "lcd1"),		/* D3 */
   847			  SUNXI_FUNCTION_VARIANT(0x3, "pata",	/* ATAIRQ */
   848						 PINCTRL_SUN4I_A10),
   849			  SUNXI_FUNCTION(0x4, "uart3"),		/* CTS */
   850			  SUNXI_FUNCTION_IRQ(0x6, 3),		/* EINT3 */
   851			  SUNXI_FUNCTION(0x7, "csi1")),		/* D3 */
   852		SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 4),
   853			  SUNXI_FUNCTION(0x0, "gpio_in"),
   854			  SUNXI_FUNCTION(0x1, "gpio_out"),
   855			  SUNXI_FUNCTION(0x2, "lcd1"),		/* D4 */
   856			  SUNXI_FUNCTION_VARIANT(0x3, "pata",	/* ATAD0 */
   857						 PINCTRL_SUN4I_A10),
   858			  SUNXI_FUNCTION(0x4, "uart4"),		/* TX */
   859			  SUNXI_FUNCTION_IRQ(0x6, 4),		/* EINT4 */
   860			  SUNXI_FUNCTION(0x7, "csi1")),		/* D4 */
   861		SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 5),
   862			  SUNXI_FUNCTION(0x0, "gpio_in"),
   863			  SUNXI_FUNCTION(0x1, "gpio_out"),
   864			  SUNXI_FUNCTION(0x2, "lcd1"),		/* D5 */
   865			  SUNXI_FUNCTION_VARIANT(0x3, "pata",	/* ATAD1 */
   866						 PINCTRL_SUN4I_A10),
   867			  SUNXI_FUNCTION(0x4, "uart4"),		/* RX */
   868			  SUNXI_FUNCTION_IRQ(0x6, 5),		/* EINT5 */
   869			  SUNXI_FUNCTION(0x7, "csi1")),		/* D5 */
   870		SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 6),
   871			  SUNXI_FUNCTION(0x0, "gpio_in"),
   872			  SUNXI_FUNCTION(0x1, "gpio_out"),
   873			  SUNXI_FUNCTION(0x2, "lcd1"),		/* D6 */
   874			  SUNXI_FUNCTION_VARIANT(0x3, "pata",	/* ATAD2 */
   875						 PINCTRL_SUN4I_A10),
   876			  SUNXI_FUNCTION(0x4, "uart5"),		/* TX */
   877			  SUNXI_FUNCTION_VARIANT(0x5, "ms",	/* BS */
   878						 PINCTRL_SUN4I_A10 |
   879						 PINCTRL_SUN7I_A20),
   880			  SUNXI_FUNCTION_IRQ(0x6, 6),		/* EINT6 */
   881			  SUNXI_FUNCTION(0x7, "csi1")),		/* D6 */
   882		SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 7),
   883			  SUNXI_FUNCTION(0x0, "gpio_in"),
   884			  SUNXI_FUNCTION(0x1, "gpio_out"),
   885			  SUNXI_FUNCTION(0x2, "lcd1"),		/* D7 */
   886			  SUNXI_FUNCTION_VARIANT(0x3, "pata",	/* ATAD3 */
   887						 PINCTRL_SUN4I_A10),
   888			  SUNXI_FUNCTION(0x4, "uart5"),		/* RX */
   889			  SUNXI_FUNCTION_VARIANT(0x5, "ms",	/* CLK */
   890						 PINCTRL_SUN4I_A10 |
   891						 PINCTRL_SUN7I_A20),
   892			  SUNXI_FUNCTION_IRQ(0x6, 7),		/* EINT7 */
   893			  SUNXI_FUNCTION(0x7, "csi1")),		/* D7 */
   894		SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 8),
   895			  SUNXI_FUNCTION(0x0, "gpio_in"),
   896			  SUNXI_FUNCTION(0x1, "gpio_out"),
   897			  SUNXI_FUNCTION(0x2, "lcd1"),		/* D8 */
   898			  SUNXI_FUNCTION_VARIANT(0x3, "pata",	/* ATAD4 */
   899						 PINCTRL_SUN4I_A10),
   900			  SUNXI_FUNCTION_VARIANT(0x3, "emac",	/* ERXD3 */
   901						 PINCTRL_SUN7I_A20 |
   902						 PINCTRL_SUN8I_R40),
   903			  SUNXI_FUNCTION(0x4, "keypad"),	/* IN0 */
   904			  SUNXI_FUNCTION_VARIANT(0x5, "ms",	/* D0 */
   905						 PINCTRL_SUN4I_A10 |
   906						 PINCTRL_SUN7I_A20),
   907			  SUNXI_FUNCTION_IRQ(0x6, 8),		/* EINT8 */
   908			  SUNXI_FUNCTION(0x7, "csi1")),		/* D8 */
   909		SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 9),
   910			  SUNXI_FUNCTION(0x0, "gpio_in"),
   911			  SUNXI_FUNCTION(0x1, "gpio_out"),
   912			  SUNXI_FUNCTION(0x2, "lcd1"),		/* D9 */
   913			  SUNXI_FUNCTION_VARIANT(0x3, "pata",	/* ATAD5 */
   914						 PINCTRL_SUN4I_A10),
   915			  SUNXI_FUNCTION_VARIANT(0x3, "emac",	/* ERXD2 */
   916						 PINCTRL_SUN7I_A20 |
   917						 PINCTRL_SUN8I_R40),
   918			  SUNXI_FUNCTION(0x4, "keypad"),	/* IN1 */
   919			  SUNXI_FUNCTION_VARIANT(0x5, "ms",	/* D1 */
   920						 PINCTRL_SUN4I_A10 |
   921						 PINCTRL_SUN7I_A20),
   922			  SUNXI_FUNCTION_IRQ(0x6, 9),		/* EINT9 */
   923			  SUNXI_FUNCTION(0x7, "csi1")),		/* D9 */
   924		SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 10),
   925			  SUNXI_FUNCTION(0x0, "gpio_in"),
   926			  SUNXI_FUNCTION(0x1, "gpio_out"),
   927			  SUNXI_FUNCTION(0x2, "lcd1"),		/* D10 */
   928			  SUNXI_FUNCTION_VARIANT(0x3, "pata",	/* ATAD6 */
   929						 PINCTRL_SUN4I_A10),
   930			  SUNXI_FUNCTION_VARIANT(0x3, "emac",	/* ERXD1 */
   931						 PINCTRL_SUN7I_A20 |
   932						 PINCTRL_SUN8I_R40),
   933			  SUNXI_FUNCTION(0x4, "keypad"),	/* IN2 */
   934			  SUNXI_FUNCTION_VARIANT(0x5, "ms",	/* D2 */
   935						 PINCTRL_SUN4I_A10 |
   936						 PINCTRL_SUN7I_A20),
   937			  SUNXI_FUNCTION_IRQ(0x6, 10),		/* EINT10 */
   938			  SUNXI_FUNCTION(0x7, "csi1")),		/* D10 */
   939		SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 11),
   940			  SUNXI_FUNCTION(0x0, "gpio_in"),
   941			  SUNXI_FUNCTION(0x1, "gpio_out"),
   942			  SUNXI_FUNCTION(0x2, "lcd1"),		/* D11 */
   943			  SUNXI_FUNCTION_VARIANT(0x3, "pata",	/* ATAD7 */
   944						 PINCTRL_SUN4I_A10),
   945			  SUNXI_FUNCTION_VARIANT(0x3, "emac",	/* ERXD0 */
   946						 PINCTRL_SUN7I_A20 |
   947						 PINCTRL_SUN8I_R40),
   948			  SUNXI_FUNCTION(0x4, "keypad"),	/* IN3 */
   949			  SUNXI_FUNCTION_VARIANT(0x5, "ms",	/* D3 */
   950						 PINCTRL_SUN4I_A10 |
   951						 PINCTRL_SUN7I_A20),
   952			  SUNXI_FUNCTION_IRQ(0x6, 11),		/* EINT11 */
   953			  SUNXI_FUNCTION(0x7, "csi1")),		/* D11 */
   954		SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 12),
   955			  SUNXI_FUNCTION(0x0, "gpio_in"),
   956			  SUNXI_FUNCTION(0x1, "gpio_out"),
   957			  SUNXI_FUNCTION(0x2, "lcd1"),		/* D12 */
   958			  SUNXI_FUNCTION_VARIANT(0x3, "pata",	/* ATAD8 */
   959						 PINCTRL_SUN4I_A10),
   960			  SUNXI_FUNCTION(0x4, "ps2"),		/* SCK1 */
   961			  SUNXI_FUNCTION_IRQ(0x6, 12),		/* EINT12 */
   962			  SUNXI_FUNCTION(0x7, "csi1")),		/* D12 */
   963		SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 13),
   964			  SUNXI_FUNCTION(0x0, "gpio_in"),
   965			  SUNXI_FUNCTION(0x1, "gpio_out"),
   966			  SUNXI_FUNCTION(0x2, "lcd1"),		/* D13 */
   967			  SUNXI_FUNCTION_VARIANT(0x3, "pata",	/* ATAD9 */
   968						 PINCTRL_SUN4I_A10),
   969			  SUNXI_FUNCTION(0x4, "ps2"),		/* SDA1 */
   970			  SUNXI_FUNCTION(0x5, "sim"),		/* RST */
   971			  SUNXI_FUNCTION_IRQ(0x6, 13),		/* EINT13 */
   972			  SUNXI_FUNCTION(0x7, "csi1")),		/* D13 */
   973		SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 14),
   974			  SUNXI_FUNCTION(0x0, "gpio_in"),
   975			  SUNXI_FUNCTION(0x1, "gpio_out"),
   976			  SUNXI_FUNCTION(0x2, "lcd1"),		/* D14 */
   977			  SUNXI_FUNCTION_VARIANT(0x3, "pata",	/* ATAD10 */
   978						 PINCTRL_SUN4I_A10),
   979			  SUNXI_FUNCTION_VARIANT(0x3, "emac",	/* ETXD3 */
   980						 PINCTRL_SUN7I_A20 |
   981						 PINCTRL_SUN8I_R40),
   982			  SUNXI_FUNCTION(0x4, "keypad"),	/* IN4 */
   983			  SUNXI_FUNCTION(0x5, "sim"),		/* VPPEN */
   984			  SUNXI_FUNCTION_IRQ(0x6, 14),		/* EINT14 */
   985			  SUNXI_FUNCTION(0x7, "csi1")),		/* D14 */
   986		SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 15),
   987			  SUNXI_FUNCTION(0x0, "gpio_in"),
   988			  SUNXI_FUNCTION(0x1, "gpio_out"),
   989			  SUNXI_FUNCTION(0x2, "lcd1"),		/* D15 */
   990			  SUNXI_FUNCTION_VARIANT(0x3, "pata",	/* ATAD11 */
   991						 PINCTRL_SUN4I_A10),
   992			  SUNXI_FUNCTION_VARIANT(0x3, "emac",	/* ETXD2 */
   993						 PINCTRL_SUN7I_A20 |
   994						 PINCTRL_SUN8I_R40),
   995			  SUNXI_FUNCTION(0x4, "keypad"),	/* IN5 */
   996			  SUNXI_FUNCTION(0x5, "sim"),		/* VPPPP */
   997			  SUNXI_FUNCTION_IRQ(0x6, 15),		/* EINT15 */
   998			  SUNXI_FUNCTION(0x7, "csi1")),		/* D15 */
   999		SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 16),
  1000			  SUNXI_FUNCTION(0x0, "gpio_in"),
  1001			  SUNXI_FUNCTION(0x1, "gpio_out"),
  1002			  SUNXI_FUNCTION(0x2, "lcd1"),		/* D16 */
  1003			  SUNXI_FUNCTION_VARIANT(0x3, "pata",	/* ATAD12 */
  1004						 PINCTRL_SUN4I_A10),
  1005			  SUNXI_FUNCTION_VARIANT(0x3, "emac",	/* ETXD1 */
  1006						 PINCTRL_SUN7I_A20 |
  1007						 PINCTRL_SUN8I_R40),
  1008			  SUNXI_FUNCTION(0x4, "keypad"),	/* IN6 */
  1009			  SUNXI_FUNCTION(0x5, "sim"),		/* DET */
  1010			  SUNXI_FUNCTION_IRQ(0x6, 16),		/* EINT16 */
  1011			  SUNXI_FUNCTION(0x7, "csi1")),		/* D16 */
  1012		SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 17),
  1013			  SUNXI_FUNCTION(0x0, "gpio_in"),
  1014			  SUNXI_FUNCTION(0x1, "gpio_out"),
  1015			  SUNXI_FUNCTION(0x2, "lcd1"),		/* D17 */
  1016			  SUNXI_FUNCTION_VARIANT(0x3, "pata",	/* ATAD13 */
  1017						 PINCTRL_SUN4I_A10),
  1018			  SUNXI_FUNCTION_VARIANT(0x3, "emac",	/* ETXD0 */
  1019						 PINCTRL_SUN7I_A20 |
  1020						 PINCTRL_SUN8I_R40),
  1021			  SUNXI_FUNCTION(0x4, "keypad"),	/* IN7 */
  1022			  SUNXI_FUNCTION(0x5, "sim"),		/* VCCEN */
  1023			  SUNXI_FUNCTION_IRQ(0x6, 17),		/* EINT17 */
  1024			  SUNXI_FUNCTION(0x7, "csi1")),		/* D17 */
  1025		SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 18),
  1026			  SUNXI_FUNCTION(0x0, "gpio_in"),
  1027			  SUNXI_FUNCTION(0x1, "gpio_out"),
  1028			  SUNXI_FUNCTION(0x2, "lcd1"),		/* D18 */
  1029			  SUNXI_FUNCTION_VARIANT(0x3, "pata",	/* ATAD14 */
  1030						 PINCTRL_SUN4I_A10),
  1031			  SUNXI_FUNCTION_VARIANT(0x3, "emac",	/* ERXCK */
  1032						 PINCTRL_SUN7I_A20 |
  1033						 PINCTRL_SUN8I_R40),
  1034			  SUNXI_FUNCTION(0x4, "keypad"),	/* OUT0 */
  1035			  SUNXI_FUNCTION(0x5, "sim"),		/* SCK */
  1036			  SUNXI_FUNCTION_IRQ(0x6, 18),		/* EINT18 */
  1037			  SUNXI_FUNCTION(0x7, "csi1")),		/* D18 */
  1038		SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 19),
  1039			  SUNXI_FUNCTION(0x0, "gpio_in"),
  1040			  SUNXI_FUNCTION(0x1, "gpio_out"),
  1041			  SUNXI_FUNCTION(0x2, "lcd1"),		/* D19 */
  1042			  SUNXI_FUNCTION_VARIANT(0x3, "pata",	/* ATAD15 */
  1043						 PINCTRL_SUN4I_A10),
  1044			  SUNXI_FUNCTION_VARIANT(0x3, "emac",	/* ERXERR */
  1045						 PINCTRL_SUN7I_A20 |
  1046						 PINCTRL_SUN8I_R40),
  1047			  SUNXI_FUNCTION(0x4, "keypad"),	/* OUT1 */
  1048			  SUNXI_FUNCTION(0x5, "sim"),		/* SDA */
  1049			  SUNXI_FUNCTION_IRQ(0x6, 19),		/* EINT19 */
  1050			  SUNXI_FUNCTION(0x7, "csi1")),		/* D19 */
  1051		SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 20),
  1052			  SUNXI_FUNCTION(0x0, "gpio_in"),
  1053			  SUNXI_FUNCTION(0x1, "gpio_out"),
  1054			  SUNXI_FUNCTION(0x2, "lcd1"),		/* D20 */
  1055			  SUNXI_FUNCTION_VARIANT(0x3, "pata",	/* ATAOE */
  1056						 PINCTRL_SUN4I_A10),
  1057			  SUNXI_FUNCTION_VARIANT(0x3, "emac",	/* ERXDV */
  1058						 PINCTRL_SUN7I_A20 |
  1059						 PINCTRL_SUN8I_R40),
  1060			  SUNXI_FUNCTION(0x4, "can"),		/* TX */
  1061			  SUNXI_FUNCTION_IRQ(0x6, 20),		/* EINT20 */
  1062			  SUNXI_FUNCTION(0x7, "csi1")),		/* D20 */
  1063		SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 21),
  1064			  SUNXI_FUNCTION(0x0, "gpio_in"),
  1065			  SUNXI_FUNCTION(0x1, "gpio_out"),
  1066			  SUNXI_FUNCTION(0x2, "lcd1"),		/* D21 */
  1067			  SUNXI_FUNCTION_VARIANT(0x3, "pata",	/* ATADREQ */
  1068						 PINCTRL_SUN4I_A10),
  1069			  SUNXI_FUNCTION_VARIANT(0x3, "emac",	/* EMDC */
  1070						 PINCTRL_SUN7I_A20 |
  1071						 PINCTRL_SUN8I_R40),
  1072			  SUNXI_FUNCTION(0x4, "can"),		/* RX */
  1073			  SUNXI_FUNCTION_IRQ(0x6, 21),		/* EINT21 */
  1074			  SUNXI_FUNCTION(0x7, "csi1")),		/* D21 */
  1075		SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 22),
  1076			  SUNXI_FUNCTION(0x0, "gpio_in"),
  1077			  SUNXI_FUNCTION(0x1, "gpio_out"),
  1078			  SUNXI_FUNCTION(0x2, "lcd1"),		/* D22 */
  1079			  SUNXI_FUNCTION_VARIANT(0x3, "pata",	/* ATADACK */
  1080						 PINCTRL_SUN4I_A10),
  1081			  SUNXI_FUNCTION_VARIANT(0x3, "emac",	/* EMDIO */
  1082						 PINCTRL_SUN7I_A20 |
  1083						 PINCTRL_SUN8I_R40),
  1084			  SUNXI_FUNCTION(0x4, "keypad"),	/* OUT2 */
  1085			  SUNXI_FUNCTION(0x5, "mmc1"),		/* CMD */
  1086			  SUNXI_FUNCTION(0x7, "csi1")),		/* D22 */
  1087		SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 23),
  1088			  SUNXI_FUNCTION(0x0, "gpio_in"),
  1089			  SUNXI_FUNCTION(0x1, "gpio_out"),
  1090			  SUNXI_FUNCTION(0x2, "lcd1"),		/* D23 */
  1091			  SUNXI_FUNCTION_VARIANT(0x3, "pata",	/* ATACS0 */
  1092						 PINCTRL_SUN4I_A10),
  1093			  SUNXI_FUNCTION_VARIANT(0x3, "emac",	/* ETXEN */
  1094						 PINCTRL_SUN7I_A20 |
  1095						 PINCTRL_SUN8I_R40),
  1096			  SUNXI_FUNCTION(0x4, "keypad"),	/* OUT3 */
  1097			  SUNXI_FUNCTION(0x5, "mmc1"),		/* CLK */
  1098			  SUNXI_FUNCTION(0x7, "csi1")),		/* D23 */
  1099		SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 24),
  1100			  SUNXI_FUNCTION(0x0, "gpio_in"),
  1101			  SUNXI_FUNCTION(0x1, "gpio_out"),
  1102			  SUNXI_FUNCTION(0x2, "lcd1"),		/* CLK */
  1103			  SUNXI_FUNCTION_VARIANT(0x3, "pata",	/* ATACS1 */
  1104						 PINCTRL_SUN4I_A10),
  1105			  SUNXI_FUNCTION_VARIANT(0x3, "emac",	/* ETXCK */
  1106						 PINCTRL_SUN7I_A20 |
  1107						 PINCTRL_SUN8I_R40),
  1108			  SUNXI_FUNCTION(0x4, "keypad"),	/* OUT4 */
  1109			  SUNXI_FUNCTION(0x5, "mmc1"),		/* D0 */
  1110			  SUNXI_FUNCTION(0x7, "csi1")),		/* PCLK */
  1111		SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 25),
  1112			  SUNXI_FUNCTION(0x0, "gpio_in"),
  1113			  SUNXI_FUNCTION(0x1, "gpio_out"),
  1114			  SUNXI_FUNCTION(0x2, "lcd1"),		/* DE */
  1115			  SUNXI_FUNCTION_VARIANT(0x3, "pata",	/* ATAIORDY */
  1116						 PINCTRL_SUN4I_A10),
  1117			  SUNXI_FUNCTION_VARIANT(0x3, "emac",	/* ECRS */
  1118						 PINCTRL_SUN7I_A20 |
  1119						 PINCTRL_SUN8I_R40),
  1120			  SUNXI_FUNCTION(0x4, "keypad"),	/* OUT5 */
  1121			  SUNXI_FUNCTION(0x5, "mmc1"),		/* D1 */
  1122			  SUNXI_FUNCTION(0x7, "csi1")),		/* FIELD */
  1123		SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 26),
  1124			  SUNXI_FUNCTION(0x0, "gpio_in"),
  1125			  SUNXI_FUNCTION(0x1, "gpio_out"),
  1126			  SUNXI_FUNCTION(0x2, "lcd1"),		/* HSYNC */
  1127			  SUNXI_FUNCTION_VARIANT(0x3, "pata",	/* ATAIOR */
  1128						 PINCTRL_SUN4I_A10),
  1129			  SUNXI_FUNCTION_VARIANT(0x3, "emac",	/* ECOL */
  1130						 PINCTRL_SUN7I_A20 |
  1131						 PINCTRL_SUN8I_R40),
  1132			  SUNXI_FUNCTION(0x4, "keypad"),	/* OUT6 */
  1133			  SUNXI_FUNCTION(0x5, "mmc1"),		/* D2 */
  1134			  SUNXI_FUNCTION(0x7, "csi1")),		/* HSYNC */
  1135		SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 27),
  1136			  SUNXI_FUNCTION(0x0, "gpio_in"),
  1137			  SUNXI_FUNCTION(0x1, "gpio_out"),
  1138			  SUNXI_FUNCTION(0x2, "lcd1"),		/* VSYNC */
  1139			  SUNXI_FUNCTION_VARIANT(0x3, "pata",	/* ATAIOW */
  1140						 PINCTRL_SUN4I_A10),
  1141			  SUNXI_FUNCTION_VARIANT(0x3, "emac",	/* ETXERR */
  1142						 PINCTRL_SUN7I_A20 |
  1143						 PINCTRL_SUN8I_R40),
  1144			  SUNXI_FUNCTION(0x4, "keypad"),	/* OUT7 */
  1145			  SUNXI_FUNCTION(0x5, "mmc1"),		/* D3 */
  1146			  SUNXI_FUNCTION(0x7, "csi1")),		/* VSYNC */
  1147		/* Hole */
  1148		SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 0),
  1149			  SUNXI_FUNCTION(0x0, "gpio_in"),
  1150			  SUNXI_FUNCTION(0x1, "gpio_out"),
  1151			  SUNXI_FUNCTION_VARIANT(0x3, "i2c3",	/* SCK */
  1152						 PINCTRL_SUN7I_A20 |
  1153						 PINCTRL_SUN8I_R40)),
  1154		SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 1),
  1155			  SUNXI_FUNCTION(0x0, "gpio_in"),
  1156			  SUNXI_FUNCTION(0x1, "gpio_out"),
  1157			  SUNXI_FUNCTION_VARIANT(0x3, "i2c3",	/* SDA */
  1158						 PINCTRL_SUN7I_A20 |
  1159						 PINCTRL_SUN8I_R40)),
  1160		SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 2),
  1161			  SUNXI_FUNCTION(0x0, "gpio_in"),
  1162			  SUNXI_FUNCTION(0x1, "gpio_out"),
  1163			  SUNXI_FUNCTION_VARIANT(0x3, "i2c4",	/* SCK */
  1164						 PINCTRL_SUN7I_A20 |
  1165						 PINCTRL_SUN8I_R40)),
  1166		SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 3),
  1167			  SUNXI_FUNCTION(0x0, "gpio_in"),
  1168			  SUNXI_FUNCTION(0x1, "gpio_out"),
  1169			  SUNXI_FUNCTION(0x2, "pwm"),		/* PWM1 */
  1170			  SUNXI_FUNCTION_VARIANT(0x3, "i2c3",	/* SDA */
  1171						 PINCTRL_SUN7I_A20 |
  1172						 PINCTRL_SUN8I_R40)),
  1173		SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 4),
  1174			  SUNXI_FUNCTION(0x0, "gpio_in"),
  1175			  SUNXI_FUNCTION(0x1, "gpio_out"),
  1176			  SUNXI_FUNCTION(0x2, "mmc3")),		/* CMD */
  1177		SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 5),
  1178			  SUNXI_FUNCTION(0x0, "gpio_in"),
  1179			  SUNXI_FUNCTION(0x1, "gpio_out"),
  1180			  SUNXI_FUNCTION(0x2, "mmc3")),		/* CLK */
  1181		SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 6),
  1182			  SUNXI_FUNCTION(0x0, "gpio_in"),
  1183			  SUNXI_FUNCTION(0x1, "gpio_out"),
  1184			  SUNXI_FUNCTION(0x2, "mmc3")),		/* D0 */
  1185		SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 7),
  1186			  SUNXI_FUNCTION(0x0, "gpio_in"),
  1187			  SUNXI_FUNCTION(0x1, "gpio_out"),
  1188			  SUNXI_FUNCTION(0x2, "mmc3")),		/* D1 */
  1189		SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 8),
  1190			  SUNXI_FUNCTION(0x0, "gpio_in"),
  1191			  SUNXI_FUNCTION(0x1, "gpio_out"),
  1192			  SUNXI_FUNCTION(0x2, "mmc3")),		/* D2 */
  1193		SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 9),
  1194			  SUNXI_FUNCTION(0x0, "gpio_in"),
  1195			  SUNXI_FUNCTION(0x1, "gpio_out"),
  1196			  SUNXI_FUNCTION(0x2, "mmc3")),		/* D3 */
  1197		SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 10),
  1198			  SUNXI_FUNCTION(0x0, "gpio_in"),
  1199			  SUNXI_FUNCTION(0x1, "gpio_out"),
  1200			  SUNXI_FUNCTION(0x2, "spi0"),		/* CS0 */
  1201			  SUNXI_FUNCTION(0x3, "uart5"),		/* TX */
  1202			  SUNXI_FUNCTION_IRQ(0x6, 22)),		/* EINT22 */
  1203		SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 11),
  1204			  SUNXI_FUNCTION(0x0, "gpio_in"),
  1205			  SUNXI_FUNCTION(0x1, "gpio_out"),
  1206			  SUNXI_FUNCTION(0x2, "spi0"),		/* CLK */
  1207			  SUNXI_FUNCTION(0x3, "uart5"),		/* RX */
  1208			  SUNXI_FUNCTION_IRQ(0x6, 23)),		/* EINT23 */
  1209		SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 12),
  1210			  SUNXI_FUNCTION(0x0, "gpio_in"),
  1211			  SUNXI_FUNCTION(0x1, "gpio_out"),
  1212			  SUNXI_FUNCTION(0x2, "spi0"),		/* MOSI */
  1213			  SUNXI_FUNCTION(0x3, "uart6"),		/* TX */
  1214			  SUNXI_FUNCTION_VARIANT(0x4, "clk_out_a",
  1215						 PINCTRL_SUN7I_A20 |
  1216						 PINCTRL_SUN8I_R40),
  1217			  SUNXI_FUNCTION_IRQ(0x6, 24)),		/* EINT24 */
  1218		SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 13),
  1219			  SUNXI_FUNCTION(0x0, "gpio_in"),
  1220			  SUNXI_FUNCTION(0x1, "gpio_out"),
  1221			  SUNXI_FUNCTION(0x2, "spi0"),		/* MISO */
  1222			  SUNXI_FUNCTION(0x3, "uart6"),		/* RX */
  1223			  SUNXI_FUNCTION_VARIANT(0x4, "clk_out_b",
  1224						 PINCTRL_SUN7I_A20 |
  1225						 PINCTRL_SUN8I_R40),
  1226			  SUNXI_FUNCTION_IRQ(0x6, 25)),		/* EINT25 */
  1227		SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 14),
  1228			  SUNXI_FUNCTION(0x0, "gpio_in"),
  1229			  SUNXI_FUNCTION(0x1, "gpio_out"),
  1230			  SUNXI_FUNCTION(0x2, "spi0"),		/* CS1 */
  1231			  SUNXI_FUNCTION(0x3, "ps2"),		/* SCK1 */
  1232			  SUNXI_FUNCTION(0x4, "timer4"),	/* TCLKIN0 */
  1233			  SUNXI_FUNCTION_IRQ(0x6, 26)),		/* EINT26 */
  1234		SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 15),
  1235			  SUNXI_FUNCTION(0x0, "gpio_in"),
  1236			  SUNXI_FUNCTION(0x1, "gpio_out"),
  1237			  SUNXI_FUNCTION(0x2, "spi1"),		/* CS1 */
  1238			  SUNXI_FUNCTION(0x3, "ps2"),		/* SDA1 */
  1239			  SUNXI_FUNCTION(0x4, "timer5"),	/* TCLKIN1 */
  1240			  SUNXI_FUNCTION_IRQ(0x6, 27)),		/* EINT27 */
  1241		SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 16),
  1242			  SUNXI_FUNCTION(0x0, "gpio_in"),
  1243			  SUNXI_FUNCTION(0x1, "gpio_out"),
  1244			  SUNXI_FUNCTION(0x2, "spi1"),		/* CS0 */
  1245			  SUNXI_FUNCTION(0x3, "uart2"),		/* RTS */
  1246			  SUNXI_FUNCTION_IRQ(0x6, 28)),		/* EINT28 */
  1247		SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 17),
  1248			  SUNXI_FUNCTION(0x0, "gpio_in"),
  1249			  SUNXI_FUNCTION(0x1, "gpio_out"),
  1250			  SUNXI_FUNCTION(0x2, "spi1"),		/* CLK */
  1251			  SUNXI_FUNCTION(0x3, "uart2"),		/* CTS */
  1252			  SUNXI_FUNCTION_IRQ(0x6, 29)),		/* EINT29 */
  1253		SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 18),
  1254			  SUNXI_FUNCTION(0x0, "gpio_in"),
  1255			  SUNXI_FUNCTION(0x1, "gpio_out"),
  1256			  SUNXI_FUNCTION(0x2, "spi1"),		/* MOSI */
  1257			  SUNXI_FUNCTION(0x3, "uart2"),		/* TX */
  1258			  SUNXI_FUNCTION_IRQ(0x6, 30)),		/* EINT30 */
  1259		SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 19),
  1260			  SUNXI_FUNCTION(0x0, "gpio_in"),
  1261			  SUNXI_FUNCTION(0x1, "gpio_out"),
  1262			  SUNXI_FUNCTION(0x2, "spi1"),		/* MISO */
  1263			  SUNXI_FUNCTION(0x3, "uart2"),		/* RX */
  1264			  SUNXI_FUNCTION_IRQ(0x6, 31)),		/* EINT31 */
  1265		SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 20),
  1266			  SUNXI_FUNCTION(0x0, "gpio_in"),
  1267			  SUNXI_FUNCTION(0x1, "gpio_out"),
  1268			  SUNXI_FUNCTION(0x2, "ps2"),		/* SCK0 */
  1269			  SUNXI_FUNCTION(0x3, "uart7"),		/* TX */
  1270			  SUNXI_FUNCTION_VARIANT(0x4, "hdmi",	/* HSCL */
  1271						 PINCTRL_SUN4I_A10 |
  1272						 PINCTRL_SUN7I_A20),
  1273			  SUNXI_FUNCTION_VARIANT(0x6, "pwm",	/* PWM2 */
  1274						 PINCTRL_SUN8I_R40)),
  1275		SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 21),
  1276			  SUNXI_FUNCTION(0x0, "gpio_in"),
  1277			  SUNXI_FUNCTION(0x1, "gpio_out"),
  1278			  SUNXI_FUNCTION(0x2, "ps2"),		/* SDA0 */
  1279			  SUNXI_FUNCTION(0x3, "uart7"),		/* RX */
  1280			  SUNXI_FUNCTION_VARIANT(0x4, "hdmi",	/* HSDA */
  1281						 PINCTRL_SUN4I_A10 |
  1282						 PINCTRL_SUN7I_A20),
  1283			  SUNXI_FUNCTION_VARIANT(0x6, "pwm",	/* PWM3 */
  1284						 PINCTRL_SUN8I_R40)),
  1285	};
  1286	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 21035 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170719/23a7fec5/attachment-0001.gz>
