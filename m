From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 18 Feb 2016 14:21:32 +0900
Subject: [PATCH 2/3] thermal: exynos: Document number of supported
 trip-points
In-Reply-To: <1455772460-20684-2-git-send-email-k.kozlowski@samsung.com>
References: <1455772460-20684-1-git-send-email-k.kozlowski@samsung.com>
 <1455772460-20684-2-git-send-email-k.kozlowski@samsung.com>
Message-ID: <56C554DC.1040104@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016? 02? 18? 14:14, Krzysztof Kozlowski wrote:
> Document the number of configurable temperature thresholds (for
> trip-points in interrupt-driven mode).
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  Documentation/devicetree/bindings/thermal/exynos-thermal.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/exynos-thermal.txt b/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
> index 34315d7fbfde..faa62059b5c5 100644
> --- a/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
> +++ b/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
> @@ -44,6 +44,14 @@
>  - vtmu-supply: This entry is optional and provides the regulator node supplying
>  		voltage to TMU. If needed this entry can be placed inside
>  		board/platform specific dts file.
> +
> +The Exynos TMU supports generating interrupts when reaching given
> +temperature thresholds. Number of supported thermal trip points depends
> +on the SoC (only first trip points defined in DT will be configured):
> + - most of SoC: 4
> + - samsung,exynos5433-tmu: 8
> + - samsung,exynos7-tmu: 8
> +
>  Following properties are mandatory (depending on SoC):
>  - samsung,tmu_gain: Gain value for internal TMU operation.
>  - samsung,tmu_reference_voltage: Value of TMU IP block's reference voltage
> 

Exynos5433 has the 8 interrupt for thermal. Looks good to me.
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

Best Regards,
Chanwoo Choi
