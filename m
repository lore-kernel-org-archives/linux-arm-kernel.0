From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 29 Jul 2017 23:12:00 +0200
Subject: [PATCH v1 2/2] arm64: dts: rockchip: add rk3328 spdif node
In-Reply-To: <1501143365-76104-3-git-send-email-sugar.zhang@rock-chips.com>
References: <1501143365-76104-1-git-send-email-sugar.zhang@rock-chips.com>
 <1501143365-76104-3-git-send-email-sugar.zhang@rock-chips.com>
Message-ID: <2919371.Go0PDiTJp1@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 27. Juli 2017, 16:16:04 CEST schrieb Sugar Zhang:
> This patch add the spdif dt node for rk3328.
> 
> Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
> 
> ---
> 
>  arch/arm64/boot/dts/rockchip/rk3328.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> index f1a284b..d278670 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> @@ -189,6 +189,19 @@
>  		status = "disabled";
>  	};
>  

I've adapted the patch so that it can exist without the previous one
and applied it for 4.14.


Thanks
Heiko


> +	spdif: spdif at ff030000 {
> +		compatible = "rockchip,rk3328-spdif";
> +		reg = <0x0 0xff030000 0x0 0x1000>;
> +		interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&cru SCLK_SPDIF>, <&cru HCLK_SPDIF_8CH>;
> +		clock-names = "mclk", "hclk";
> +		dmas = <&dmac 10>;
> +		dma-names = "tx";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&spdifm2_tx>;
> +		status = "disabled";
> +	};
> +
>  	grf: syscon at ff100000 {
>  		compatible = "rockchip,rk3328-grf", "syscon", "simple-mfd";
>  		reg = <0x0 0xff100000 0x0 0x1000>;
> 
