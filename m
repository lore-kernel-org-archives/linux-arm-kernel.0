From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 23 Aug 2012 14:45:54 +0900
Subject: [PATCH 4/9] ARM: pmu: remove arm_pmu_type enumeration
In-Reply-To: <1344620195-22372-5-git-send-email-will.deacon@arm.com>
References: <1344620195-22372-1-git-send-email-will.deacon@arm.com>
 <1344620195-22372-5-git-send-email-will.deacon@arm.com>
Message-ID: <1d0c01cd80f2$8f974970$aec5dc50$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will Deacon wrote:
> 
> From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
> 
> The arm_pmu_type enumeration was initially introduced to identify
> different PMU types in the system, the usual one being that on the CPU
> (ARM_PMU_DEVICE_CPU). With the removal of the PMU reservation code and
> the introduction of devicetree bindings for the CPU PMU, the enumeration
> is no longer required.
> 
> This patch removes the enumeration and updates the various CPU PMU
> platform devices so that they no longer pass an .id field referring
> to identify the PMU type.
> 
> Cc: JD Zheng <jdzheng@broadcom.com>
> Cc: Jon Hunter <jon-hunter@ti.com>
> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Linus Walleij <linus.walleij@stericsson.com>
> Cc: Kukjin Kim <kgene.kim@samsung.com>

Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

> Cc: Pawel Moll <pawel.moll@arm.com>
> Signed-off-by: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
> [will: cosmetic edits and actual removal of the enum type]
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm/include/asm/pmu.h               |   10 ----------
>  arch/arm/mach-bcmring/arch.c             |    3 +--
>  arch/arm/mach-omap2/devices.c            |    3 +--
>  arch/arm/mach-pxa/devices.c              |    3 +--
>  arch/arm/mach-realview/realview_eb.c     |    3 +--
>  arch/arm/mach-realview/realview_pb1176.c |    3 +--
>  arch/arm/mach-realview/realview_pb11mp.c |    3 +--
>  arch/arm/mach-realview/realview_pba8.c   |    3 +--
>  arch/arm/mach-realview/realview_pbx.c    |    3 +--
>  arch/arm/mach-tegra/devices.c            |    3 +--
>  arch/arm/mach-ux500/cpu-db8500.c         |    3 +--
>  arch/arm/mach-vexpress/ct-ca9x4.c        |    3 +--
>  arch/arm/plat-iop/pmu.c                  |    3 +--
>  arch/arm/plat-samsung/devs.c             |    3 +--
>  14 files changed, 13 insertions(+), 36 deletions(-)
