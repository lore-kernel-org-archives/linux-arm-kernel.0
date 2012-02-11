From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 11 Feb 2012 20:07:08 +0000
Subject: [PATCH v2 03/11] ARM: EXYNOS: add clock part for EXYNOS5250 SoC
In-Reply-To: <1328981685-8602-4-git-send-email-kgene.kim@samsung.com>
References: <1328981685-8602-1-git-send-email-kgene.kim@samsung.com>
 <1328981685-8602-4-git-send-email-kgene.kim@samsung.com>
Message-ID: <201202112007.08672.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 11 February 2012, Kukjin Kim wrote:
> This patch adds clock-exynos5.c for EXYNOS5250 now
> and that can be used for other EXYNOS5 SoCs later.
> 
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
>  arch/arm/mach-exynos/clock-exynos5.c           | 1252 ++++++++++++++++++++++++
>  arch/arm/mach-exynos/include/mach/regs-clock.h |   62 ++
>  arch/arm/plat-s5p/clock.c                      |   36 +
>  arch/arm/plat-samsung/include/plat/s5p-clock.h |    6 +
>  4 files changed, 1356 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-exynos/clock-exynos5.c

I discussed this patch with a few people at linaro connect, I wanted to
make sure we have consensus before asking for a drastic change. What
we ended up agreeing on is that it should use the common struct clk
from Mike Turquette. You can choose whether you want to take those
patches and base yours on top or whether you want to use a copy of
that the new header file and then move exynos5 over once both series
are in arm-soc.git.

Further, moving over exynos5 but not changing exynos4 will prevent
you from building both into the same kernel. You will have to decide
what the risk is in changing exynos4 at the same time. It would
be great if we can have all exynos use the common struct clk in 3.4,
but I'm also happy if we just get exynos5 to do it that way from the
beginning and move exynos4 over in 3.5 after you have had a chance
to make sure everything still works.

	Arnd
