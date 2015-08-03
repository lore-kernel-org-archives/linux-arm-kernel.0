From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Mon, 03 Aug 2015 17:57:36 +0200
Subject: [PATCH v3 3/5] ARM: Exynos: switch to using generic cpufreq driver
 for Exynos4x12
In-Reply-To: <20150803155041.GE21529@linux>
References: <1438368557-2352-1-git-send-email-b.zolnierkie@samsung.com>
 <2347616.SxxJmTVssu@amdc1976> <20150803155041.GE21529@linux>
Message-ID: <1560319.pWyQuLxb1l@amdc1976>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, August 03, 2015 09:20:41 PM Viresh Kumar wrote:
> On 03-08-15, 15:55, Bartlomiej Zolnierkiewicz wrote:
> > diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
> > index 81064cd..491914c 100644
> > --- a/arch/arm/mach-exynos/Kconfig
> > +++ b/arch/arm/mach-exynos/Kconfig
> > @@ -25,6 +25,8 @@ menuconfig ARCH_EXYNOS
> >  	select S5P_DEV_MFC
> >  	select SRAM
> >  	select MFD_SYSCON
> > +	select THERMAL
> > +	select EXYNOS_THERMAL
> 
> Why do you need to select both of them?

Because otherwise you can disable the whole THERMAL subsystem support
(effectively disabling EXYNOS_THERMAL in the process).

This is the same way in which ARCH_EXYNOS handles PINCTRL_EXYNOS
support currently (it also selects PINCTRL subsystem).

> >  	help
> >  	  Support for SAMSUNG EXYNOS SoCs (EXYNOS4/5)
> >  
> > diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
> > index 77ac021..1c47aee 100644
> > --- a/arch/arm/mach-exynos/exynos.c
> > +++ b/arch/arm/mach-exynos/exynos.c
> > @@ -227,6 +227,8 @@ static void __init exynos_init_irq(void)
> >  static const struct of_device_id exynos_cpufreq_matches[] = {
> >  	{ .compatible = "samsung,exynos3250", .data = "cpufreq-dt" },
> >  	{ .compatible = "samsung,exynos4210", .data = "cpufreq-dt" },
> > +	{ .compatible = "samsung,exynos4212", .data = "cpufreq-dt" },
> > +	{ .compatible = "samsung,exynos4412", .data = "cpufreq-dt" },
> >  	{ .compatible = "samsung,exynos5250", .data = "cpufreq-dt" },
> >  	{ /* sentinel */ }
> >  };
> 
> Otherwise looks fine:
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Thanks!

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
