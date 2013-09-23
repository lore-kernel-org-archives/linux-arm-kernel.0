From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 23 Sep 2013 14:34:54 +0200
Subject: [PATCH] ARM: EXYNOS: remove CONFIG_MACH_EXYNOS[4,5]_DT config
 options
In-Reply-To: <1732670.G7NvXXJtxF@amdc1032>
References: <3809234.0NkWBIjRC9@amdc1032> <2298139.uMOnikAvfC@amdc1227>
 <1732670.G7NvXXJtxF@amdc1032>
Message-ID: <1773131.OsQeaPpRlR@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 23 of September 2013 12:23:51 Bartlomiej Zolnierkiewicz wrote:
> Hi Tomek,
> 
> On Tuesday, September 17, 2013 12:45:21 PM Tomasz Figa wrote:
> > Hi Bart,
[snip]
> > > +	select ARM_AMBA
> > > +	select CLKSRC_OF
> > > +	select CLKSRC_SAMSUNG_PWM if CPU_EXYNOS4210
> > > +	select CPU_EXYNOS4210
> > 
> > The line above shows the brokenness of current layout of Exynos Kconfig
> > options. You need to select some SoC in SAMSUNG EXYNOS4, because
> > otherwise the build will fail if user doesn't select at least one of
> > Exynos4 SoCs.
> > 
> > Instead, I would hide the ARCH_EXYNOS4 and ARCH_EXYNOS4 options and
> > select them from entries of particular SoCs, i.e. ARCH_EXYNOS4 would
> > be selected by CPU_EXYNOS4210, SOC_EXYNOS4212 and SOC_EXYNOS4412,
> > ARCH_EXYNOS5 by SOC_EXYNOS5250 and SOC_EXYNOS5420 and so on.
> 
> This is a good idea but I think that it is better to address it later in
> an incremental patch (which I will also do unless someone beats me to
> it).

OK, sounds good. I take your word for it. ;)

Acked-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz
