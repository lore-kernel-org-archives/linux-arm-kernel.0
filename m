From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 22 Nov 2012 00:46:29 +0900
Subject: [PATCH v3 01/12] ARM: EXYNOS: remove system mmu initialization
 from exynos tree
In-Reply-To: <002701cdc7a5$756dbdf0$604939d0$%cho@samsung.com>
References: <002701cdc7a5$756dbdf0$604939d0$%cho@samsung.com>
Message-ID: <50ACF755.9000706@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/21/12 14:02, Cho KyongHo wrote:
> This removes System MMU initialization from arch/arm/mach-exynos/

Basically, looks OK to me, but I think, this removing change should be 
done after 03/12 patch :-)

> to move them to DT and the exynos-iommu driver except gating clock
> definitions.
>
> Change-Id: Ie29f587c01c645f28fc0e0b94eb3631a0170ebf5

No need 'Change-Id' here.

> Signed-off-by: KyongHo Cho<pullip.cho@samsung.com>
> ---
>   arch/arm/mach-exynos/Kconfig               |   5 -
>   arch/arm/mach-exynos/Makefile              |   1 -
>   arch/arm/mach-exynos/clock-exynos4.c       |  41 +++--
>   arch/arm/mach-exynos/clock-exynos4210.c    |   9 +-
>   arch/arm/mach-exynos/clock-exynos4212.c    |  23 ++-
>   arch/arm/mach-exynos/clock-exynos5.c       |  62 ++++---
>   arch/arm/mach-exynos/dev-sysmmu.c          | 274 -----------------------------
>   arch/arm/mach-exynos/include/mach/sysmmu.h |  66 -------
>   arch/arm/mach-exynos/mach-exynos4-dt.c     |  34 ++++
>   arch/arm/mach-exynos/mach-exynos5-dt.c     |  30 ++++
>   10 files changed, 137 insertions(+), 408 deletions(-)
>   delete mode 100644 arch/arm/mach-exynos/dev-sysmmu.c
>   delete mode 100644 arch/arm/mach-exynos/include/mach/sysmmu.h


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
