From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 6 Nov 2011 16:19:35 +0100
Subject: [GIT PULL] Samsung Exynos for v3.2
In-Reply-To: <4EB61826.4070601@samsung.com>
References: <02dd01cc9b4e$0cb27c80$26177580$%kim@samsung.com>
 <4EB61826.4070601@samsung.com>
Message-ID: <201111061619.36283.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 06 November 2011, Kukjin Kim wrote:
> As I replied, I re-based 'next-samsung-exynos' based on latest mainline.
> 
> So changes since previous pull request:
> 
> The following changes since commit c861cd3e92d92ae946e19099f198018fcb4fd887:
> 
>    Merge branch 'next/devel2' of 
> git://git.linaro.org/people/arnd/arm-soc (2011-11-05 18:21:21 -0700)
> 
> are available in the git repository at:
> 
>    git://github.com/kgene/linux-samsung.git next-samsung-exynos
> 
> Others same, if any problems, please kindly let me know.

Ok, looks good. I'll forward the pull request right away.

One thing that I noticed in your new Kconfig file is this however:

| choice
|         prompt "EXYNOS System Type"
|         default ARCH_EXYNOS4
| config ARCH_EXYNOS4
|         bool "SAMSUNG EXYNOS4"
|         help
|           Samsung EXYNOS4 SoCs based systems
| endchoice

This looks like the idea is to make the future EXYNOS5 and later SoCs a
separate "choice" that is mutually exclusive with EXYNOS4.

This seems to be a significant limitation considering that we are working
hard on making all platforms coexist in the same kernel binary.

Are there strong technical reasons why you could not build EXYNOS4 and
EXYNOS5 into a combined kernel? If this is at all possible, I would
recommend trying hard to do it when you add EXYNOS5.

	Arnd
