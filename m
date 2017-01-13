From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri, 13 Jan 2017 15:38:44 +0100
Subject: [PATCH 1/3] arm: dts: mt2701: Sort DT nodes by register address
In-Reply-To: <1482904006-44232-2-git-send-email-jamesjj.liao@mediatek.com>
References: <1482904006-44232-1-git-send-email-jamesjj.liao@mediatek.com>
 <1482904006-44232-2-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <bcc5c785-be25-d63b-3041-ae0009a9dc72@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 28/12/16 06:46, James Liao wrote:
> This patch rearrange MT2701 DT nodes to keep them in ascending order.
>
> Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
> ---
>  arch/arm/boot/dts/mt2701.dtsi | 36 ++++++++++++++++++------------------
>  1 file changed, 18 insertions(+), 18 deletions(-)
>
> diff --git a/arch/arm/boot/dts/mt2701.dtsi b/arch/arm/boot/dts/mt2701.dtsi
> index 7eab6f4..73f4b7c 100644
> --- a/arch/arm/boot/dts/mt2701.dtsi
> +++ b/arch/arm/boot/dts/mt2701.dtsi
> @@ -96,24 +96,6 @@
>  			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
>  	};
>
> -	pio: pinctrl at 10005000 {
> -		compatible = "mediatek,mt2701-pinctrl";
> -		reg = <0 0x1000b000 0 0x1000>;
> -		mediatek,pctl-regmap = <&syscfg_pctl_a>;
> -		pins-are-numbered;
> -		gpio-controller;
> -		#gpio-cells = <2>;
> -		interrupt-controller;
> -		#interrupt-cells = <2>;
> -		interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
> -	};

Applied the whole series. I fixed the unit address of pio to 1000b000 
and it's order in the file.

Please check v4.10-next/dts32

Thanks,
Mathias

> -
> -	syscfg_pctl_a: syscfg at 10005000 {
> -		compatible = "mediatek,mt2701-pctl-a-syscfg", "syscon";
> -		reg = <0 0x10005000 0 0x1000>;
> -	};
> -
>  	topckgen: syscon at 10000000 {
>  		compatible = "mediatek,mt2701-topckgen", "syscon";
>  		reg = <0 0x10000000 0 0x1000>;
> @@ -134,6 +116,24 @@
>  		#reset-cells = <1>;
>  	};
>
> +	pio: pinctrl at 10005000 {
> +		compatible = "mediatek,mt2701-pinctrl";
> +		reg = <0 0x1000b000 0 0x1000>;
> +		mediatek,pctl-regmap = <&syscfg_pctl_a>;
> +		pins-are-numbered;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +		interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
> +	};
> +
> +	syscfg_pctl_a: syscfg at 10005000 {
> +		compatible = "mediatek,mt2701-pctl-a-syscfg", "syscon";
> +		reg = <0 0x10005000 0 0x1000>;
> +	};
> +
>  	watchdog: watchdog at 10007000 {
>  		compatible = "mediatek,mt2701-wdt",
>  			     "mediatek,mt6589-wdt";
>
