From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 18 Dec 2013 17:37:23 +0100
Subject: [PATCH 2/2] ARM: EXYNOS: Add CMU virtual addresses for exynos5260
In-Reply-To: <1386758416-31065-3-git-send-email-vikas.sajjan@linaro.org>
References: <1386758416-31065-1-git-send-email-vikas.sajjan@linaro.org>
 <1386758416-31065-3-git-send-email-vikas.sajjan@linaro.org>
Message-ID: <2468420.340ZhVlqCl@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vikas, Young-Gun,

On Wednesday 11 of December 2013 16:25:16 Vikas Sajjan wrote:
> From: Young-Gun Jang <yg1004.jang@samsung.com>
> 
> Adds CMU virtual addresses for exynos5260.
> 
> Change-Id: Ia4f4eda96187d8d9e1edfc1a6b025af56d3bc43e

This line should be dropped.

> Signed-off-by: Young-Gun Jang <yg1004.jang@samsung.com>
> Signed-off-by: Vikas Sajjan <vikas.sajjan@samsung.com>
> ---
>  arch/arm/mach-exynos/common.c                  | 65 ++++++++++++++++++++++++++
>  arch/arm/mach-exynos/include/mach/map.h        | 14 ++++++
>  arch/arm/mach-exynos/include/mach/regs-clock.h | 17 +++++++
>  arch/arm/plat-samsung/include/plat/map-s5p.h   | 16 +++++++
>  4 files changed, 112 insertions(+)

Why do you need those static mappings? Unless there is a reason to map
those registers very early (before ioremap() and friends are available)
I'm going to NAK any additions of static mappings.

Best regards,
Tomasz
