From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 19 Apr 2013 18:51:47 +0200
Subject: [PATCH] cpufreq: exynos: allow disabling cpufreq drivers
In-Reply-To: <201304191554.29679.arnd@arndb.de>
References: <201304191554.29679.arnd@arndb.de>
Message-ID: <51717623.2060709@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/19/2013 03:54 PM, Arnd Bergmann wrote:
> Commit 6e6aac7590 "ARM: EXYNOS: Migrate clock support to common
> clock framework" broke support for the exynos cpufreq drivers.
> While we're waiting for a fix for this, let's get back to a state
> where the kernel builds again with the cpufreq subsystem enabled
> but ARM_EXYNOS_CPUFREQ disabled. I assume that this was the intention
> behind this Kconfig symbol anyway.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Cc: Tomasz Figa <t.figa@samsung.com>
> Cc: Thomas Abraham <thomas.abraham@linaro.org>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: cpufreq at vger.kernel.org
> Cc: Rafael J. Wysocki <rjw@sisk.pl>
> ---
> Rafael, I'm putting this patch into the arm-soc tree now to avoid
> a bug based on a patch that I got from Kukjin. If you have any
> objections, please let me know so I can revert it again.
> 
> Everyone else: Why does 6e6aac7590 have your "Tested-by" and
> "Signed-off-by" tags on it when it's obviously broken? Who is
> fixing this? Having no working exynos cpufreq support in 3.10
> would be a serious regression.

Not sure what happened here, but my and Tomasz's Tested-by were given 
for v5 of the patch series including 6e6aac7590, while it seems v6 
has been applied. And the patch is not same in both series.

There could be some differences in the base tree I used when testing 
this [1] series, as it was hard to determine against what tag it was 
created exactly. Also I didn't test in on all platforms, only 
Exynos4412.

And the cpufreq really needs to get fixed, as it now modifies registers
which belong to the clock driver...

[1] http://www.spinics.net/lists/arm-kernel/msg214149.html

Thanks,
Sylwester
