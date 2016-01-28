From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Thu, 28 Jan 2016 16:15:34 -0300
Subject: [PATCH v4 2/3] clk: samsung: Don't build ARMv8 clock drivers on
 ARMv7
In-Reply-To: <1453941324-15742-3-git-send-email-k.kozlowski@samsung.com>
References: <1453941324-15742-1-git-send-email-k.kozlowski@samsung.com>
 <1453941324-15742-3-git-send-email-k.kozlowski@samsung.com>
Message-ID: <56AA68D6.50500@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 01/27/2016 09:35 PM, Krzysztof Kozlowski wrote:
> Currently the Exynos5433 (ARMv8 SoC) clock driver depends on ARCH_EXYNOS
> so it is built also on ARMv7. This does not bring any kind of benefit.
> There won't be a single kernel image for ARMv7 and ARMv8 SoCs (like
> multi_v7 for ARMv7).
>
> Instead build clock drivers only for respective SoC's architecture.
>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Also checked that for example clk-exynos5433 is not built anymore for
exynos_defconfig but it is built for allyesconfig.

Tested-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
