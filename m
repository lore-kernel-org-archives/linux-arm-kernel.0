From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 14 Mar 2016 17:31:42 +0900
Subject: [PATCH 09/10] ARM: dts: Add MSHC2 dt node for SD card for
 exynos3250-artik5-devel board
In-Reply-To: <1457921056-21257-11-git-send-email-cw00.choi@samsung.com>
References: <1457921056-21257-1-git-send-email-cw00.choi@samsung.com>
 <1457921056-21257-11-git-send-email-cw00.choi@samsung.com>
Message-ID: <56E676EE.8060500@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14.03.2016 11:04, Chanwoo Choi wrote:
> From: Jaehoon Chung <jh80.chung@samsung.com>
> 
> This patch adds MSHC (Mobile Storage Host Controller) dt node for
> Exynos3250 SoC. MSHC is an interface between the system and the SD card
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  arch/arm/boot/dts/exynos3250-artik5-devel.dts | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos3250-artik5-devel.dts b/arch/arm/boot/dts/exynos3250-artik5-devel.dts
> index d17c28969118..a371baf8536d 100644
> --- a/arch/arm/boot/dts/exynos3250-artik5-devel.dts
> +++ b/arch/arm/boot/dts/exynos3250-artik5-devel.dts
> @@ -21,6 +21,22 @@
>  			"samsung,exynos3250", "samsung,exynos3";
>  };
>  
> +&mshc_2 {
> +	num-slots = <1>;
> +	cap-sd-highspeed;
> +	disable-wp;
> +	card-detect-delay = <200>;
> +	clock-frequency = <100000000>;
> +	clock-freq-min-max = <400000 100000000>;
> +	samsung,dw-mshc-ciu-div = <1>;
> +	samsung,dw-mshc-sdr-timing = <0 1>;
> +	samsung,dw-mshc-ddr-timing = <1 2>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&sd2_cmd &sd2_clk &sd2_cd &sd2_bus1 &sd2_bus4>;
> +	bus-width = <4>;
> +	status = "okay";

vqmmc-supply = ldo3?

Best regards,
Krzysztof

> +};
> +
>  &serial_2 {
>  	status = "okay";
>  };
> 
