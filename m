From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Fri, 30 Jan 2015 01:58:03 +0100
Subject: [PATCH 0/3] cpufreq: build fixes
In-Reply-To: <1422451015-390439-1-git-send-email-arnd@arndb.de>
References: <1422451015-390439-1-git-send-email-arnd@arndb.de>
Message-ID: <1773560.dycYOFyPKY@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, January 28, 2015 02:16:52 PM Arnd Bergmann wrote:
> These came out of running randconfig build tests on ARM. The three
> patches are completely independent, so please apply what looks good.
> 
> The two s3c patches are for old bugs and should go through the
> cpufreq tree.
> 
> The exynos bug only exists in the thermal-soc tree at the moment
> and should get picked up by Eduardo with an Ack from the cpufreq
> maintainers, or alternatively the bug should get fixed differently
> if someone can come up with a better solution.
> 
> Arnd Bergmann (3):
>   cpufreq: s3c: remove incorrect __init annotations
>   cpufreq: s3c: remove last use of resume_clocks callback
>   cpufreq: exynos: allow modular build
> 
>  drivers/cpufreq/Kconfig.arm          | 14 +++++++++-----
>  drivers/cpufreq/exynos-cpufreq.h     |  6 +++---
>  drivers/cpufreq/exynos4210-cpufreq.c |  1 +
>  drivers/cpufreq/exynos4x12-cpufreq.c |  1 +
>  drivers/cpufreq/exynos5250-cpufreq.c |  1 +
>  drivers/cpufreq/s3c2416-cpufreq.c    |  4 ++--
>  drivers/cpufreq/s3c24xx-cpufreq.c    | 10 +---------
>  7 files changed, 18 insertions(+), 19 deletions(-)

I'm assuming that this series will go in through the Samsumg tree.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
