From: trblinux@gmail.com (Tushar Behera)
Date: Fri, 06 Jun 2014 10:08:12 +0530
Subject: Problems booting exynos5420 with >1 CPU
In-Reply-To: <CAD=FV=UX90hgyojW3k_kpT=mt8eX9=AyHr+AGjhK=MrE1hHbUA@mail.gmail.com>
References: <CAD=FV=UX90hgyojW3k_kpT=mt8eX9=AyHr+AGjhK=MrE1hHbUA@mail.gmail.com>
Message-ID: <539145B4.5000200@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/06/2014 06:38 AM, Doug Anderson wrote:
> Hi,
> 
> When I try to boot linuxnext on my exynos5420-peach-pit chromebook I
> have problems bringing up extra CPUs:
> 
> 1. They don't come up
> 

[ ... ]

> [    1.125030] CPU1: failed to boot: -38
> [    2.130043] CPU2: failed to boot: -38
> [    3.135059] CPU3: failed to boot: -38
> 

With following config modifications over exynos_defconfig, I can see 4
big cores coming up.

CONFIG_MCPM=y
CONFIG_EXYNOS5420_MCPM=y

[    0.030919] Exynos MCPM support installed
[    0.060233] CPU1: Booted secondary processor
[    0.090006] CPU1: update cpu_power 1535
[    0.090010] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.100234] CPU2: Booted secondary processor
[    0.130007] CPU2: update cpu_power 1535
[    0.130011] CPU2: thread -1, cpu 2, socket 0, mpidr 80000002
[    0.140233] CPU3: Booted secondary processor
[    0.170008] CPU3: update cpu_power 1535
[    0.170012] CPU3: thread -1, cpu 3, socket 0, mpidr 80000003


-- 
Tushar Behera
