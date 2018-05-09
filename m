From: horms@verge.net.au (Simon Horman)
Date: Wed, 9 May 2018 19:54:30 +0200
Subject: [PATCH 1/2] arm64: dts: renesas: r8a77980: add CAN-FD support
In-Reply-To: <CAMuHMdWFLC=kyHKVuq4KByO=KFf2eHvXu0_g2HqGoZT7gKkNDA@mail.gmail.com>
References: <c184f961-2f98-532f-ed02-6f3751256d9c@cogentembedded.com>
 <f07c00b3-228c-e0d2-f7fe-38b8e9f25a4d@cogentembedded.com>
 <CAMuHMdWFLC=kyHKVuq4KByO=KFf2eHvXu0_g2HqGoZT7gKkNDA@mail.gmail.com>
Message-ID: <20180509175430.aw7xaodaicipewbw@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 04, 2018 at 09:52:38AM +0200, Geert Uytterhoeven wrote:
> Hi Sergei,
> 
> On Fri, Apr 27, 2018 at 9:12 PM, Sergei Shtylyov
> <sergei.shtylyov@cogentembedded.com> wrote:
> > Define the generic R8A77980 part of the CAN-FD device node.
> >
> > Based on the original (and large) patch by Vladimir Barinov.
> >
> > Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> > Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> Thanks for your patch!
> 
> > --- renesas.orig/arch/arm64/boot/dts/renesas/r8a77980.dtsi
> > +++ renesas/arch/arm64/boot/dts/renesas/r8a77980.dtsi
> =
> > @@ -170,6 +177,30 @@
> >                         status = "disabled";
> >                 };
> >
> > +               canfd: can at e66c0000 {
> > +                       compatible = "renesas,r8a77980-canfd",
> > +                                    "renesas,rcar-gen3-canfd";
> > +                       reg = <0 0xe66c0000 0 0x8000>;
> > +                       interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>,
> > +                                    <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
> > +                       clocks = <&cpg CPG_MOD 914>,
> > +                                <&cpg CPG_CORE R8A77980_CLK_CANFD>,
> > +                                <&can_clk>;
> > +                       clock-names = "fck", "canfd", "can_clk";
> > +                       assigned-clocks = <&cpg CPG_CORE R8A77980_CLK_CANFD>;
> > +                       assigned-clock-rates = <40000000>;
> > +                       power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
> 
> You forgot the resets property.

Thanks, I have sent a follow-up patch.
