From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 18 Apr 2011 06:49:23 +0900
Subject: [PATCH 8/14] ARM / Samsung: Use struct syscore_ops for "core"
	power	management
In-Reply-To: <201104172311.17082.rjw@sisk.pl>
References: <201103280125.11750.rjw@sisk.pl> <201104172301.54115.rjw@sisk.pl>
	<201104172311.17082.rjw@sisk.pl>
Message-ID: <008801cbfd49$5508c870$ff1a5950$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rafael J. Wysocki wrote:
> 
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Replace sysdev classes and struct sys_device objects used for "core"
> power management by Samsung platforms with struct syscore_ops objects
> that are simpler.
> 
> This generally reduces the code size and the kernel memory footprint.
> It also is necessary for removing sysdevs entirely from the kernel in
> the future.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Acked-by: Kukjin Kim <kgene.kim@samsung.com>

> ---
>  arch/arm/mach-exynos4/pm.c               |   45 ++++++++++++--------
>  arch/arm/mach-s3c2410/irq.c              |   30 -------------
>  arch/arm/mach-s3c2410/mach-bast.c        |   17 ++-----
>  arch/arm/mach-s3c2410/pm.c               |   13 ++---
>  arch/arm/mach-s3c2410/s3c2410.c          |    5 ++
>  arch/arm/mach-s3c2412/irq.c              |    2
>  arch/arm/mach-s3c2412/mach-jive.c        |   19 ++------
>  arch/arm/mach-s3c2412/pm.c               |   27 ++++++------
>  arch/arm/mach-s3c2412/s3c2412.c          |    4 +
>  arch/arm/mach-s3c2416/irq.c              |    2
>  arch/arm/mach-s3c2416/pm.c               |   27 +++++-------
>  arch/arm/mach-s3c2416/s3c2416.c          |    5 ++
>  arch/arm/mach-s3c2440/mach-osiris.c      |   18 ++------
>  arch/arm/mach-s3c2440/s3c2440.c          |    8 +++
>  arch/arm/mach-s3c2440/s3c2442.c          |    6 ++
>  arch/arm/mach-s3c2440/s3c244x-irq.c      |    4 -
>  arch/arm/mach-s3c2440/s3c244x.c          |   62
++++++++++++++--------------
>  arch/arm/mach-s3c64xx/irq-pm.c           |   18 ++++----
>  arch/arm/mach-s5pv210/pm.c               |   25 +++++++----
>  arch/arm/plat-s3c24xx/dma.c              |   68
+++++++++++-----------------
> ---
>  arch/arm/plat-s3c24xx/irq-pm.c           |    7 ---
>  arch/arm/plat-s5p/irq-pm.c               |    7 ---
>  arch/arm/plat-samsung/include/plat/cpu.h |    6 ++
>  arch/arm/plat-samsung/include/plat/pm.h  |    6 +-
>  24 files changed, 203 insertions(+), 228 deletions(-)
> 

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
