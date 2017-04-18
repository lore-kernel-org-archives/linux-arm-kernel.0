From: a.hajda@samsung.com (Andrzej Hajda)
Date: Tue, 18 Apr 2017 08:00:14 +0200
Subject: [PATCH v2 3/3] arm64: dts: exynos: Add support for s6e3hf2 panel
 device on TM2e board
In-Reply-To: <1492408934-22096-4-git-send-email-hoegeun.kwon@samsung.com>
References: <1492408934-22096-1-git-send-email-hoegeun.kwon@samsung.com>
 <CGME20170417060220epcas5p42f6ed43d9db94779382e84a129b9da2d@epcas5p4.samsung.com>
 <1492408934-22096-4-git-send-email-hoegeun.kwon@samsung.com>
Message-ID: <b9bfcdd9-5576-34c3-6c7d-556b6c81946d@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17.04.2017 08:02, Hoegeun Kwon wrote:
> This patch add the panel device tree node for s6e3hf2 display
> controller to TM2e dts.
>
> Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>

Maybe it would be good to remove te-gpios property - tm2/tm2e uses
hardware trigger, so it is not necessary and generates useless interrupts.

Beside this:
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
 --
Regards
Andrzej
> ---
>  arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts b/arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts
> index 694717a..98ad094 100644
> --- a/arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts
> +++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts
> @@ -52,6 +52,18 @@
>  	assigned-clock-rates = <278000000>, <400000000>;
>  };
>  
> +&dsi {
> +	panel at 0 {
> +		compatible = "samsung,s6e3hf2";
> +		reg = <0>;
> +		vdd3-supply = <&ldo27_reg>;
> +		vci-supply = <&ldo28_reg>;
> +		reset-gpios = <&gpg0 0 GPIO_ACTIVE_LOW>;
> +		enable-gpios = <&gpf1 5 GPIO_ACTIVE_HIGH>;
> +		te-gpios = <&gpf1 3 GPIO_ACTIVE_HIGH>;
> +	};
> +};
> +
>  &ldo31_reg {
>  	regulator-name = "TSP_VDD_1.8V_AP";
>  	regulator-min-microvolt = <1800000>;
