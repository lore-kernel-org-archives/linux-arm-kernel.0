From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 13 Jan 2016 21:43:07 +0100
Subject: [PATCH V4 16/16] ARM64: tegra: select PM_GENERIC_DOMAINS
In-Reply-To: <20160113170324.GO2588@ulmo>
References: <1449241037-22193-1-git-send-email-jonathanh@nvidia.com>
 <1449241037-22193-17-git-send-email-jonathanh@nvidia.com>
 <20160113170324.GO2588@ulmo>
Message-ID: <8579242.omBpg1aLr2@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 13 January 2016 18:03:24 Thierry Reding wrote:
> On Fri, Dec 04, 2015 at 02:57:17PM +0000, Jon Hunter wrote:
> > Enable PM_GENERIC_DOMAINS for tegra 64-bit devices. To ensure that devices
> > dependent upon a particular power-domain are only probed when that power
> > domain has been powered up, requires that PM is made mandatory for tegra
> > 64-bit devices and so select this option for tegra as well.
> > 
> > Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> > ---
> >  arch/arm64/Kconfig.platforms | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> > index 9806324fa215..e0b5bd0aff0f 100644
> > --- a/arch/arm64/Kconfig.platforms
> > +++ b/arch/arm64/Kconfig.platforms
> > @@ -93,6 +93,8 @@ config ARCH_TEGRA
> >       select GENERIC_CLOCKEVENTS
> >       select HAVE_CLK
> >       select PINCTRL
> > +     select PM
> > +     select PM_GENERIC_DOMAINS
> >       select RESET_CONTROLLER
> >       help
> >         This enables support for the NVIDIA Tegra SoC family.
> 
> This has potential consequences for multi-platform builds, doesn't it?
> All of a sudden any combination of builds that includes Tegra won't be
> possible to build without PM support.
> 
> Adding linux-arm-kernel at lists.infradead.org for visibility.
> 
> 

Agreed, it would be better to add 'depends on PM_GENERIC_DOMAINS'
dependencies in the drivers that require it.

	Arnd
