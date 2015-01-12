From: eddie.huang@mediatek.com (Eddie Huang)
Date: Mon, 12 Jan 2015 13:39:22 +0800
Subject: [PATCH v3 3/4] arm64: dts: Add mediatek MT8173 SoC and
 evaluation board dts and Makefile
In-Reply-To: <CABuKBe+=uTVFKCdpr7an-7jOZdQ91ERu0ObjfiW9fKv1CO1oAg@mail.gmail.com>
References: <1419582417-4448-1-git-send-email-eddie.huang@mediatek.com>
 <1419582417-4448-4-git-send-email-eddie.huang@mediatek.com>
 <CABuKBe+=uTVFKCdpr7an-7jOZdQ91ERu0ObjfiW9fKv1CO1oAg@mail.gmail.com>
Message-ID: <1421041162.2792.2.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matthias,

Thanks your review, I will modify in next version.


On Sun, 2015-01-11 at 21:12 +0100, Matthias Brugger wrote:
> 2014-12-26 9:26 GMT+01:00 Eddie Huang <eddie.huang@mediatek.com>:
> > Add device tree support for MT8173 SoC and evaluation board based on it.
> >
> > Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
> > ---
> >  arch/arm64/boot/dts/Makefile                |   1 +
> >  arch/arm64/boot/dts/mediatek/Makefile       |   5 +
> >  arch/arm64/boot/dts/mediatek/mt8173-evb.dts |  34 ++++++
> >  arch/arm64/boot/dts/mediatek/mt8173.dtsi    | 159 ++++++++++++++++++++++++++++
> >  4 files changed, 199 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/mediatek/Makefile
> >  create mode 100644 arch/arm64/boot/dts/mediatek/mt8173-evb.dts
> >  create mode 100644 arch/arm64/boot/dts/mediatek/mt8173.dtsi
> >
> > +
> > +       soc {
> > +               #address-cells = <2>;
> > +               #size-cells = <2>;
> > +               compatible = "simple-bus";
> > +               ranges;
> > +
> > +               sysirq: intpol-controller at 10200620 {
> > +                       compatible = "mediatek,mt8173-sysirq", "mediatek,mt6577-sysirq";
> 
> Please update the dts bindings for sysirq and add mediatek,mt8173-sysirq.
> Also check that the lines in this patch does not exceed the 80 character limit.
> 
> > +
> > +               uart0: serial at 11002000 {
> > +                       compatible = "mediatek,mt8173-uart","mediatek,mt6577-uart";
> 
> Please update the dts binding documentation.
> 
> > +                       reg = <0 0x11002000 0 0x400>;
> > +                       interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_LOW>;
> > +                       clocks = <&uart_clk>;
> > +               };
> 
> Please disable the uart ports in the dtsi and enable the one used by
> the board in the dts.
> See [0] and [1] on how to do this.
> 
> Apart from that, the series looks fine to me.
> 
> Thanks,
> Matthias
> 
> [0] https://github.com/mbgg/linux-mediatek/commit/0714947369cdb2b9b8cc24aa07264d4b61ea4fd9
> [1] https://github.com/mbgg/linux-mediatek/commit/ac00aa4dcd085e4cf01761095ec1e2a141f86f38
> 
