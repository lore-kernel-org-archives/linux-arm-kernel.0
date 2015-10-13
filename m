From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 13 Oct 2015 11:38:45 +0100
Subject: [PATCH 2/4] mmc: dt-bindings: update Mediatek MMC bindings
In-Reply-To: <1444729078-26585-3-git-send-email-chaotian.jing@mediatek.com>
References: <1444729078-26585-1-git-send-email-chaotian.jing@mediatek.com>
 <1444729078-26585-3-git-send-email-chaotian.jing@mediatek.com>
Message-ID: <20151013103845.GA4189@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 13, 2015 at 05:37:56PM +0800, Chaotian Jing wrote:
> Add 400Mhz clock source for HS400 mode
> 
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> ---
>  Documentation/devicetree/bindings/mmc/mtk-sd.txt | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.txt b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> index a1adfa4..745bee2 100644
> --- a/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> @@ -17,6 +17,11 @@ Required properties:
>  - vmmc-supply: power to the Core
>  - vqmmc-supply: power to the IO
>  
> +Optional properties:
> +- clocks: 400mhz clock source for HS400
> +- clock-names: "400mhz"

Is that really what the input line is called?

> +- hs400-ds-delay: HS400 DS delay setting

What is the format of this? Where can I derive the correct value?

Mark.

> +
>  Examples:
>  mmc0: mmc at 11230000 {
>  	compatible = "mediatek,mt8173-mmc", "mediatek,mt8135-mmc";
> @@ -24,9 +29,12 @@ mmc0: mmc at 11230000 {
>  	interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_LOW>;
>  	vmmc-supply = <&mt6397_vemc_3v3_reg>;
>  	vqmmc-supply = <&mt6397_vio18_reg>;
> -	clocks = <&pericfg CLK_PERI_MSDC30_0>, <&topckgen CLK_TOP_MSDC50_0_H_SEL>;
> -	clock-names = "source", "hclk";
> +	clocks = <&pericfg CLK_PERI_MSDC30_0>,
> +	         <&topckgen CLK_TOP_MSDC50_0_H_SEL>,
> +		 <&topckgen CLK_TOP_MSDCPLL_D2> ;
> +	clock-names = "source", "hclk", "400mhz";
>  	pinctrl-names = "default", "state_uhs";
>  	pinctrl-0 = <&mmc0_pins_default>;
>  	pinctrl-1 = <&mmc0_pins_uhs>;
> +	hs400-ds-delay = <0x14015>;
>  };
> -- 
> 1.8.1.1.dirty
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
