From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 22 Nov 2018 20:33:29 +0800
Subject: [PATCH v2 3/4] ARM: dts: sun8i: Add the H3/H5 CSI controller
In-Reply-To: <CAMty3ZDFsaFR1zb3Wt0wJ0XkeNuSHGxDsmZZKgWy=wxJpNTnHQ@mail.gmail.com>
References: <20181114145934.26855-1-maxime.ripard@bootlin.com>
 <20181114145934.26855-4-maxime.ripard@bootlin.com>
 <CAMty3ZDFsaFR1zb3Wt0wJ0XkeNuSHGxDsmZZKgWy=wxJpNTnHQ@mail.gmail.com>
Message-ID: <CAGb2v67dprbvVNtR-ciH+1d1EsmCejmAMBQ_-y-Jb6Z3S11abA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 22, 2018 at 7:45 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> On Wed, Nov 14, 2018 at 8:29 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > From: Myl?ne Josserand <mylene.josserand@bootlin.com>
> >
> > The H3 and H5 features the same CSI controller that was initially found on
> > the A31.
> >
> > Add a DT node for it.
> >
> > Signed-off-by: Myl?ne Josserand <mylene.josserand@bootlin.com>
> > Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> > ---
> >  arch/arm/boot/dts/sunxi-h3-h5.dtsi | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> > index 4b1530ebe427..8779ee750bd8 100644
> > --- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> > +++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> > @@ -393,6 +393,13 @@
> >                         interrupt-controller;
> >                         #interrupt-cells = <3>;
> >
> > +                       csi_pins: csi {
> > +                               pins = "PE0", "PE1", "PE2", "PE3", "PE4",
> > +                                      "PE5", "PE6", "PE7", "PE8", "PE9",
> > +                                      "PE10", "PE11";
> > +                               function = "csi";
> > +                       };
> > +
> >                         emac_rgmii_pins: emac0 {
> >                                 pins = "PD0", "PD1", "PD2", "PD3", "PD4",
> >                                        "PD5", "PD7", "PD8", "PD9", "PD10",
> > @@ -744,6 +751,21 @@
> >                         interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
> >                 };
> >
> > +               csi: camera at 1cb0000 {
> > +                       compatible = "allwinner,sun8i-h3-csi",
> > +                                    "allwinner,sun6i-a31-csi";
> > +                       reg = <0x01cb0000 0x1000>;
> > +                       interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
> > +                       clocks = <&ccu CLK_BUS_CSI>,
> > +                                <&ccu CLK_CSI_SCLK>,
> > +                                <&ccu CLK_DRAM_CSI>;
> > +                       clock-names = "bus", "mod", "ram";
>
> Don't we need CLK_CSI_MCLK which can be pinout via PE1?

The CSI hardware block does not have any controls for MCLK.
It's simply routed from the CCU directly to the pin.

ChenYu
