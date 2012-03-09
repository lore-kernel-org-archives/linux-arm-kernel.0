From: tony@atomide.com (Tony Lindgren)
Date: Thu, 8 Mar 2012 17:40:16 -0800
Subject: [GIT PULL] ARM: OMAP2+: hwmod data: cleanup in preparation for
 link array removal
In-Reply-To: <alpine.DEB.2.00.1203072102150.21662@utopia.booyaka.com>
References: <alpine.DEB.2.00.1203072102150.21662@utopia.booyaka.com>
Message-ID: <20120309014016.GC12083@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

* Paul Walmsley <paul@pwsan.com> [120307 19:34]:
> Hi Tony
> 
> The following changes since commit b8a633451951d149494076393698880453bf6bfe:
> 
>   ARM: OMAP: hwmod: add softreset delay field and OMAP4 data (2012-02-28 03:46:31 -0700)
> 
> are available in the git repository at:
> 
>   git://git.pwsan.com/linux-2.6 hwmod_data_cleanup_3.4
> 
> for you to fetch changes up to a2d4b88dd32b02e8b5088e0d64b3c102c0852210:
> 
>   ARM: OMAP2+: hwmod: extend OCP_* register offsets from 16 to 32 bits (2012-02-28 03:49:34 -0700)
> 
> (This branch is based on the 'hwmod_code_cleanup_3.4' branch, pull req 
> sent previously)

Got these now merged into l-o master, but ran into a merge
conflict with already queued sr branch. Resolved it by using
your version except left out vdd_name. As the namings have
changed for smartreflex, now I suspect it's broken for the
interrupts..

Care to take a look and see how we should deal with this?
My merge resolution below for reference.

Regards,

Tony


--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@@ -2684,9 -2736,10 +2736,9 @@@ static struct omap_hwmod_ocp_if *omap34
  };
  
  static struct omap_hwmod omap34xx_sr1_hwmod = {
- 	.name		= "sr1_hwmod",
+ 	.name		= "sr1",
  	.class		= &omap34xx_smartreflex_hwmod_class,
  	.main_clk	= "sr1_fck",
 -	.vdd_name	= "mpu_iva",
  	.prcm		= {
  		.omap2 = {
  			.prcm_reg_id = 1,
@@@ -2703,10 -2754,15 +2753,14 @@@
  	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
  };
  
+ static struct omap_hwmod_ocp_if *omap36xx_sr1_slaves[] = {
+ 	&omap36xx_l4_core__sr1,
+ };
+ 
  static struct omap_hwmod omap36xx_sr1_hwmod = {
- 	.name		= "sr1_hwmod",
+ 	.name		= "sr1",
  	.class		= &omap36xx_smartreflex_hwmod_class,
  	.main_clk	= "sr1_fck",
 -	.vdd_name	= "mpu_iva",
  	.prcm		= {
  		.omap2 = {
  			.prcm_reg_id = 1,
@@@ -2732,9 -2782,10 +2780,9 @@@ static struct omap_hwmod_ocp_if *omap34
  };
  
  static struct omap_hwmod omap34xx_sr2_hwmod = {
- 	.name		= "sr2_hwmod",
+ 	.name		= "sr2",
  	.class		= &omap34xx_smartreflex_hwmod_class,
  	.main_clk	= "sr2_fck",
 -	.vdd_name	= "core",
  	.prcm		= {
  		.omap2 = {
  			.prcm_reg_id = 1,
@@@ -2751,10 -2800,15 +2797,14 @@@
  	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
  };
  
+ static struct omap_hwmod_ocp_if *omap36xx_sr2_slaves[] = {
+ 	&omap36xx_l4_core__sr2,
+ };
+ 
  static struct omap_hwmod omap36xx_sr2_hwmod = {
- 	.name		= "sr2_hwmod",
+ 	.name		= "sr2",
  	.class		= &omap36xx_smartreflex_hwmod_class,
  	.main_clk	= "sr2_fck",
 -	.vdd_name	= "core",
  	.prcm		= {
  		.omap2 = {
  			.prcm_reg_id = 1,
