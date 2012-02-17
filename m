From: olof@lixom.net (Olof Johansson)
Date: Thu, 16 Feb 2012 16:10:13 -0800
Subject: [PATCH v2 04/11] ARM: EXYNOS: add interrupt definitions for
 EXYNOS5250
In-Reply-To: <1328981685-8602-5-git-send-email-kgene.kim@samsung.com>
References: <1328981685-8602-1-git-send-email-kgene.kim@samsung.com>
 <1328981685-8602-5-git-send-email-kgene.kim@samsung.com>
Message-ID: <CAOesGMhmcnt6LPb9O+3420VgG=PiCnOjzZA3JqsA=4OdHN-R-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Feb 11, 2012 at 9:34 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> This patch adds the interrupt definitions for EXYNOS5250 at
> <mach/irqs.h> file. Basically, now it is needed for EXYNOS5250
> interrupt and will be updated for single zImage next time.
>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
> ?arch/arm/mach-exynos/include/mach/irqs.h | ?236 +++++++++++++++++++++++++++++-
> ?1 files changed, 232 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-exynos/include/mach/irqs.h b/arch/arm/mach-exynos/include/mach/irqs.h
> index f77bce0..0dab1b1 100644
> --- a/arch/arm/mach-exynos/include/mach/irqs.h
> +++ b/arch/arm/mach-exynos/include/mach/irqs.h
> @@ -1,9 +1,8 @@
> -/* linux/arch/arm/mach-exynos4/include/mach/irqs.h
> - *
> - * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
> +/*
> + * Copyright (c) 2010-2012 Samsung Electronics Co., Ltd.
> ?* ? ? ? ? ? ? http://www.samsung.com
> ?*
> - * EXYNOS4 - IRQ definitions
> + * EXYNOS - IRQ definitions
> ?*
> ?* This program is free software; you can redistribute it and/or modify
> ?* it under the terms of the GNU General Public License version 2 as
> @@ -25,6 +24,8 @@
>
> ?#define IRQ_SPI(x) ? ? ? ? ? ? (x+32)
>
> +#ifdef CONFIG_ARCH_EXYNOS4
> +

irqs.h seems to be one of the major files that causes conflicts if a
combined EXYNOS4+5 kernel is built (after editing Kconfig to allow
both). Can you please try to come up with a way to allow both of them
to coexist instead of making them exclusive?


-Olof



-Olof
