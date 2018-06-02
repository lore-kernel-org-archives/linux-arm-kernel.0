From: lkp@intel.com (kbuild test robot)
Date: Sat, 2 Jun 2018 17:01:49 +0800
Subject: [clk:clk-bcm-stingray 1/2] drivers/clk/bcm/clk-sr.c:217:3: error:
 'BCM_SR_LCPLL0_SATA_REF_CLK' undeclared here (not in a function); did you
 mean 'BCM_SR_LCPLL0_SATA_REFN_CLK'?
Message-ID: <201806021742.e6HPCQOb%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-bcm-stingray
head:   5afa881c6635427e68c73861a2c22d8cac00b984
commit: 48bf9a522c14449cc7c214c6062668ac54e4e88f [1/2] dt-bindings: clk: Update Stingray binding doc
config: sh-allmodconfig (attached as .config)
compiler: sh4-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 48bf9a522c14449cc7c214c6062668ac54e4e88f
        # save the attached .config to linux build tree
        make.cross ARCH=sh 

Note: the clk/clk-bcm-stingray HEAD 5afa881c6635427e68c73861a2c22d8cac00b984 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   drivers/clk/bcm/clk-sr.c:59:3: error: 'BCM_SR_GENPLL0_SATA_CLK' undeclared here (not in a function); did you mean 'BCM_SR_GENPLL0_SCR_CLK'?
     [BCM_SR_GENPLL0_SATA_CLK] = {
      ^~~~~~~~~~~~~~~~~~~~~~~
      BCM_SR_GENPLL0_SCR_CLK
   drivers/clk/bcm/clk-sr.c:59:3: error: array index in initializer not of integer type
   drivers/clk/bcm/clk-sr.c:59:3: note: (near initialization for 'sr_genpll0_clk')
   drivers/clk/bcm/clk-sr.c:184:3: error: 'BCM_SR_GENPLL5_FS_CLK' undeclared here (not in a function); did you mean 'BCM_SR_GENPLL2_FS4_CLK'?
     [BCM_SR_GENPLL5_FS_CLK] = {
      ^~~~~~~~~~~~~~~~~~~~~
      BCM_SR_GENPLL2_FS4_CLK
   drivers/clk/bcm/clk-sr.c:184:3: error: array index in initializer not of integer type
   drivers/clk/bcm/clk-sr.c:184:3: note: (near initialization for 'sr_genpll5_clk')
   drivers/clk/bcm/clk-sr.c:185:14: warning: initialization makes integer from pointer without a cast [-Wint-conversion]
      .channel = BCM_SR_GENPLL5_FS_CLK,
                 ^~~~~~~~~~~~~~~~~~~~~
   drivers/clk/bcm/clk-sr.c:185:14: note: (near initialization for 'sr_genpll5_clk[0].channel')
   drivers/clk/bcm/clk-sr.c:185:14: error: initializer element is not constant
   drivers/clk/bcm/clk-sr.c:185:14: note: (near initialization for 'sr_genpll5_clk[0].channel')
   drivers/clk/bcm/clk-sr.c:190:3: error: 'BCM_SR_GENPLL5_SPU_CLK' undeclared here (not in a function); did you mean 'BCM_SR_GENPLL5_FS_CLK'?
     [BCM_SR_GENPLL5_SPU_CLK] = {
      ^~~~~~~~~~~~~~~~~~~~~~
      BCM_SR_GENPLL5_FS_CLK
   drivers/clk/bcm/clk-sr.c:190:3: error: array index in initializer not of integer type
   drivers/clk/bcm/clk-sr.c:190:3: note: (near initialization for 'sr_genpll5_clk')
   drivers/clk/bcm/clk-sr.c:191:14: warning: initialization makes integer from pointer without a cast [-Wint-conversion]
      .channel = BCM_SR_GENPLL5_SPU_CLK,
                 ^~~~~~~~~~~~~~~~~~~~~~
   drivers/clk/bcm/clk-sr.c:191:14: note: (near initialization for 'sr_genpll5_clk[1].channel')
   drivers/clk/bcm/clk-sr.c:191:14: error: initializer element is not constant
   drivers/clk/bcm/clk-sr.c:191:14: note: (near initialization for 'sr_genpll5_clk[1].channel')
>> drivers/clk/bcm/clk-sr.c:217:3: error: 'BCM_SR_LCPLL0_SATA_REF_CLK' undeclared here (not in a function); did you mean 'BCM_SR_LCPLL0_SATA_REFN_CLK'?
     [BCM_SR_LCPLL0_SATA_REF_CLK] = {
      ^~~~~~~~~~~~~~~~~~~~~~~~~~
      BCM_SR_LCPLL0_SATA_REFN_CLK
   drivers/clk/bcm/clk-sr.c:217:3: error: array index in initializer not of integer type
   drivers/clk/bcm/clk-sr.c:217:3: note: (near initialization for 'sr_lcpll0_clk')
   drivers/clk/bcm/clk-sr.c:218:14: warning: initialization makes integer from pointer without a cast [-Wint-conversion]
      .channel = BCM_SR_LCPLL0_SATA_REF_CLK,
                 ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/clk/bcm/clk-sr.c:218:14: note: (near initialization for 'sr_lcpll0_clk[0].channel')
   drivers/clk/bcm/clk-sr.c:218:14: error: initializer element is not constant
   drivers/clk/bcm/clk-sr.c:218:14: note: (near initialization for 'sr_lcpll0_clk[0].channel')
   drivers/clk/bcm/clk-sr.c:223:3: error: 'BCM_SR_LCPLL0_USB_REF_CLK' undeclared here (not in a function); did you mean 'BCM_SR_LCPLL1_USB_REF_CLK'?
     [BCM_SR_LCPLL0_USB_REF_CLK] = {
      ^~~~~~~~~~~~~~~~~~~~~~~~~
      BCM_SR_LCPLL1_USB_REF_CLK
   drivers/clk/bcm/clk-sr.c:223:3: error: array index in initializer not of integer type
   drivers/clk/bcm/clk-sr.c:223:3: note: (near initialization for 'sr_lcpll0_clk')
   drivers/clk/bcm/clk-sr.c:224:14: warning: initialization makes integer from pointer without a cast [-Wint-conversion]
      .channel = BCM_SR_LCPLL0_USB_REF_CLK,
                 ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/clk/bcm/clk-sr.c:224:14: note: (near initialization for 'sr_lcpll0_clk[1].channel')
   drivers/clk/bcm/clk-sr.c:224:14: error: initializer element is not constant
   drivers/clk/bcm/clk-sr.c:224:14: note: (near initialization for 'sr_lcpll0_clk[1].channel')
>> drivers/clk/bcm/clk-sr.c:229:3: error: 'BCM_SR_LCPLL0_SATA_REFPN_CLK' undeclared here (not in a function); did you mean 'BCM_SR_LCPLL0_SATA_REFN_CLK'?
     [BCM_SR_LCPLL0_SATA_REFPN_CLK] = {
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
      BCM_SR_LCPLL0_SATA_REFN_CLK
   drivers/clk/bcm/clk-sr.c:229:3: error: array index in initializer not of integer type
   drivers/clk/bcm/clk-sr.c:229:3: note: (near initialization for 'sr_lcpll0_clk')
   drivers/clk/bcm/clk-sr.c:230:14: warning: initialization makes integer from pointer without a cast [-Wint-conversion]
      .channel = BCM_SR_LCPLL0_SATA_REFPN_CLK,
                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/clk/bcm/clk-sr.c:230:14: note: (near initialization for 'sr_lcpll0_clk[2].channel')
   drivers/clk/bcm/clk-sr.c:230:14: error: initializer element is not constant
   drivers/clk/bcm/clk-sr.c:230:14: note: (near initialization for 'sr_lcpll0_clk[2].channel')

vim +217 drivers/clk/bcm/clk-sr.c

654cdd32 Sandeep Tripathy 2017-06-06  182  
654cdd32 Sandeep Tripathy 2017-06-06  183  static const struct iproc_clk_ctrl sr_genpll5_clk[] = {
654cdd32 Sandeep Tripathy 2017-06-06  184  	[BCM_SR_GENPLL5_FS_CLK] = {
654cdd32 Sandeep Tripathy 2017-06-06  185  		.channel = BCM_SR_GENPLL5_FS_CLK,
654cdd32 Sandeep Tripathy 2017-06-06  186  		.flags = IPROC_CLK_AON,
654cdd32 Sandeep Tripathy 2017-06-06  187  		.enable = ENABLE_VAL(0x4, 6, 0, 12),
654cdd32 Sandeep Tripathy 2017-06-06  188  		.mdiv = REG_VAL(0x18, 0, 9),
654cdd32 Sandeep Tripathy 2017-06-06  189  	},
654cdd32 Sandeep Tripathy 2017-06-06 @190  	[BCM_SR_GENPLL5_SPU_CLK] = {
654cdd32 Sandeep Tripathy 2017-06-06  191  		.channel = BCM_SR_GENPLL5_SPU_CLK,
654cdd32 Sandeep Tripathy 2017-06-06  192  		.flags = IPROC_CLK_AON,
654cdd32 Sandeep Tripathy 2017-06-06  193  		.enable = ENABLE_VAL(0x4, 6, 0, 12),
654cdd32 Sandeep Tripathy 2017-06-06  194  		.mdiv = REG_VAL(0x18, 10, 9),
654cdd32 Sandeep Tripathy 2017-06-06  195  	},
654cdd32 Sandeep Tripathy 2017-06-06  196  };
654cdd32 Sandeep Tripathy 2017-06-06  197  
654cdd32 Sandeep Tripathy 2017-06-06  198  static int sr_genpll5_clk_init(struct platform_device *pdev)
654cdd32 Sandeep Tripathy 2017-06-06  199  {
654cdd32 Sandeep Tripathy 2017-06-06  200  	iproc_pll_clk_setup(pdev->dev.of_node,
654cdd32 Sandeep Tripathy 2017-06-06  201  			    &sr_genpll5, NULL, 0, sr_genpll5_clk,
654cdd32 Sandeep Tripathy 2017-06-06  202  			    ARRAY_SIZE(sr_genpll5_clk));
654cdd32 Sandeep Tripathy 2017-06-06  203  	return 0;
654cdd32 Sandeep Tripathy 2017-06-06  204  }
654cdd32 Sandeep Tripathy 2017-06-06  205  
654cdd32 Sandeep Tripathy 2017-06-06  206  static const struct iproc_pll_ctrl sr_lcpll0 = {
654cdd32 Sandeep Tripathy 2017-06-06  207  	.flags = IPROC_CLK_AON | IPROC_CLK_PLL_NEEDS_SW_CFG,
654cdd32 Sandeep Tripathy 2017-06-06  208  	.aon = AON_VAL(0x0, 2, 19, 18),
654cdd32 Sandeep Tripathy 2017-06-06  209  	.reset = RESET_VAL(0x0, 31, 30),
654cdd32 Sandeep Tripathy 2017-06-06  210  	.sw_ctrl = SW_CTRL_VAL(0x4, 31),
654cdd32 Sandeep Tripathy 2017-06-06  211  	.ndiv_int = REG_VAL(0x4, 16, 10),
654cdd32 Sandeep Tripathy 2017-06-06  212  	.pdiv = REG_VAL(0x4, 26, 4),
654cdd32 Sandeep Tripathy 2017-06-06  213  	.status = REG_VAL(0x38, 12, 1),
654cdd32 Sandeep Tripathy 2017-06-06  214  };
654cdd32 Sandeep Tripathy 2017-06-06  215  
654cdd32 Sandeep Tripathy 2017-06-06  216  static const struct iproc_clk_ctrl sr_lcpll0_clk[] = {
654cdd32 Sandeep Tripathy 2017-06-06 @217  	[BCM_SR_LCPLL0_SATA_REF_CLK] = {
654cdd32 Sandeep Tripathy 2017-06-06  218  		.channel = BCM_SR_LCPLL0_SATA_REF_CLK,
654cdd32 Sandeep Tripathy 2017-06-06  219  		.flags = IPROC_CLK_AON,
654cdd32 Sandeep Tripathy 2017-06-06  220  		.enable = ENABLE_VAL(0x0, 7, 1, 13),
654cdd32 Sandeep Tripathy 2017-06-06  221  		.mdiv = REG_VAL(0x14, 0, 9),
654cdd32 Sandeep Tripathy 2017-06-06  222  	},
654cdd32 Sandeep Tripathy 2017-06-06 @223  	[BCM_SR_LCPLL0_USB_REF_CLK] = {
654cdd32 Sandeep Tripathy 2017-06-06  224  		.channel = BCM_SR_LCPLL0_USB_REF_CLK,
654cdd32 Sandeep Tripathy 2017-06-06  225  		.flags = IPROC_CLK_AON,
654cdd32 Sandeep Tripathy 2017-06-06  226  		.enable = ENABLE_VAL(0x0, 8, 2, 14),
654cdd32 Sandeep Tripathy 2017-06-06  227  		.mdiv = REG_VAL(0x14, 10, 9),
654cdd32 Sandeep Tripathy 2017-06-06  228  	},
654cdd32 Sandeep Tripathy 2017-06-06 @229  	[BCM_SR_LCPLL0_SATA_REFPN_CLK] = {
654cdd32 Sandeep Tripathy 2017-06-06  230  		.channel = BCM_SR_LCPLL0_SATA_REFPN_CLK,
654cdd32 Sandeep Tripathy 2017-06-06  231  		.flags = IPROC_CLK_AON,
654cdd32 Sandeep Tripathy 2017-06-06  232  		.enable = ENABLE_VAL(0x0, 9, 3, 15),
654cdd32 Sandeep Tripathy 2017-06-06  233  		.mdiv = REG_VAL(0x14, 20, 9),
654cdd32 Sandeep Tripathy 2017-06-06  234  	},
654cdd32 Sandeep Tripathy 2017-06-06  235  };
654cdd32 Sandeep Tripathy 2017-06-06  236  

:::::: The code at line 217 was first introduced by commit
:::::: 654cdd3229cd1d3f2bfb9df57baf88ba382a52be clk: bcm: Add clocks for Stingray SOC

:::::: TO: Sandeep Tripathy <sandeep.tripathy@broadcom.com>
:::::: CC: Stephen Boyd <sboyd@codeaurora.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 47758 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180602/d7e73bfe/attachment-0001.gz>
