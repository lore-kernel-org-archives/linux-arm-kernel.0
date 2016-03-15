From: horms@verge.net.au (Simon Horman)
Date: Tue, 15 Mar 2016 09:23:50 +0900
Subject: [PATCH 2/2] ARM: dts: r8a7794: add CAN nodes to device tree
In-Reply-To: <CAMuHMdUOQjL0mbcmfDSyZQgrRbH9TbxBCAx8r18pm64+7C1XYw@mail.gmail.com>
References: <1457922543-20975-1-git-send-email-horms+renesas@verge.net.au>
 <1457922543-20975-3-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdUOQjL0mbcmfDSyZQgrRbH9TbxBCAx8r18pm64+7C1XYw@mail.gmail.com>
Message-ID: <20160315002349.GB23279@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 14, 2016 at 10:28:40AM +0100, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Mon, Mar 14, 2016 at 3:29 AM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > Add CAN nodes to r8a7794 device tree.
> >
> > Based on work by Sergei Shtylyov for the r8a7791 SoC.
> >
> > Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> > ---
> >  arch/arm/boot/dts/r8a7794.dtsi            | 22 ++++++++++++++++++++++
> >  include/dt-bindings/clock/r8a7794-clock.h |  2 ++
> >  2 files changed, 24 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
> > index c8742a599330..ab755b754a9e 100644
> > --- a/arch/arm/boot/dts/r8a7794.dtsi
> > +++ b/arch/arm/boot/dts/r8a7794.dtsi
> > @@ -830,6 +830,28 @@
> >                 };
> >         };
> >
> > +       can0: can at e6e80000 {
> > +               compatible = "renesas,can-r8a7794", "renesas,rcar-gen2-can";
> > +               reg = <0 0xe6e80000 0 0x1000>;
> > +               interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
> > +               clocks = <&mstp9_clks R8A7794_CLK_RCAN0>,
> 
> I don't think mstp9_clks already defines the can module clocks?

Oops, I will add them.
