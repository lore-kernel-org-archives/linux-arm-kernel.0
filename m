From: leilk.liu@mediatek.com (lei liu)
Date: Mon, 26 Oct 2015 13:39:48 +0800
Subject: [PATCH 5/5] arm64: dts: spi bus dts support multiple devices
In-Reply-To: <20151014055809.GN7858@pengutronix.de>
References: <1444793015-30359-1-git-send-email-leilk.liu@mediatek.com>
 <1444793015-30359-6-git-send-email-leilk.liu@mediatek.com>
 <20151014055809.GN7858@pengutronix.de>
Message-ID: <1445837988.24921.1.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Wed, 2015-10-14 at 07:58 +0200, Sascha Hauer wrote:
> On Wed, Oct 14, 2015 at 11:23:35AM +0800, Leilk Liu wrote:
> > This patch support multiple devices for MT8173.
> 
> The subject of this patch and also the above sentence should contain the
> board name this patch is changing so that the reader knows this is about
> a single board, and not arm64 in general.
> 
OK, I'll fix it.

> Sascha
> 
> > 
> > Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
> > ---
> >  arch/arm64/boot/dts/mediatek/mt8173-evb.dts | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
> > index 04b38ed..1c8c407 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
> > +++ b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
> > @@ -194,7 +194,7 @@
> >  			pinmux = <MT8173_PIN_69_SPI_CK__FUNC_SPI_CK_0_>,
> >  				<MT8173_PIN_70_SPI_MI__FUNC_SPI_MI_0_>,
> >  				<MT8173_PIN_71_SPI_MO__FUNC_SPI_MO_0_>,
> > -				<MT8173_PIN_72_SPI_CS__FUNC_SPI_CS_0_>;
> > +				<MT8173_PIN_72_SPI_CS__FUNC_GPIO72>;
> >  		};
> >  	};
> >  };
> > @@ -399,6 +399,7 @@
> >  &spi {
> >  	pinctrl-names = "default";
> >  	pinctrl-0 = <&spi_pins_a>;
> > +	cs-gpios = <&pio 72 0>;
> >  	mediatek,pad-select = <0>;
> >  	status = "okay";
> >  };
> > -- 
> > 1.8.1.1.dirty
> > 
> > 
> 
