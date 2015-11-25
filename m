From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 26 Nov 2015 08:55:10 +0900
Subject: [PATCH] ARM: dts: exynos4210: Add power domain to G2D device
In-Reply-To: <1448456127-31842-2-git-send-email-m.szyprowski@samsung.com>
References: <1448456127-31842-1-git-send-email-m.szyprowski@samsung.com>
 <1448456127-31842-2-git-send-email-m.szyprowski@samsung.com>
Message-ID: <56564A5E.4090406@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25.11.2015 21:55, Marek Szyprowski wrote:
> G2D device and it's SYSMMU belongs to LCD0 power domain on Exynos 4210,
> so add missing power-domains property to G2D device node (G2D's SYSMMU is
> already bound to LCD0 power domain).
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  arch/arm/boot/dts/exynos4210.dtsi | 1 +
>  1 file changed, 1 insertion(+)

You sent it with "in-reply-to" cover letter but without any explanation
why? Are here any dependencies on the rest of patchset? Any specific
order? This is a little bit confusing.

Best regards,
Krzysztof

> 
> diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
> index aac0f17..d254200 100644
> --- a/arch/arm/boot/dts/exynos4210.dtsi
> +++ b/arch/arm/boot/dts/exynos4210.dtsi
> @@ -185,6 +185,7 @@
>  		interrupts = <0 89 0>;
>  		clocks = <&clock CLK_SCLK_FIMG2D>, <&clock CLK_G2D>;
>  		clock-names = "sclk_fimg2d", "fimg2d";
> +		power-domains = <&pd_lcd0>;
>  		iommus = <&sysmmu_g2d>;
>  		status = "disabled";
>  	};
> 
