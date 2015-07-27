From: jianwei.wang.chn@gmail.com (Jianwei Wang)
Date: Mon, 27 Jul 2015 10:39:17 +0800
Subject: [PATCH v12 4/6] arm/dts/ls1021a: Add DCU dts node
In-Reply-To: <20150725032747.GH12927@tiger>
References: <1437734054-36163-1-git-send-email-jianwei.wang.chn@gmail.com>
 <1437734054-36163-5-git-send-email-jianwei.wang.chn@gmail.com>
 <20150725032747.GH12927@tiger>
Message-ID: <CANk3uyCOJfmaE-t+Uh90UQFwzc+btpSkFaQKupTd9oab-=_hOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 25, 2015 at 11:27 AM, Shawn Guo <shawnguo@kernel.org> wrote:
>
> On Fri, Jul 24, 2015 at 06:34:12PM +0800, Jianwei Wang wrote:
> > Add DCU node, DCU is a display controller of Freescale
> > named 2D-ACE.
> >
> > Signed-off-by: Alison Wang <b18965@freescale.com>
> > Signed-off-by: Xiubo Li <lixiubo@cmss.chinamobile.com>
> > Signed-off-by: Jianwei Wang <jianwei.wang.chn@gmail.com>
>
> For dts patches sent to me, please use prefix like "ARM: dts: ls1021a:
> ..." in the subject.
>
> Shawn

Okay, thanks.

Jianwei

>
> > ---
> >  arch/arm/boot/dts/ls1021a.dtsi | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
> > index c70bb27..6d6e3e2 100644
> > --- a/arch/arm/boot/dts/ls1021a.dtsi
> > +++ b/arch/arm/boot/dts/ls1021a.dtsi
> > @@ -383,6 +383,16 @@
> >                                <&platform_clk 1>;
> >               };
> >
> > +             dcu: dcu at 2ce0000 {
> > +                     compatible = "fsl,ls1021a-dcu";
> > +                     reg = <0x0 0x2ce0000 0x0 0x10000>;
> > +                     interrupts = <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH>;
> > +                     clocks = <&platform_clk 0>;
> > +                     clock-names = "dcu";
> > +                     big-endian;
> > +                     status = "disabled";
> > +             };
> > +
> >               mdio0: mdio at 2d24000 {
> >                       compatible = "gianfar";
> >                       device_type = "mdio";
> > --
> > 2.1.0.27.g96db324
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> >
