From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 29 Sep 2015 15:38:23 +0900
Subject: [PATCH v2] ARM: dts: exynos5420: fix wrong clock binding for
 sysmmu_fimd1_1
In-Reply-To: <1442994115-20167-1-git-send-email-jy0922.shim@samsung.com>
References: <1442994115-20167-1-git-send-email-jy0922.shim@samsung.com>
Message-ID: <CAJKOXPfNfdkv4hEN=Mm8D2o+z+z9LbAvne5iekLGSeZ8x+NJAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-09-23 16:41 GMT+09:00 Joonyoung Shim <jy0922.shim@samsung.com>:
>
> The sysmmu_fimd1_1 should bind the clock CLK_SMMU_FIMD1M1, not the clock
> CLK_SMMU_FIMD1M0. CLK_SMMU_FIMD1M0 is a clock for the sysmmu_fimd1_0.
>
> This wrong clock binding causes the problem that is blocked in iommu_map
> function when IOMMU is enabled and exynos-drm driver tries to allocate
> buffer via DMA mapping API on Odroid-XU3 board.
>
> Fixes: b70045167815 ("ARM: dts: add sysmmu nodes for exynos5420")
> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
> Cc: <stable@vger.kernel.org> # v4.2
> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
> ---
> Changes for v2:
> - Update the commit message
> - Add Fixes: and Reviewed-by: tags
>
>  arch/arm/boot/dts/exynos5420.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)


Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
