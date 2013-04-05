From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 05 Apr 2013 15:48:29 +0900
Subject: [PATCH 07/18] cpufreq: s3c24xx: move cpufreq driver to
 drivers/cpufreq
In-Reply-To: <927100d30bf40d4fec477cc7d8d464669a22d167.1365079581.git.viresh.kumar@linaro.org>
References: <cover.1365079581.git.viresh.kumar@linaro.org>
 <927100d30bf40d4fec477cc7d8d464669a22d167.1365079581.git.viresh.kumar@linaro.org>
Message-ID: <2a5901ce31c9$95160980$bf421c80$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Viresh Kumar wrote:
> 
> This patch moves cpufreq driver of Samsung's ARM based s3c24xx platform to
> drivers/cpufreq.
> 
> Cc: Ben Dooks <ben-linux@fluff.org>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: linux-samsung-soc at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/Kconfig                                   | 46 ---------------
>  arch/arm/mach-s3c24xx/Kconfig                      | 66
+++++++++-------------
>  arch/arm/mach-s3c24xx/Makefile                     |  6 --
>  arch/arm/mach-s3c24xx/{ => include/mach}/s3c2412.h |  0
>  arch/arm/mach-s3c24xx/iotiming-s3c2412.c           |  2 +-
>  arch/arm/plat-samsung/include/plat/cpu-freq-core.h | 10 ++--
>  arch/arm/plat-samsung/include/plat/cpu-freq.h      |  6 +-
>  drivers/cpufreq/Kconfig.arm                        | 58
+++++++++++++++++++
>  drivers/cpufreq/Makefile                           |  5 ++
>  .../cpufreq/s3c2410-cpufreq.c                      |  0
>  .../cpufreq/s3c2412-cpufreq.c                      |  3 +-
>  .../cpufreq/s3c2440-cpufreq.c                      |  0
>  .../cpufreq/s3c24xx-cpufreq-debugfs.c              |  0
>  .../cpufreq.c => drivers/cpufreq/s3c24xx-cpufreq.c |  0
>  14 files changed, 100 insertions(+), 102 deletions(-)
>  rename arch/arm/mach-s3c24xx/{ => include/mach}/s3c2412.h (100%)
>  rename arch/arm/mach-s3c24xx/cpufreq-s3c2410.c =>
> drivers/cpufreq/s3c2410-cpufreq.c (100%)
>  rename arch/arm/mach-s3c24xx/cpufreq-s3c2412.c =>
> drivers/cpufreq/s3c2412-cpufreq.c (99%)
>  rename arch/arm/mach-s3c24xx/cpufreq-s3c2440.c =>
> drivers/cpufreq/s3c2440-cpufreq.c (100%)
>  rename arch/arm/mach-s3c24xx/cpufreq-debugfs.c =>
> drivers/cpufreq/s3c24xx-cpufreq-debugfs.c (100%)
>  rename arch/arm/mach-s3c24xx/cpufreq.c => drivers/cpufreq/s3c24xx-
> cpufreq.c (100%)
> 
Basically, this moving looks good to me, but should be re-worked based on
for-next of samsung tree because this touches too many samsung stuff so this
should be sent to upstream via samsung tree.

See below,

Applying: cpufreq: s3c24xx: move cpufreq driver to drivers/cpufreq
error: patch failed: arch/arm/Kconfig:2166
error: arch/arm/Kconfig: patch does not apply
error: patch failed: arch/arm/mach-s3c24xx/Kconfig:28
error: arch/arm/mach-s3c24xx/Kconfig: patch does not apply
error: patch failed: arch/arm/mach-s3c24xx/Makefile:17
error: arch/arm/mach-s3c24xx/Makefile: patch does not apply
error: patch failed: drivers/cpufreq/Makefile:63
error: drivers/cpufreq/Makefile: patch does not apply
error: drivers/cpufreq/s3c2412-cpufreq.c: does not exist in index
Patch failed at 0001 cpufreq: s3c24xx: move cpufreq driver to
drivers/cpufreq

Thanks.

- Kukjin
