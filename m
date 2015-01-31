From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 31 Jan 2015 23:37:01 +0100
Subject: [PATCH 3/3] cpufreq: exynos: allow modular build
In-Reply-To: <20150130215118.GA14374@developer.amazonguestwifi.org>
References: <1422451015-390439-1-git-send-email-arnd@arndb.de>
 <5048920.rXbXJT1FvO@wuerfel>
 <20150130215118.GA14374@developer.amazonguestwifi.org>
Message-ID: <2204000.ofqAym34Rh@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 30 January 2015 17:51:24 Eduardo Valentin wrote:
> > > @@ -90,6 +84,20 @@ config ARM_EXYNOS_CPU_FREQ_BOOST_SW
> > >  
> > >       If in doubt, say N.
> > >  
> > > +config ARM_EXYNOS5440_CPUFREQ
> > > +   bool "SAMSUNG EXYNOS5440"
> > > +   depends on SOC_EXYNOS5440
> > > +   depends on HAVE_CLK && OF
> > > +   select PM_OPP
> > > +   default y
> > > +   help
> > > +     This adds the CPUFreq driver for Samsung EXYNOS5440
> > > +     SoC. The nature of exynos5440 clock controller is
> > > +     different than previous exynos controllers so not using
> > > +     the common exynos framework.
> > > +
> > > +     If in doubt, say N.
> > 
> > I believe this one also has to be tristate, for the same reason.
> > 
> 
> I agree with you that it is better if we make it tristate. So, on my
> side, I have no concerns changing it to tristate.
> 
> However, the exynos5440 cpufreq driver does not depend on of thermal as
> of today, and therefore, I did not touch this driver for this matter.
> Meaning, if it is not causing troubles, no need to mess with it.
> 
> But I can add this change. No issues, on my side.

Sorry, my mistake. I remembered incorrectly that the problem was
in both modules, but you are right that it does not exist in the exynos5440
one. It is not a mistake to turn this into tristate, but there is no
immediate neeed, so either version is fine.

	Arnd
