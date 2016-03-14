From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Mon, 14 Mar 2016 11:10:49 +0900
Subject: [PATCH 06/10] ARM: dts: exynos3250-artik5: Add MSHC0 dt node for
 eMMC device
In-Reply-To: <1457921056-21257-8-git-send-email-cw00.choi@samsung.com>
References: <1457921056-21257-1-git-send-email-cw00.choi@samsung.com>
 <1457921056-21257-8-git-send-email-cw00.choi@samsung.com>
Message-ID: <56E61DA9.1030105@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear all,

It is my mistake. Please ignore only this patch.
This patch is duplicate with patch[1].

[1] [PATCH 06/10] ARM: dts: Add MSHC0 dt node for eMMC device for exynos3250-artik5 module

Best Regards,
Chanwoo Choi

On 2016? 03? 14? 11:04, Chanwoo Choi wrote:
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
> +	cap-mmc-highspeed;
> +	desc-num = <4>;
> +	card-detect-delay = <200>;
> +	vmmc-supply = <&ldo11_reg>;
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
