From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 01 Jun 2016 10:50:25 +0200
Subject: [PATCH] ARM: dts: exynos: Add TMU nodes regulator supply for Peach
 boards
In-Reply-To: <1464731280-24588-1-git-send-email-javier@osg.samsung.com>
References: <1464731280-24588-1-git-send-email-javier@osg.samsung.com>
Message-ID: <574EA1D1.6020606@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/31/2016 11:48 PM, Javier Martinez Canillas wrote:
> The Exynos5800 Peach Pi and Exynos5420 Peach Pit Chromebooks have the
> LDO10 1.8V output connected to the VDD18_TS{01,23,4} Exynos SoC pins.
> 
> Add this regulator as the input supply of the Thermal Management Unit
> channels and also remove the always-on property since all the devices
> using LDO10 as input supply are now defined.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> ---
> 
>  arch/arm/boot/dts/exynos5420-peach-pit.dts | 21 ++++++++++++++++++++-
>  arch/arm/boot/dts/exynos5800-peach-pi.dts  | 21 ++++++++++++++++++++-
>  2 files changed, 40 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
> index c1247402cb17..a55760b5fa82 100644
> --- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
> +++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
> @@ -425,7 +425,6 @@
>  				regulator-name = "vdd_ldo10";
>  				regulator-min-microvolt = <1800000>;
>  				regulator-max-microvolt = <1800000>;
> -				regulator-always-on;
>  				regulator-state-mem {
>  					regulator-off-in-suspend;
>  				};
> @@ -924,6 +923,26 @@
>  	assigned-clock-parents = <&clock CLK_FIN_PLL>;
>  };
>  
> +&tmu_cpu0 {
> +	vtmu-supply = <&ldo10_reg>;
> +};
> +
> +&tmu_cpu1 {
> +	vtmu-supply = <&ldo10_reg>;
> +};
> +
> +&tmu_cpu2 {
> +	vtmu-supply = <&ldo10_reg>;
> +};
> +
> +&tmu_cpu3 {
> +	vtmu-supply = <&ldo10_reg>;
> +};
> +
> +&tmu_gpu {
> +	vtmu-supply = <&ldo10_reg>;
> +};
> +

Here and for Peach Pi please put the nodes in alphabetical order.

Best regards,
Krzysztof
