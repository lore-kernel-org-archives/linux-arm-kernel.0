From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 14 Mar 2016 15:57:22 +0900
Subject: [PATCH 06/10] ARM: dts: Add MSHC0 dt node for eMMC device for
 exynos3250-artik5 module
In-Reply-To: <1457921056-21257-7-git-send-email-cw00.choi@samsung.com>
References: <1457921056-21257-1-git-send-email-cw00.choi@samsung.com>
 <1457921056-21257-7-git-send-email-cw00.choi@samsung.com>
Message-ID: <56E660D2.9090706@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14.03.2016 11:04, Chanwoo Choi wrote:
> From: Jaehoon Chung <jh80.chung@samsung.com>
> 
> This patch adds MSHC (Mobile Storage Host Controller) dt node for Exynos3250
> SoC. MSHC is an interface between the system and the eMMC device.
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  arch/arm/boot/dts/exynos3250-artik5.dtsi | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos3250-artik5.dtsi b/arch/arm/boot/dts/exynos3250-artik5.dtsi
> index 97d0087efb9f..75b291c10cdc 100644
> --- a/arch/arm/boot/dts/exynos3250-artik5.dtsi
> +++ b/arch/arm/boot/dts/exynos3250-artik5.dtsi
> @@ -277,6 +277,25 @@
>  	};
>  };
>  
> +&mshc_0 {
> +	num-slots = <1>;
> +	broken-cd;
> +	non-removable;

Broken or non-removable, not both.

> +	cap-mmc-highspeed;
> +	desc-num = <4>;
> +	card-detect-delay = <200>;
> +	vmmc-supply = <&ldo11_reg>;

Isn't this vqmmc-supply?

BTW, both MMC0 regulators (ldo11, ldo12) are marked as always-on. Why
they cannot be controlled by XMMC0CDN (just like on Rinato)?

What is the benefit of making this patch separate from "Add
exynos3250-artik5 dtsi file for ARTIK5 module"? Does the board boot
properly without this patch?

Best regards,
Krzysztof

> +	clock-frequency = <100000000>;
> +	clock-freq-min-max = <400000 100000000>;
> +	samsung,dw-mshc-ciu-div = <1>;
> +	samsung,dw-mshc-sdr-timing = <0 1>;
> +	samsung,dw-mshc-ddr-timing = <1 2>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&sd0_cmd &sd0_bus1 &sd0_bus4 &sd0_bus8>;
> +	bus-width = <8>;
> +	status = "okay";
> +};
> +
>  &xusbxti {
>  	clock-frequency = <24000000>;
>  };
> 
