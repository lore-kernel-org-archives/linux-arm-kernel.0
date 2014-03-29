From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 29 Mar 2014 02:54:16 +0100
Subject: [GIT PULL 3/4] Samsung PM updates for v3.15
In-Reply-To: <532B6C70.6060002@samsung.com>
References: <532B6C70.6060002@samsung.com>
Message-ID: <201403290254.16473.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 20 March 2014, Kukjin Kim wrote:
> Samsung PM related 2nd updates for v3.15
> 
>  From Tomasz Figa <t.figa@samsung.com>:
> Current Samsung PM code is heavily unprepared for multiplatform
> systems. The design implies accessing functions and global
> variables defined in particular mach- subdirectory from common
> code in plat-, which is not allowed when building ARCH_MULTIPLATFORM.
> In addition there is a lot of forced code unification, which makes
> common function handle any possible quirks of all supported SoCs.
> In the end this design turned out to not work too well, ending with
> a lot of empty functions exported from mach-, just because code in
> common pm.c calls them. Moreover, recent trend of moving lower level
> suspend/resume code to proper drivers, like pinctrl or clk, made a
> lot of code there redundant, especially on DT-only platforms like
> Exynos.
> 
> Note that this branch is based on previous tags/samsung-pm-1 and merge
> tags/samsung-cleanup-2 because of fix build error from recent changes
> of <linux/serial_s3c.h>
> 

Merged into next/cleanup3, thanks

	Arnd
