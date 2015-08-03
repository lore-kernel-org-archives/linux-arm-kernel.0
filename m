From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Mon, 03 Aug 2015 12:17:51 +0200
Subject: [PATCH v3 3/5] ARM: Exynos: switch to using generic cpufreq driver
 for Exynos4x12
In-Reply-To: <20150801111721.GI899@linux>
References: <1438368557-2352-1-git-send-email-b.zolnierkie@samsung.com>
 <1438368557-2352-4-git-send-email-b.zolnierkie@samsung.com>
 <20150801111721.GI899@linux>
Message-ID: <5201904.0cZWHobiJs@amdc1976>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On Saturday, August 01, 2015 04:47:21 PM Viresh Kumar wrote:
> On 31-07-15, 20:49, Bartlomiej Zolnierkiewicz wrote:
> > diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> > index 659879a..bf6d596 100644
> > --- a/drivers/cpufreq/Kconfig
> > +++ b/drivers/cpufreq/Kconfig
> > @@ -191,6 +191,7 @@ config CPUFREQ_DT
> >  	# if CPU_THERMAL is on and THERMAL=m, CPUFREQ_DT cannot be =y:
> >  	depends on !CPU_THERMAL || THERMAL
> >  	select PM_OPP
> > +	select EXYNOS_THERMAL if ARCH_EXYNOS
> >  	help
> >  	  This adds a generic DT based cpufreq driver for frequency management.
> >  	  It supports both uniprocessor (UP) and symmetric multiprocessor (SMP)
> 
> No, we shouldn't pollute generic Kconfig options with platform specific stuff.

The old code depended on this.  You couldn't enable boost support
without enabling thermal support (ARM_EXYNOS_CPU_FREQ_BOOST_SW
config option selected EXYNOS_THERMAL).

> Why don't you enable thermal in your .config?

It is enabled in exynos_defconfig but without the above change it
can disabled manually which is something that we don't want.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
