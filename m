From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Thu, 21 May 2015 09:24:14 +0200
Subject: [PATCH 2/2] ARM: dts: exynos4415: Add syscon property to the MIPI
 DPHY
In-Reply-To: <1432174713-23368-2-git-send-email-k.kozlowski@samsung.com>
References: <1432174713-23368-1-git-send-email-k.kozlowski@samsung.com>
 <1432174713-23368-2-git-send-email-k.kozlowski@samsung.com>
Message-ID: <CABxcv==hsWSU6y2xYUVjO6WyZXYHA4=m5H3fNo3CKAX5QK5DSg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On Thu, May 21, 2015 at 4:18 AM, Krzysztof Kozlowski
<k.kozlowski@samsung.com> wrote:
> Since e4b3d38088df ("phy: exynos-video-mipi: Fix regression by adding
> support for PMU regmap") the Exynos PMU driver provides regmap to access
> the MIPI DPHY registers. The MIPI DPHY driver accesses this regmap
> through syscon phandle.
>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  arch/arm/boot/dts/exynos4415.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/exynos4415.dtsi b/arch/arm/boot/dts/exynos4415.dtsi
> index 186cb8465683..6a83d7999d8a 100644
> --- a/arch/arm/boot/dts/exynos4415.dtsi
> +++ b/arch/arm/boot/dts/exynos4415.dtsi
> @@ -124,8 +124,8 @@
>
>                 mipi_phy: video-phy at 10020710 {
>                         compatible = "samsung,s5pv210-mipi-video-phy";
> -                       reg = <0x10020710 8>;
>                         #phy-cells = <1>;
> +                       syscon = <&pmu_system_controller>;
>                 };
>
>                 pd_cam: cam-power-domain at 10024000 {
> --

Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Best regards,
Javier
