From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 27 Apr 2012 20:54:52 +0800
Subject: [PATCH 16/17] ARM: tegra: use machine specific hook for late init
In-Reply-To: <4F996F15.5010908@wwwdotorg.org>
References: <1335454725-13089-1-git-send-email-shawn.guo@linaro.org>
 <1335454725-13089-17-git-send-email-shawn.guo@linaro.org>
 <4F996F15.5010908@wwwdotorg.org>
Message-ID: <20120427125450.GZ2234@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 26, 2012 at 09:51:49AM -0600, Stephen Warren wrote:
> On 04/26/2012 09:38 AM, Shawn Guo wrote:
> 
> BTW, it'd be useful to CC everyone on the cover letter for context.
> 
Yes, thanks for the reminding.  Will do in the future.

> I think this mostly looks fine, except for one issue below:
> 
> > diff --git a/arch/arm/mach-tegra/common.c b/arch/arm/mach-tegra/common.c
> 
> > +void __init tegra_init_late(void)
> > +{
> > +	tegra_clk_debugfs_init();
> > +	tegra_pinmux_debuginit();
> 
> That function has been removed ...
> 
> > +	tegra_powergate_debugfs_init();
> > +}
> 
> > diff --git a/arch/arm/mach-tegra/pinmux.c b/arch/arm/mach-tegra/pinmux.c
> 
> ... because this whole file will be deleted in 3.5; see
> git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git
> gpio-pinmux
> 
> I'm not sure if you want to remove that part of this patch to make it
> merge more easily?

Sure.  Will remove that part from the patch.

-- 
Regards,
Shawn
