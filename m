From: bibby.hsieh@mediatek.com (Bibby Hsieh)
Date: Wed, 3 Aug 2016 09:46:56 +0800
Subject: [PATCH v4] arm64: dts: mt8173: add mmsel clocks for 4K support
In-Reply-To: <1469785990.3012.35.camel@pengutronix.de>
References: <1469783388-56804-1-git-send-email-bibby.hsieh@mediatek.com>
 <1469785990.3012.35.camel@pengutronix.de>
Message-ID: <1470188816.5418.8.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Philipp,

On Fri, 2016-07-29 at 11:53 +0200, Philipp Zabel wrote:
> Hi Bibby,
> 
> Am Freitag, den 29.07.2016, 17:09 +0800 schrieb Bibby Hsieh:
> > To support HDMI 4K resolution, mmsys need clcok
> > mm_sel to be 400MHz.
> > 
> > The board .dts file should override the clock rate
> > property with the higher VENCPLL frequency the board
> > supports HDMI 4K resolution.
> > 
> > Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> > ---
> >  arch/arm64/boot/dts/mediatek/mt8173.dtsi |    2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> > index 78529e4..93d4d17 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> > @@ -690,6 +690,8 @@
> >  			compatible = "mediatek,mt8173-mmsys", "syscon";
> >  			reg = <0 0x14000000 0 0x1000>;
> >  			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
> > +			clocks = <&topckgen CLK_TOP_MM_SEL>;
> > +			clock-frequency  = <400000000>;
> 
> This is unchanged compared to v3, I suggest to use assigned-clocks /
> assigned-clock-rates properties instead.
> 
Ok, I will change that, thanks for your review.

-- 
Bibby
> best regards
> Philipp
> 
