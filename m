From: tony@atomide.com (Tony Lindgren)
Date: Tue, 10 Jul 2012 06:39:04 -0700
Subject: [GIT PULL] two omap fixes for v3.5-rc6
In-Reply-To: <20120710133621.GW1122@atomide.com>
References: <20120710133621.GW1122@atomide.com>
Message-ID: <20120710133904.GX1122@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [120710 06:41]:
> The following changes since commit fa2976a811a764573b2a9c79126d4d66f1f16268:
> 
>   Merge tag 'omap-fixes-b-for-3.5rc' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into fixes (2012-07-05 01:12:08 -0700)
> 
> are available in the git repository at:
> 
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap fixes

Looks like the signed tag did not yet get mirrored, it's at:

git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-fixes-for-v3.5-rc6
 
> for you to fetch changes up to 06b4ba529528fbf9c24ce37b7618f4b0264750e2:
> 
>   ARM: OMAP2+: omap2plus_defconfig: EHCI driver is not stable, disable it (2012-07-09 01:15:07 -0700)
> 
> ----------------------------------------------------------------
> Here is one PM regression fix and a defconfig change to disable
> echi-omap because the driver currently causes issues with PM.
> This annoys Kevin as it makes it harder for him to validate that
> PM is working. The proper fixes for the echi-omap are being
> discussed, but looks like it will not be properly working with PM
> until in v3.7.
> 
> ----------------------------------------------------------------
> Kevin Hilman (1):
>       ARM: OMAP2+: omap2plus_defconfig: EHCI driver is not stable, disable it
> 
> Paul Walmsley (1):
>       ARM: OMAP2+: hwmod code/clockdomain data: fix 32K sync timer
> 
> Tony Lindgren (1):
>       Merge branch 'for_3.5/fixes/pm-3' of git://git.kernel.org/.../khilman/linux-omap-pm into fixes
> 
>  arch/arm/configs/omap2plus_defconfig             |    1 -
>  arch/arm/mach-omap2/clockdomain.h                |    4 +++
>  arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c |    1 +
>  arch/arm/mach-omap2/clockdomains44xx_data.c      |    2 +-
>  arch/arm/mach-omap2/omap_hwmod.c                 |   32 ++++++++++++++++------
>  5 files changed, 30 insertions(+), 10 deletions(-)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
