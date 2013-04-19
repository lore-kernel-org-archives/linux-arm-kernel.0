From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 19 Apr 2013 20:59:38 +0200
Subject: [PATCH] cpufreq: exynos: allow disabling cpufreq drivers
In-Reply-To: <51717623.2060709@samsung.com>
References: <201304191554.29679.arnd@arndb.de> <51717623.2060709@samsung.com>
Message-ID: <201304192059.38606.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 19 April 2013, Sylwester Nawrocki wrote:
> Not sure what happened here, but my and Tomasz's Tested-by were given 
> for v5 of the patch series including 6e6aac7590, while it seems v6 
> has been applied. And the patch is not same in both series.

I see.

> There could be some differences in the base tree I used when testing 
> this [1] series, as it was hard to determine against what tag it was 
> created exactly. Also I didn't test in on all platforms, only 
> Exynos4412.

Maybe you just didn't have CPUFREQ enabled? I also didn't notice this
bug at first because it is turned off in the defconfigs.

It could also be working by chance on EXYNOS4, since the register
definitions were not actually removed from the regs-clk.h header
for those.

	Arnd
