From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 24 Sep 2018 09:41:01 +0200
Subject: [RFT] arm64: ARM: dts: exynos: Remove double SD card detect pin
 inversion on TM2
In-Reply-To: <20180921183014.20236-1-krzk@kernel.org>
References: <CGME20180921183024epcas2p3bef08b81273524ec9d7afef4875bb746@epcas2p3.samsung.com>
 <20180921183014.20236-1-krzk@kernel.org>
Message-ID: <20180924074103eucas1p1eccd62abcdeca57a95ad406869884a97~XRhczWE3m1304413044eucas1p1F@eucas1p1.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

On 2018-09-21 20:30, Krzysztof Kozlowski wrote:
> The SDHCI standard, MMC host controller bindings and MMC core defines
> card detect pin as active low.  Therefore there is no point to invert it
> twice.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Works fine on TM2 and TM2e. However I'm not sure if it makes sense to
refer to the SDHCI standard, as Exynos5433 has only DWMMC host controllers.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
>   arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
> index a1e3194b7483..86d8ddc3288a 100644
> --- a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
> @@ -939,8 +939,7 @@
>   	status = "okay";
>   	cap-sd-highspeed;
>   	disable-wp;
> -	cd-gpios = <&gpa2 4 GPIO_ACTIVE_HIGH>;
> -	cd-inverted;
> +	cd-gpios = <&gpa2 4 GPIO_ACTIVE_LOW>;
>   	card-detect-delay = <200>;
>   	samsung,dw-mshc-ciu-div = <3>;
>   	samsung,dw-mshc-sdr-timing = <0 4>;

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
