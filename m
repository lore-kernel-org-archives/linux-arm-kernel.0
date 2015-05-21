From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Thu, 21 May 2015 09:23:21 +0200
Subject: [PATCH 1/2] ARM: dts: exynos4: Remove obsolete MIPI DPHY 'reg'
 property
In-Reply-To: <1432174713-23368-1-git-send-email-k.kozlowski@samsung.com>
References: <1432174713-23368-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <CABxcv=mKLGVWj2swi63-AkdF_-D5eVM=-785dJ8WjUNC-D1zpg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On Thu, May 21, 2015 at 4:18 AM, Krzysztof Kozlowski
<k.kozlowski@samsung.com> wrote:
> Since e4b3d38088df ("phy: exynos-video-mipi: Fix regression by adding
> support for PMU regmap") the Exynos PMU driver provides regmap to access
> the MIPI DPHY registers. The MIPI DPHY node uses a phandle to syscon to
> get this regmap. The 'reg' field is obsolete.
>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  arch/arm/boot/dts/exynos4.dtsi | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
> index 1c74c1296ab7..6e7f0b4afa84 100644
> --- a/arch/arm/boot/dts/exynos4.dtsi
> +++ b/arch/arm/boot/dts/exynos4.dtsi
> @@ -78,7 +78,6 @@
>
>         mipi_phy: video-phy at 10020710 {
>                 compatible = "samsung,s5pv210-mipi-video-phy";
> -               reg = <0x10020710 8>;
>                 #phy-cells = <1>;
>                 syscon = <&pmu_system_controller>;
>         };

Indeed, is even removed from the DT binding so this is clearly a left over.

Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Best regards,
Javier
