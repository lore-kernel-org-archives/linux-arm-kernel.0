From: will.deacon@arm.com (Will Deacon)
Date: Thu, 28 Jan 2016 11:08:20 +0000
Subject: [PATCH] arm64: Disallow combination of ARCH_XGENE and 16K page
 size
In-Reply-To: <20160128103441.GS14823@e104818-lin.cambridge.arm.com>
References: <1453936230-7305-1-git-send-email-dann.frazier@canonical.com>
 <20160128103441.GS14823@e104818-lin.cambridge.arm.com>
Message-ID: <20160128110820.GE30928@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 28, 2016 at 10:34:41AM +0000, Catalin Marinas wrote:
> On Wed, Jan 27, 2016 at 04:10:30PM -0700, dann frazier wrote:
> > 16K page size is an optional feature of the architecture, and is not
> > supported by the X-Gene SoC family.
> > 
> > Signed-off-by: dann frazier <dann.frazier@canonical.com>
> > ---
> >  arch/arm64/Kconfig.platforms | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> > index 21074f6..b241290 100644
> > --- a/arch/arm64/Kconfig.platforms
> > +++ b/arch/arm64/Kconfig.platforms
> > @@ -133,6 +133,7 @@ config ARCH_VEXPRESS
> >  
> >  config ARCH_XGENE
> >  	bool "AppliedMicro X-Gene SOC Family"
> > +	depends on !ARM64_16K_PAGES
> >  	help
> >  	  This enables support for AppliedMicro X-Gene SOC Family
> 
> This would be the case on Juno as well. But maybe at some point the
> X-Gene family would gain a CPU with such support.
> 
> Anyway, I would rather make 16K pages depend on EXPERT, make it a bit
> harder to enable. We've had a few questions recently about enabling it
> on CPUs that don't have such feature.

I thought there was also a suggestion that we could fail gracefully in
the EFI stub if we detected an unsupported page size?

Will
