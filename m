From: jic23@kernel.org (Jonathan Cameron)
Date: Wed, 23 Jul 2014 21:59:36 +0100
Subject: [PATCHv8 4/4] ARM: dts: Fix wrong compatible string for Exynos3250
 ADC
In-Reply-To: <1405994696-3117-5-git-send-email-cw00.choi@samsung.com>
References: <1405994696-3117-1-git-send-email-cw00.choi@samsung.com>
 <1405994696-3117-5-git-send-email-cw00.choi@samsung.com>
Message-ID: <53D02238.40001@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/07/14 03:04, Chanwoo Choi wrote:
> This patchset fix wrong compatible string for Exynos3250 ADC. Exynos3250 SoC
> need to control only special clock for ADC. Exynos SoC except for Exynos3250
> has not included special clock for ADC. The exynos ADC driver can control
> special clock if compatible string is 'exynos3250-adc-v2'.
>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> Reviewed-by: Tomasz Figa <t.figa@samsung.com>
> Acked-by: Kukjin Kim <kgene.kim@samsung.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
Applied to the togreg branch of iio.git - initially pushed out as testing.

Thanks

Jonathan
> ---
>   arch/arm/boot/dts/exynos3250.dtsi | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
> index 15c9c87..767189a 100644
> --- a/arch/arm/boot/dts/exynos3250.dtsi
> +++ b/arch/arm/boot/dts/exynos3250.dtsi
> @@ -407,10 +407,11 @@
>   		};
>
>   		adc: adc at 126C0000 {
> -			compatible = "samsung,exynos-adc-v3";
> +			compatible = "samsung,exynos3250-adc",
> +				     "samsung,exynos-adc-v2";
>   			reg = <0x126C0000 0x100>, <0x10020718 0x4>;
>   			interrupts = <0 137 0>;
> -			clock-names = "adc", "sclk_tsadc";
> +			clock-names = "adc", "sclk";
>   			clocks = <&cmu CLK_TSADC>, <&cmu CLK_SCLK_TSADC>;
>   			#io-channel-cells = <1>;
>   			io-channel-ranges;
>
