From: fengguang.wu@intel.com (kbuild test robot)
Date: Sun, 7 May 2017 07:19:51 +0800
Subject: [nomadik:gemini-pata 56/56] drivers/ata/sata_gemini.c:33:22: error:
 field 'muxmode' has incomplete type
Message-ID: <201705070750.jRvyIcmD%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git gemini-pata
head:   40247f2ee995df0c9912c77a114ca1f4bbbcc0a8
commit: 40247f2ee995df0c9912c77a114ca1f4bbbcc0a8 [56/56] ata: Add driver for Faraday Technology FTIDE010
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 40247f2ee995df0c9912c77a114ca1f4bbbcc0a8
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All error/warnings (new ones prefixed by >>):

>> drivers/ata/sata_gemini.c:33:22: error: field 'muxmode' has incomplete type
     enum gemini_muxmode muxmode;
                         ^~~~~~~
   drivers/ata/sata_gemini.c: In function 'gemini_sata_bridge_enabled':
>> drivers/ata/sata_gemini.c:141:22: error: 'GEMINI_MUXMODE_2' undeclared (first use in this function)
     if ((sg->muxmode == GEMINI_MUXMODE_2) &&
                         ^~~~~~~~~~~~~~~~
   drivers/ata/sata_gemini.c:141:22: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/ata/sata_gemini.c:144:22: error: 'GEMINI_MUXMODE_3' undeclared (first use in this function)
     if ((sg->muxmode == GEMINI_MUXMODE_3) &&
                         ^~~~~~~~~~~~~~~~
   drivers/ata/sata_gemini.c: At top level:
>> drivers/ata/sata_gemini.c:151:21: error: return type is an incomplete type
    enum gemini_muxmode gemini_sata_get_muxmode(struct sata_gemini *sg)
                        ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/ata/sata_gemini.c: In function 'gemini_sata_get_muxmode':
>> drivers/ata/sata_gemini.c:153:9: warning: 'return' with a value, in function returning void
     return sg->muxmode;
            ^~
   drivers/ata/sata_gemini.c:151:21: note: declared here
    enum gemini_muxmode gemini_sata_get_muxmode(struct sata_gemini *sg)
                        ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/ata/sata_gemini.c: In function 'gemini_sata_setup_bridge':
   drivers/ata/sata_gemini.c:166:22: error: 'GEMINI_MUXMODE_2' undeclared (first use in this function)
      if (sg->muxmode == GEMINI_MUXMODE_2)
                         ^~~~~~~~~~~~~~~~
   drivers/ata/sata_gemini.c:172:22: error: 'GEMINI_MUXMODE_3' undeclared (first use in this function)
      if (sg->muxmode == GEMINI_MUXMODE_3)
                         ^~~~~~~~~~~~~~~~
   drivers/ata/sata_gemini.c: In function 'gemini_sata_probe':
>> drivers/ata/sata_gemini.c:286:22: error: storage size of 'muxmode' isn't known
     enum gemini_muxmode muxmode;
                         ^~~~~~~
   drivers/ata/sata_gemini.c:331:16: error: 'GEMINI_MUXMODE_3' undeclared (first use in this function)
     if (muxmode > GEMINI_MUXMODE_3) {
                   ^~~~~~~~~~~~~~~~
   drivers/ata/sata_gemini.c:286:22: warning: unused variable 'muxmode' [-Wunused-variable]
     enum gemini_muxmode muxmode;
                         ^~~~~~~
--
   drivers/ata/pata_ftide010.c: In function 'pata_ftide010_gemini_phy_hardreset':
>> drivers/ata/pata_ftide010.c:327:9: error: implicit declaration of function 'gemini_sata_reset_bridge' [-Werror=implicit-function-declaration]
      ret = gemini_sata_reset_bridge(sg, 0);
            ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/ata/pata_ftide010.c: In function 'pata_ftide010_gemini_port_start':
>> drivers/ata/pata_ftide010.c:368:9: error: implicit declaration of function 'gemini_sata_start_bridge' [-Werror=implicit-function-declaration]
      ret = gemini_sata_start_bridge(sg, 0);
            ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/ata/pata_ftide010.c: In function 'pata_ftide010_gemini_port_stop':
>> drivers/ata/pata_ftide010.c:404:3: error: implicit declaration of function 'gemini_sata_stop_bridge' [-Werror=implicit-function-declaration]
      gemini_sata_stop_bridge(sg, 0);
      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/ata/pata_ftide010.c: In function 'pata_ftide010_gemini_init':
>> drivers/ata/pata_ftide010.c:438:22: error: storage size of 'muxmode' isn't known
     enum gemini_muxmode muxmode;
                         ^~~~~~~
>> drivers/ata/pata_ftide010.c:441:7: error: implicit declaration of function 'gemini_sata_bridge_get' [-Werror=implicit-function-declaration]
     sg = gemini_sata_bridge_get();
          ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/ata/pata_ftide010.c:441:5: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
     sg = gemini_sata_bridge_get();
        ^
>> drivers/ata/pata_ftide010.c:446:12: error: implicit declaration of function 'gemini_sata_get_muxmode' [-Werror=implicit-function-declaration]
     muxmode = gemini_sata_get_muxmode(sg);
               ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/ata/pata_ftide010.c:457:6: error: implicit declaration of function 'gemini_sata_bridge_enabled' [-Werror=implicit-function-declaration]
     if (gemini_sata_bridge_enabled(sg, is_ata1)) {
         ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/ata/pata_ftide010.c:469:8: error: 'GEMINI_MUXMODE_0' undeclared (first use in this function)
      case GEMINI_MUXMODE_0:
           ^~~~~~~~~~~~~~~~
   drivers/ata/pata_ftide010.c:469:8: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/ata/pata_ftide010.c:474:8: error: 'GEMINI_MUXMODE_1' undeclared (first use in this function)
      case GEMINI_MUXMODE_1:
           ^~~~~~~~~~~~~~~~
>> drivers/ata/pata_ftide010.c:479:8: error: 'GEMINI_MUXMODE_2' undeclared (first use in this function)
      case GEMINI_MUXMODE_2:
           ^~~~~~~~~~~~~~~~
>> drivers/ata/pata_ftide010.c:483:8: error: 'GEMINI_MUXMODE_3' undeclared (first use in this function)
      case GEMINI_MUXMODE_3:
           ^~~~~~~~~~~~~~~~
   drivers/ata/pata_ftide010.c:438:22: warning: unused variable 'muxmode' [-Wunused-variable]
     enum gemini_muxmode muxmode;
                         ^~~~~~~
   At top level:
   drivers/ata/pata_ftide010.c:315:12: warning: 'pata_ftide010_gemini_phy_hardreset' defined but not used [-Wunused-function]
    static int pata_ftide010_gemini_phy_hardreset(struct ata_link *link,
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/muxmode +33 drivers/ata/sata_gemini.c

    27	 * @sata0_reset: SATA0 reset handler
    28	 * @sata1_reset: SATA1 reset handler
    29	 */
    30	struct sata_gemini {
    31		struct device *dev;
    32		void __iomem *base;
  > 33		enum gemini_muxmode muxmode;
    34		bool ide_pins;
    35		bool sata_bridge;
    36		struct reset_control *sata0_reset;
    37		struct reset_control *sata1_reset;
    38		struct clk *sata0_pclk;
    39		struct clk *sata1_pclk;
    40	};
    41	
    42	/* Global IDE PAD Skew Control Register */
    43	#define GLOBAL_IDE_SKEW_CTRL		0x18
    44	#define IDE1_HOST_STROBE_DELAY_SHIFT	28
    45	#define IDE1_DEVICE_STROBE_DELAY_SHIFT	24
    46	#define IDE1_OUTPUT_IO_SKEW_SHIFT	20
    47	#define IDE1_INPUT_IO_SKEW_SHIFT	16
    48	#define IDE0_HOST_STROBE_DELAY_SHIFT	12
    49	#define IDE0_DEVICE_STROBE_DELAY_SHIFT	8
    50	#define IDE0_OUTPUT_IO_SKEW_SHIFT	4
    51	#define IDE0_INPUT_IO_SKEW_SHIFT	0
    52	
    53	/* Miscellaneous Control Register */
    54	#define GLOBAL_MISC_CTRL		0x30
    55	/*
    56	 * Values of IDE IOMUX bits in the misc control register
    57	 *
    58	 * Bits 26:24 are "IDE IO Select", which decides what SATA
    59	 * adapters are connected to which of the two IDE/ATA
    60	 * controllers in the Gemini. We can connect the two IDE blocks
    61	 * to one SATA adapter each, both acting as master, or one IDE
    62	 * blocks to two SATA adapters so the IDE block can act in a
    63	 * master/slave configuration.
    64	 *
    65	 * We also bring out different blocks on the actual IDE
    66	 * pins (not SATA pins) if (and only if) these are muxed in.
    67	 *
    68	 * 111-100 - Reserved
    69	 * Mode 0: 000 - ata0 master <-> sata0
    70	                 ata1 master <-> sata1
    71	 *               ata0 slave interface brought out on IDE pads
    72	 * Mode 1: 001 - ata0 master <-> sata0
    73	 *               ata1 master <-> sata1
    74	 *               ata1 slave interface brought out on IDE pads
    75	 * Mode 2: 010 - ata1 master <-> sata1
    76	 *               ata1 slave  <-> sata0
    77	 *               ata0 master and slave interfaces brought out
    78	 *                    on IDE pads
    79	 * Mode 3: 011 - ata0 master <-> sata0
    80	 *               ata1 slave  <-> sata1
    81	 *               ata1 master and slave interfaces brought out
    82	 *                    on IDE pads
    83	 */
    84	#define IDE_IOMUX_MASK			(7 << 24)
    85	#define IDE_IOMUX_MODE0			(0 << 24)
    86	#define IDE_IOMUX_MODE1			(1 << 24)
    87	#define IDE_IOMUX_MODE2			(2 << 24)
    88	#define IDE_IOMUX_MODE3			(3 << 24)
    89	#define IDE_IOMUX_SHIFT			(24)
    90	#define IDE_PADS_ENABLE			BIT(4)
    91	#define PFLASH_PADS_DISABLE		BIT(1)
    92	
    93	/*
    94	 * Registers directly controlling the PATA<->SATA adapters
    95	 */
    96	#define SATA_ID				0x00
    97	#define SATA_PHY_ID			0x04
    98	#define SATA0_STATUS			0x08
    99	#define SATA1_STATUS			0x0c
   100	#define SATA0_CTRL			0x18
   101	#define SATA1_CTRL			0x1c
   102	
   103	#define SATA_STATUS_BIST_DONE		BIT(5)
   104	#define SATA_STATUS_BIST_OK		BIT(4)
   105	#define SATA_STATUS_PHY_READY		BIT(0)
   106	
   107	#define SATA_CTRL_PHY_BIST_EN		BIT(14)
   108	#define SATA_CTRL_PHY_FORCE_IDLE	BIT(13)
   109	#define SATA_CTRL_PHY_FORCE_READY	BIT(12)
   110	#define SATA_CTRL_PHY_AFE_LOOP_EN	BIT(10)
   111	#define SATA_CTRL_PHY_DIG_LOOP_EN	BIT(9)
   112	#define SATA_CTRL_HOTPLUG_DETECT_EN	BIT(4)
   113	#define SATA_CTRL_ATAPI_EN		BIT(3)
   114	#define SATA_CTRL_BUS_WITH_20		BIT(2)
   115	#define SATA_CTRL_SLAVE_EN		BIT(1)
   116	#define SATA_CTRL_EN			BIT(0)
   117	
   118	/*
   119	 * There is only ever one instance of this bridge on a system,
   120	 * so create a singleton so that the FTIDE010 instances can grab
   121	 * a reference to it.
   122	 */
   123	static struct sata_gemini *sg_singleton;
   124	
   125	struct sata_gemini *gemini_sata_bridge_get(void)
   126	{
   127		if (sg_singleton)
   128			return sg_singleton;
   129		return ERR_PTR(-EPROBE_DEFER);
   130	}
   131	EXPORT_SYMBOL(gemini_sata_bridge_get);
   132	
   133	bool gemini_sata_bridge_enabled(struct sata_gemini *sg, bool is_ata1)
   134	{
   135		if (!sg->sata_bridge)
   136			return false;
   137		/*
   138		 * In muxmode 2 and 3 one of the ATA controllers is
   139		 * actually not connected to any SATA bridge.
   140		 */
 > 141		if ((sg->muxmode == GEMINI_MUXMODE_2) &&
   142		    !is_ata1)
   143			return false;
 > 144		if ((sg->muxmode == GEMINI_MUXMODE_3) &&
   145		    is_ata1)
   146			return false;
   147		return true;
   148	}
   149	EXPORT_SYMBOL(gemini_sata_bridge_enabled);
   150	
 > 151	enum gemini_muxmode gemini_sata_get_muxmode(struct sata_gemini *sg)
   152	{
 > 153		return sg->muxmode;
   154	}
   155	EXPORT_SYMBOL(gemini_sata_get_muxmode);
   156	
   157	static int gemini_sata_setup_bridge(struct sata_gemini *sg,
   158					    unsigned int bridge)
   159	{
   160		unsigned long timeout = jiffies + (HZ * 1);
   161		u32 val;
   162	
   163		if (bridge == 0) {
   164			val = SATA_CTRL_HOTPLUG_DETECT_EN | SATA_CTRL_EN;
   165			/* SATA0 slave mode is only used in muxmode 2 */
 > 166			if (sg->muxmode == GEMINI_MUXMODE_2)
   167				val |= SATA_CTRL_SLAVE_EN;
   168			writel(val, sg->base + SATA0_CTRL);
   169		} else {

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 61389 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170507/f345fbc5/attachment-0001.gz>
