From: SZ.Lin@moxa.com (=?big5?B?U1ogTGluICiqTKRXtLwp?=)
Date: Tue, 31 Oct 2017 05:58:53 +0000
Subject: [RESEND] ARM: dts: ls1021a: Add support for QSPI with ls1021a SoC
Message-ID: <5942081F7727964D830FC876E62CA85601194652AD@MHQMBX01.moxa.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Add QSPI node support, and this function is disabled by default This
> > setting could be overwritten in board-level definitions
>
> Adding Shawn Guo.
>
This patch is modified based on https://patchwork.ozlabs.org/patch/492099/. The originator of this patch is Haikun Wang.
> >
Signed-off-by: Haikun Wang <haikun.wang@freescale.com>
> > Signed-off-by: SZ Lin <sz.lin@moxa.com>
>
> Acked-by: Li Yang <leoyang.li@nxp.com>
>
> > ---
> >  arch/arm/boot/dts/ls1021a.dtsi | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/ls1021a.dtsi
> > b/arch/arm/boot/dts/ls1021a.dtsi index 7bb9df2c1460..9da876e47810
> > 100644
> > --- a/arch/arm/boot/dts/ls1021a.dtsi
> > +++ b/arch/arm/boot/dts/ls1021a.dtsi
> > @@ -154,6 +154,20 @@
> >                         big-endian;
> >                 };
> >
> > +               qspi: quadspi at 1550000 {
> > +                       compatible = "fsl,ls1021a-qspi";
> > +                       #address-cells = <1>;
> > +                       #size-cells = <0>;
> > +                       reg = <0x0 0x1550000 0x0 0x10000>,
> > +                             <0x0 0x40000000 0x0 0x40000000>;
> > +                       reg-names = "QuadSPI", "QuadSPI-memory";
> > +                       interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
> > +                       clock-names = "qspi_en", "qspi";
> > +                       clocks = <&clockgen 4 1>, <&clockgen 4 1>;
> > +                       big-endian;
> > +                       status = "disabled";
> > +               };
> > +
> >                 esdhc: esdhc at 1560000 {
> >                         compatible = "fsl,esdhc";
> >                         reg = <0x0 0x1560000 0x0 0x10000>;
> > --
> > 2.14.1
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe devicetree"
> > in the body of a message to majordomo at vger.kernel.org More majordomo
> > info at  http://vger.kernel.org/majordomo-info.html
