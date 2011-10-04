From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 04 Oct 2011 21:45:11 +0900
Subject: [PATCH] ARM: EXYNOS: Add ARCH_EXYNOS and reorganize
	arch/arm/mach-exynos
In-Reply-To: <3709260.I9R44Iti1S@wuerfel>
References: <001f01cc80e5$3abd1c80$b0375580$%kim@samsung.com>
	<5785830.Sj7W4aL3qy@wuerfel> <4E89AD44.80609@samsung.com>
	<3709260.I9R44Iti1S@wuerfel>
Message-ID: <019101cc8293$74796d20$5d6c4760$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann wrote:
> 
> On Monday 03 October 2011 21:40:36 Kukjin Kim wrote:
> > Yes, absolutely. As I said, the 'mach-exynos' can support upcoming
> > Samsung EXYNOS SoCs and the way is better than making mach-exynos5.
> >
> > My bigger plan is finally to make current directories to 3 mach- dir.
> > (mach-s3c, mach-s5p, and mach-exynos) and 1 plat-samsung directory. Of
> > course, the mach- directories can be reduced later.
> >
> > Firstly, as you can see, I'm merging plat-s3c24xx and plat-s5p into one
> > plat-samsung directory and actually the <plat/*.h> files and dev-*.c
> > files have been moved into plat-samsung. Maybe I can finish it during
> > 3.2-rc.
> 
> Ok, sounds good. So for my understanding: is s5p a completely separate
> line from exynos, or are they more of an evolutionary succession where
> you draw the line between the last uniprocessor and the first SMP
> chip?
> 
As you know, Samsung has announced 'EXYNOS' as a new Samsung SoC name then
we have used it. Frankly, I'm not sure the name of 'S5P' will be used later
or not. If any updates let you know.

> > Secondary, upcoming Samsung EXYNOS SoCs will be supported in mach-exynos
> > directory and this patch is required to that. For example, the EXYNOS5
> > SoCs (Cortex A15) will be supported in that with other EXYNOS4 SoCs soon
> > and of course it reduces code duplication
> 
> My feeling is that it would be nicer to just add exynos5 to the mach-
exynos4
> directory for now, in the same way that omap3/4/5 are in the mach-omap2
> directory. We can do a big rename later once the reorganization of code
> within those directories that you explained above is complete.
> 
> If you still want to do the big rename right now, I would suggest doing
> it at the end of the 3.2 merge window, so that all other patches that
> might need to touch the mach-exynos4 directory can go in first.
> 
Thanks for your suggestion.
OK, I will and it will be sent to upstream via arm-soc at the end of the
3.2 merge window.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
