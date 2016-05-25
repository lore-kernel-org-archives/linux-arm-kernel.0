From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 25 May 2016 08:51:05 +0200
Subject: [PATCH 0/2] ARM: dts: Fix imprecise external abort error when
 accessing Exynos MFC
In-Reply-To: <1464111662-15336-1-git-send-email-javier@osg.samsung.com>
References: <1464111662-15336-1-git-send-email-javier@osg.samsung.com>
Message-ID: <6479e0c0-97fb-ca3b-1337-6ed11410d94f@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,


On 2016-05-24 19:41, Javier Martinez Canillas wrote:
> This series fixes an imprecise external abort error when accessing the
> Exynos MFC registers due the power domain configuration requiring the
> aclk333 clock to be enabled during a domain switch.
>
> There isn't a dependency between the clock and Linux Samsung SoC trees
> because the CLK_ACLK333 clock ID is already defined so the patches can
> be picked indepedently by the relevant subsystem maintainers.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

I'm really curious what kind of async-bridge is there, but this patch
really fixes the problem with mfc power domain.

> Best regards,
> Javier
>
>
> Javier Martinez Canillas (2):
>    clk: exynos5420: Set ID for aclk333 gate clock
>    ARM: dts: Add async-bridge clock to MFC power domain for Exynos5420
>
>   arch/arm/boot/dts/exynos5420.dtsi    | 5 +++--
>   drivers/clk/samsung/clk-exynos5420.c | 2 +-
>   2 files changed, 4 insertions(+), 3 deletions(-)
>

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
