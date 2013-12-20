From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 21 Dec 2013 07:25:14 +0900
Subject: [PATCH] ARM: dts: Add CODEC MCLK for SMDK5250
In-Reply-To: <1386797978-12394-1-git-send-email-broonie@kernel.org>
References: <1386797978-12394-1-git-send-email-broonie@kernel.org>
Message-ID: <52B4C3CA.5040904@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/12/13 06:39, Mark Brown wrote:
> From: Mark Brown<broonie@linaro.org>
>
> There is a 16.934MHz fixed rate clock connected to MCLK1 on the CODEC, add
> this to the device tree bindings.
>
> Signed-off-by: Mark Brown<broonie@linaro.org>
> ---
>   arch/arm/boot/dts/exynos5250-smdk5250.dts | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
> index aaacfc833ccc..00b57faf977e 100644
> --- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
> +++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
> @@ -79,6 +79,9 @@
>   			gpio-controller;
>   			#gpio-cells =<2>;
>
> +			clocks =<&codec_mclk>;
> +			clock-names = "MCLK1";
> +
>   			AVDD2-supply =<&vdd>;
>   			CPVDD-supply =<&vdd>;
>   			DBVDD-supply =<&dbvdd>;
> @@ -250,5 +253,11 @@
>   			compatible = "samsung,clock-xxti";
>   			clock-frequency =<24000000>;
>   		};
> +
> +		codec_mclk: codec-mclk {
> +			compatible = "fixed-clock";
> +			#clock-cells =<0>;
> +			clock-frequency =<16934000>;
> +		};
>   	};
>   };

Applied, thanks.

- Kukjin
