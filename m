From: bibby.hsieh@mediatek.com (Bibby Hsieh)
Date: Thu, 28 Jul 2016 10:49:25 +0800
Subject: [PATCH v3] arm64: dts: mt8173: add mmsel clocks for 4K support
In-Reply-To: <1469611964.2470.30.camel@pengutronix.de>
References: <1469607914-64831-1-git-send-email-bibby.hsieh@mediatek.com>
 <1469611964.2470.30.camel@pengutronix.de>
Message-ID: <1469674165.29230.1.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Philipp,

Thanks for your comments.

On Wed, 2016-07-27 at 11:32 +0200, Philipp Zabel wrote:
> Am Mittwoch, den 27.07.2016, 16:25 +0800 schrieb Bibby Hsieh:
> > If MT8173 can support HDMI 4K resoultion, the
> > VENCPLL should be configured to 800MHZ.
> > We didn't set VENCPLL directly, we set the
> > mm_sel to 400MHz statically in the board device tree.
> 
> Maybe add a comment that the board .dts file should override the clock
> rate property with the higher VENCPLL frequency the board supports HDMI
> 4K resolution.
> 
Ok, I will add that.
> > Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> > ---
> > Changes since v2:
> >  - Align the clocks of dpi0 node.
> > 
> > Changes since v1:
> >  - Do not set the VENCPLL by clk_set_rate
> >    at display driver.
> >  - Configure the mm_sel to 400MHz statically
> >    in the board device tree.
> > ---
> >  arch/arm64/boot/dts/mediatek/mt8173.dtsi |    2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> > index 78529e4..9c22204 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> > @@ -690,7 +690,9 @@
> >  			compatible = "mediatek,mt8173-mmsys", "syscon";
> >  			reg = <0 0x14000000 0 0x1000>;
> >  			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
> > +			clocks = <&topckgen CLK_TOP_MM_SEL>;
> >  			#clock-cells = <1>;
> > +			clock-frequency  = <400000000>;
> 
> According to the "Assigned clock parents and rates" section in
> Documentation/devicetree/bindings/clock/clock-bindings.txt,
> this should be:
> 			assigned-clocks = <&topckgen CLK_TOP_MM_SEL>;
> 			assigned-clock-rates = <400000000>;
> 
Ok, will do.
> regards
> Philipp
> 

-- 
Bibby
