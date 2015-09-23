From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 23 Sep 2015 10:43:53 +0200
Subject: [PATCH v2] ARM: dts: exynos5420: fix wrong clock binding for
 sysmmu_fimd1_1
In-Reply-To: <1442994115-20167-1-git-send-email-jy0922.shim@samsung.com>
References: <1442994115-20167-1-git-send-email-jy0922.shim@samsung.com>
Message-ID: <56026649.4050802@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 2015-09-23 09:41, Joonyoung Shim wrote:
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

Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
> Changes for v2:
> - Update the commit message
> - Add Fixes: and Reviewed-by: tags
>
>   arch/arm/boot/dts/exynos5420.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
> index df9aee9..1b3d6c7 100644
> --- a/arch/arm/boot/dts/exynos5420.dtsi
> +++ b/arch/arm/boot/dts/exynos5420.dtsi
> @@ -1117,7 +1117,7 @@
>   		interrupt-parent = <&combiner>;
>   		interrupts = <3 0>;
>   		clock-names = "sysmmu", "master";
> -		clocks = <&clock CLK_SMMU_FIMD1M0>, <&clock CLK_FIMD1>;
> +		clocks = <&clock CLK_SMMU_FIMD1M1>, <&clock CLK_FIMD1>;
>   		power-domains = <&disp_pd>;
>   		#iommu-cells = <0>;
>   	};

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
