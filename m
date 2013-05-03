From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 03 May 2013 13:20:07 +0200
Subject: [PATCH 1/9] ARM: tegra: Tegra114 needs CPU_FREQ_TABLE
In-Reply-To: <CAOh2x==i-_+30mmMp=WkcCQn4qm1-nGfWpPuQnScvRQVd=h+LA@mail.gmail.com>
References: <1367528578-518090-1-git-send-email-arnd@arndb.de>
 <1367528578-518090-2-git-send-email-arnd@arndb.de>
 <CAOh2x==i-_+30mmMp=WkcCQn4qm1-nGfWpPuQnScvRQVd=h+LA@mail.gmail.com>
Message-ID: <2416484.HHc7d0zNGR@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 03 May 2013 10:27:17 Viresh Kumar wrote:
> > diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
> > index 597e76b..9878503 100644
> > --- a/arch/arm/mach-tegra/Kconfig
> > +++ b/arch/arm/mach-tegra/Kconfig
> > @@ -63,6 +63,7 @@ config ARCH_TEGRA_114_SOC
> >         select ARM_ARCH_TIMER
> >         select ARM_GIC
> >         select ARM_L1_CACHE_SHIFT_6
> > +       select CPU_FREQ_TABLE if CPU_FREQ
> >         select CPU_V7
> >         select PINCTRL
> >         select PINCTRL_TEGRA114
> 
> I doubt which is the best place for doing this? This one or
> cpufreq/Kconfig.arm with select CPU_FREQ_TABLE for
> tegra?

It would be much better IMHO to have an entry for TEGRA_CPUFREQ
in drivers/cpufreq/Kcofnig.arm and move the select there. However,
creating that entry has some (small) regression potential and I
didn't want to do that now but instead just made sure that all
three Tegra SoCs do the same thing for now.

	Arnd
