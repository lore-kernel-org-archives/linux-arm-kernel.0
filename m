From: olof@lixom.net (Olof Johansson)
Date: Sat, 9 Aug 2014 08:24:52 -0700
Subject: [PATCH v5][next-20140804] ARM: EXYNOS: Fix suspend/resume
 sequences
In-Reply-To: <6342975.PHG2cX2jjn@amdc1032>
References: <6342975.PHG2cX2jjn@amdc1032>
Message-ID: <20140809152452.GC5053@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 05, 2014 at 02:43:10PM +0200, Bartlomiej Zolnierkiewicz wrote:
> From: Tomasz Figa <t.figa@samsung.com>
> 
> Due to recent consolidation of Exynos suspend and cpuidle code, some
> parts of suspend and resume sequences are executed two times, once from
> exynos_pm_syscore_ops and then from exynos_cpu_pm_notifier() and thus it
> breaks suspend, at least on Exynos4-based boards. In addition, simple
> core power down from a cpuidle driver could, in case of CPU 0 could
> result in calling functions that are specific to suspend and deeper idle
> states.
> 
> This patch fixes the issue by moving those operations outside the CPU PM
> notifier into suspend and AFTR code paths. This leads to a bit of code
> duplication, but allows additional code simplification, so in the end
> more code is removed than added.
> 
> Fixes: 85f9f90808b4 ("ARM: EXYNOS: Use the cpu_pm notifier for pm")
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: arm at kernel.org
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> [b.zolnierkie: ported patch over current changes]
> [b.zolnierkie: fixed exynos_aftr_finisher() return value]
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Applied to fixes.


-Olof
