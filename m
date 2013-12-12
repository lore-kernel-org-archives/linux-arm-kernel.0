From: olof@lixom.net (Olof Johansson)
Date: Wed, 11 Dec 2013 17:08:11 -0800
Subject: [PATCH] ARM: tegra: add missing break to fuse initialization code
In-Reply-To: <20131206210957.GC1685@mithrandir>
References: <1386362030-29187-1-git-send-email-swarren@wwwdotorg.org>
 <20131206210957.GC1685@mithrandir>
Message-ID: <20131212010811.GA21856@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 06, 2013 at 10:09:57PM +0100, Thierry Reding wrote:
> On Fri, Dec 06, 2013 at 01:33:50PM -0700, Stephen Warren wrote:
> > From: Stephen Warren <swarren@nvidia.com>
> > 
> > Add a missing break to the switch in tegra_init_fuse() which determines
> > which SoC the code is running on. This prevents the Tegra30+ fuse
> > handling code from running on Tegra20.
> > 
> > Fixes: 3bd1ae57f7bb ("ARM: tegra: add fuses as device randomness")
> > Signed-off-by: Stephen Warren <swarren@nvidia.com>
> > ---
> > This is a fix for 3.13.
> > 
> >  arch/arm/mach-tegra/fuse.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm/mach-tegra/fuse.c b/arch/arm/mach-tegra/fuse.c
> > index 9a4e910c3796..13995b0be9d9 100644
> > --- a/arch/arm/mach-tegra/fuse.c
> > +++ b/arch/arm/mach-tegra/fuse.c
> > @@ -198,6 +198,7 @@ void __init tegra_init_fuse(void)
> >  	switch (tegra_chip_id) {
> >  	case TEGRA20:
> >  		tegra20_fuse_init_randomness();
> > +		break;
> >  	case TEGRA30:
> >  	case TEGRA114:
> >  	default:
> 
> The code that follows here also doesn't have a break. While not strictly
> necessary it might be good to have one for consistency. Either way,
> though:
> 
> Reviewed-by: Thierry Reding <treding@nvidia.com>


Applied, thanks.


-Olof
