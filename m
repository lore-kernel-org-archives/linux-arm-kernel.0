From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 04 Mar 2015 21:13:32 +0100
Subject: [GIT PULL 1/2] Samsung fixes-1 for v4.0
In-Reply-To: <5506858.hZnoOahndE@amdc1032>
References: <54F4B250.5080200@kernel.org> <1651242.NSDETIvUSP@amdc1032>
 <5506858.hZnoOahndE@amdc1032>
Message-ID: <3844945.fqZoGxPksl@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 03 March 2015 17:23:52 Bartlomiej Zolnierkiewicz wrote:
> On Tuesday, March 03, 2015 04:48:39 PM Bartlomiej Zolnierkiewicz wrote:
> > On Tuesday, March 03, 2015 03:56:16 AM Kukjin Kim wrote:
> > > The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:
> > > 
> > >   Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)
> > > 
> > > are available in the git repository at:
> > > 
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> > > tags/samsung-fixes-1
> > > 
> > > for you to fetch changes up to 8a68de64e984cfc49ecc22ac18155a7fe6dbbfaf:
> > > 
> > >   ARM: EXYNOS: fix exynos randconfig build error (2015-03-03 03:37:57 +0900)
> > > 
> > > ----------------------------------------------------------------
> > > Samsung fixes for v4.0
> > > 
> > > - fix exynos randconfig build error with SMP=n
> > > - fix wrong hwirq of RTC interrupt for exynos3250
> > > - fix usage of LDREX and STREX after disabling cache coherency
> > > 
> > > ----------------------------------------------------------------
> > > Chanwoo Choi (1):
> > >       ARM: EXYNOS: Fix wrong hwirq of RTC interrupt for Exynos3250 SoC

Question: why doesn't the number come from DT?

> > > Krzysztof Kozlowski (1):
> > >       ARM: EXYNOS: Don't use LDREX and STREX after disabling cache coherency

I suppose the right long-term fix would be to kill off those soc_is_exynos*
macros as well, and derive the right set of SMP operations from the machine
descriptor that would then use the top-level compatible string to match
the machine.

> > > Russell King (1):
> > >       ARM: EXYNOS: fix exynos randconfig build error
> > 
> > Has anyone actually tested this patch with SMP=n && PM_SLEEP=y
> > or SMP=n && CONFIG_ARM_EXYNOS_CPUIDLE=y?
> > 
> > The patch is just insufficient as it prevents build of
> 
> By insufficient here I mean compeltely bogus.  I don't mean to be rude
> howeover since the wrong patch was picked please let me explain it in
> more technical details.

Thanks for the detailed analysis. I noticed the same thing earlier
when it showed up in linux-next. I've done a partial merge now
and took only the other two patches, which seem necessary.

	Arnd
