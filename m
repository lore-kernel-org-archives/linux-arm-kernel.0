From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 03 Nov 2014 10:41:09 +0100
Subject: [PATCH v2 3/3] ARM: dts: mt8135: Add Reset Controller for
 MediaTek SoC
In-Reply-To: <1415005371-4323-4-git-send-email-flora.fu@mediatek.com>
References: <1415005371-4323-1-git-send-email-flora.fu@mediatek.com>
 <1415005371-4323-4-git-send-email-flora.fu@mediatek.com>
Message-ID: <1415007669.3060.6.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, den 03.11.2014, 17:02 +0800 schrieb Flora Fu:
> Add reset controller to MT8135 board dts.
> 
> Signed-off-by: Flora Fu <flora.fu@mediatek.com>
> ---
>  arch/arm/boot/dts/mt8135.dtsi | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/mt8135.dtsi b/arch/arm/boot/dts/mt8135.dtsi
> index 90a56ad..259a2b5 100644
> --- a/arch/arm/boot/dts/mt8135.dtsi
> +++ b/arch/arm/boot/dts/mt8135.dtsi
> @@ -102,6 +102,32 @@
>  			clock-names = "system-clk", "rtc-clk";
>  		};
>  
> +		infracfg: syscon at 10001000 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;

Same as with patch 2, please use #size-cells = <1>.

> +			compatible = "mediatek,mt8135-infracfg", "syscon";
> +			reg = <0 0x10001000 0 0x1000>;
> +
> +			infrarst: reset-controller at 30 {
> +				#reset-cells = <1>;
> +				compatible = "mediatek,mt8135-infracfg-reset", "mediatek,reset";
> +				reg = <0x30 0x8>;
> +			};
> +		};
> +
> +		pericfg: syscon at 10003000 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;

And here. Other than that,
Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

> +			compatible = "mediatek,mt8135-pericfg", "syscon";
> +			reg = <0 0x10003000 0 0x1000>;
> +
> +			perirst: reset-controller at 00 {
> +				#reset-cells = <1>;
> +				compatible = "mediatek,mt8135-pericfg-reset", "mediatek,reset";
> +				reg = <0x00 0x8>;
> +			};
> +		};
> +
>  		gic: interrupt-controller at 10211000 {
>  			compatible = "arm,cortex-a15-gic";
>  			interrupt-controller;

regards
Philipp
