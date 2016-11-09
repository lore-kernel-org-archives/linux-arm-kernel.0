From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 9 Nov 2016 22:03:51 +0200
Subject: [PATCH v3 1/2] ARM: EXYNOS: Remove static mapping of SCU SFR
In-Reply-To: <1478693755-11953-2-git-send-email-pankaj.dubey@samsung.com>
References: <1478693755-11953-1-git-send-email-pankaj.dubey@samsung.com>
 <1478693755-11953-2-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <20161109200351.GA23534@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 09, 2016 at 05:45:54PM +0530, Pankaj Dubey wrote:
> Lets remove static mapping of SCU SFR mainly used in CORTEX-A9 SoC based
> boards. Instead use mapping from device tree node of SCU.
> 
> NOTE: This patch has dependency on DT file of any such CORTEX-A9 SoC
> based boards, in the absence of SCU device node in DTS file, only single
> CPU will boot. So if you are using OUT-OF-TREE DTS file of CORTEX-A9 based
> Exynos SoC make sure to add SCU device node to DTS file for SMP boot.
> 
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---
>  arch/arm/mach-exynos/common.h                |  1 +
>  arch/arm/mach-exynos/exynos.c                | 22 ------------------
>  arch/arm/mach-exynos/include/mach/map.h      |  2 --
>  arch/arm/mach-exynos/platsmp.c               | 34 +++++++++++++++++++++-------
>  arch/arm/mach-exynos/pm.c                    |  4 +---
>  arch/arm/mach-exynos/suspend.c               |  4 +---
>  arch/arm/plat-samsung/include/plat/map-s5p.h |  4 ----
>  7 files changed, 29 insertions(+), 42 deletions(-)
>

Applied on a next/soc branch after merging next/dt to preserve
bisectability.

Best regards,
Krzysztof
