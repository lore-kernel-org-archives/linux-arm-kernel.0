From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sun, 18 Nov 2018 15:12:01 +0100
Subject: [PATCH v4] ARM: SAMSUNG: limit SAMSUNG_PM_DEBUG config option to
 non-Exynos platforms
In-Reply-To: <f38311a0-ed37-49e6-cae1-62dfb30c7325@samsung.com>
References: <CGME20181114153100eucas1p1a48e0febdfacfe40dd08c91a6b0d045e@eucas1p1.samsung.com>
 <f38311a0-ed37-49e6-cae1-62dfb30c7325@samsung.com>
Message-ID: <20181118141201.GA18926@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 14, 2018 at 04:30:58PM +0100, Bartlomiej Zolnierkiewicz wrote:
> "Samsung PM Suspend debug" feature (controlled by SAMSUNG_PM_DEBUG
> config option) is not working properly (debug messages are not
> displayed after resume) on Exynos platforms because GPIOs restore
> code is not implemented.
> 
> Add PLAT_S3C24XX, ARCH_S3C64XX and ARCH_S5PV210 dependencies to
> SAMSUNG_PM_DEBUG config option to hide it on Exynos platforms.
> Then convert Exynos code to not require <plat/pm-common.h>
> header (use pr_debug() directly instead of S3C_PMDBG() macro and
> remove redundant s3c_pm_*() calls).
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
> v4:
> - rebased on top of next-20181114

Thanks, applied.

Best regards,
Krzysztof
