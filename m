From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 29 Jul 2016 11:53:10 +0200
Subject: [PATCH v4] arm64: dts: mt8173: add mmsel clocks for 4K support
In-Reply-To: <1469783388-56804-1-git-send-email-bibby.hsieh@mediatek.com>
References: <1469783388-56804-1-git-send-email-bibby.hsieh@mediatek.com>
Message-ID: <1469785990.3012.35.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bibby,

Am Freitag, den 29.07.2016, 17:09 +0800 schrieb Bibby Hsieh:
> To support HDMI 4K resolution, mmsys need clcok
> mm_sel to be 400MHz.
> 
> The board .dts file should override the clock rate
> property with the higher VENCPLL frequency the board
> supports HDMI 4K resolution.
> 
> Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> index 78529e4..93d4d17 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> @@ -690,6 +690,8 @@
>  			compatible = "mediatek,mt8173-mmsys", "syscon";
>  			reg = <0 0x14000000 0 0x1000>;
>  			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
> +			clocks = <&topckgen CLK_TOP_MM_SEL>;
> +			clock-frequency  = <400000000>;

This is unchanged compared to v3, I suggest to use assigned-clocks /
assigned-clock-rates properties instead.

best regards
Philipp
