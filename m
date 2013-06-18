From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 18 Jun 2013 11:31:47 +0200
Subject: [PATCH v2 30/38] ARM: EXYNOS: Remove CONFIG_SOC_EXYNOS4412
In-Reply-To: <1b9901ce6c04$9f4ff710$ddefe530$%kim@samsung.com>
References: <1371486863-12398-1-git-send-email-t.figa@samsung.com>
 <1371486863-12398-31-git-send-email-t.figa@samsung.com>
 <1b9901ce6c04$9f4ff710$ddefe530$%kim@samsung.com>
Message-ID: <3925237.eNXRl09cCa@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

On Tuesday 18 of June 2013 18:17:14 Kukjin Kim wrote:
> Tomasz Figa wrote:
> > Exynos4212 and Exynos4412 SoCs differ only in number of ARM cores and
> > there is no need to have separate Kconfig options for them, since they
> > use the same code.
> > 
> > This patch removes CONFIG_SOC_EXYNOS4412, leaving CONFIG_SOC_EXYNOS4212
> > as the one supporting both SoCs from this series.
> > 
> > Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > ---
> > 
> >  arch/arm/mach-exynos/Kconfig             | 11 +----------
> >  arch/arm/plat-samsung/include/plat/cpu.h |  6 +-----
> >  2 files changed, 2 insertions(+), 15 deletions(-)
> > 
> > diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
> > index 65ca3ac..fcebdfb 100644
> > --- a/arch/arm/mach-exynos/Kconfig
> > +++ b/arch/arm/mach-exynos/Kconfig
> > @@ -46,7 +46,7 @@ config CPU_EXYNOS4210
> > 
> >  	  Enable EXYNOS4210 CPU support
> >  
> >  config SOC_EXYNOS4212
> > 
> > -	bool "SAMSUNG EXYNOS4212"
> > +	bool "SAMSUNG EXYNOS4212/4412"
> > 
> >  	default y
> >  	depends on ARCH_EXYNOS4
> >  	select PINCTRL_EXYNOS
> > 
> > @@ -56,15 +56,6 @@ config SOC_EXYNOS4212
> > 
> >  	help
> >  	
> >  	  Enable EXYNOS4212 SoC support
> > 
> > -config SOC_EXYNOS4412
> > -	bool "SAMSUNG EXYNOS4412"
> > -	default y
> > -	depends on ARCH_EXYNOS4
> > -	select PINCTRL_EXYNOS
> > -	select SAMSUNG_DMADEV
> > -	help
> > -	  Enable EXYNOS4412 SoC support
> > -
> 
> NAK, I'm still saying we need separation of exynos4212 and exynos4412
> because there are differences, it is not implemented yet but will be
> implemented in future. So would be helpful if we could keep them.

Sorry, but I don't understand how a Kconfig entry is related to separation of 
those SoCs. It just selects which code needs to be compiled in, not what code 
should be executed - this selection is done based on DeviceTree.

Could you give a bit more in depth explanation for this?

Best regards,
Tomasz
