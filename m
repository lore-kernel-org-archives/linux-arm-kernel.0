From: tony@atomide.com (Tony Lindgren)
Date: Sun, 1 Jul 2012 02:39:49 -0700
Subject: [GIT PULL 2/6] omap cleanup for v3.6 merge window
In-Reply-To: <E1SlGGy-0003tf-Lc@merlin.infradead.org>
References: <pull-1341133277-501333> <E1SlGGy-0003tf-Lc@merlin.infradead.org>
Message-ID: <20120701093949.GM4202@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [120701 02:28]:
> The following changes since commit 6b16351acbd415e66ba16bf7d473ece1574cf0bc:
> 
>   Linux 3.5-rc4 (2012-06-24 12:53:04 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-cleanup-for-v3.6
> 
> for you to fetch changes up to 472fd5401561f94698f4c8f9dbbbfbf76ab55626:
> 
>   Merge branch 'cleanup-hwmod' into cleanup (2012-06-28 05:47:01 -0700)
> 
> ----------------------------------------------------------------
> 
> Here is some more omap clean-up. The biggest changes are
> hwmod, clock, and System Control Module cleanup, and the removal
> of the last instance of omap_read/write usage for omap2+ with
> the removal of unused USB OHCI Full Speed driver support. The
> removed OHCI is only currently used for omap1 as the actively
> used omap2+ boards have either MUSB or another instance of
> OHCI+EHCI that's more usable.
> 
> ----------------------------------------------------------------

This one has a merge conflict with the non-critical fixes in 1/6
of this series that can be resolved as below.

Tony

--- a/arch/arm/mach-omap2/clockdomains3xxx_data.c
+++ b/arch/arm/mach-omap2/clockdomains3xxx_data.c
@@@ -452,15 -345,20 +452,14 @@@ static struct clkdm_autodep clkdm_am35x
   *
   */
  
 -static struct clockdomain *clockdomains_omap3430_common[] __initdata = {
 +static struct clockdomain *clockdomains_common[] __initdata = {
  	&wkup_common_clkdm,
- 	&cm_common_clkdm,
- 	&prm_common_clkdm,
+ 	&mpu_3xxx_clkdm,
  	&neon_clkdm,
 -	&iva2_clkdm,
 -	&d2d_clkdm,
  	&core_l3_3xxx_clkdm,
  	&core_l4_3xxx_clkdm,
 -	&dss_3xxx_clkdm,
 -	&cam_clkdm,
 -	&per_clkdm,
  	&emu_clkdm,
  	&dpll1_clkdm,
 -	&dpll2_clkdm,
  	&dpll3_clkdm,
  	&dpll4_clkdm,
  	NULL
