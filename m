From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 14 Dec 2015 09:57:02 +0000
Subject: [PATCH 3/4] ARM: dts: rockchip: add eFuse node for rk3066a SoCs
In-Reply-To: <1447227272-1728-4-git-send-email-wxt@rock-chips.com>
References: <1447227272-1728-1-git-send-email-wxt@rock-chips.com>
 <1447227272-1728-4-git-send-email-wxt@rock-chips.com>
Message-ID: <566E926E.7090903@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko,

Can you take the DT patches in this series via your tree.

I picked up nvmem patches from this series.

thanks,
srini

On 11/11/15 07:34, Caesar Wang wrote:
> This patch add the eFuse dt node for rk3066a SoCs.
>
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> ---
>
>   arch/arm/boot/dts/rk3066a.dtsi | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
>
> diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
> index 946f187..f61bb8a 100644
> --- a/arch/arm/boot/dts/rk3066a.dtsi
> +++ b/arch/arm/boot/dts/rk3066a.dtsi
> @@ -153,6 +153,19 @@
>   		clock-names = "timer", "pclk";
>   	};
>
> +	efuse: efuse at 20010000 {
> +		compatible = "rockchip,rockchip-efuse";
> +		reg = <0x20010000 0x4000>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		clocks = <&cru PCLK_EFUSE>;
> +		clock-names = "pclk_efuse";
> +
> +		cpu_leakage: cpu_leakage {
> +			reg = <0x17 0x1>;
> +		};
> +	};
> +
>   	timer at 20038000 {
>   		compatible = "snps,dw-apb-timer-osc";
>   		reg = <0x20038000 0x100>;
>
