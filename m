From: horms@verge.net.au (Simon Horman)
Date: Wed, 16 May 2018 10:55:45 +0200
Subject: [PATCH v2] ARM: dts: r8a7740: Add CEU1
In-Reply-To: <CAMuHMdXzc3YLm8u+JgQMhXtErAgBgc4bti9cyUboPZmpB+rVyg@mail.gmail.com>
References: <20180515080038.7438-1-horms+renesas@verge.net.au>
 <CAMuHMdXzc3YLm8u+JgQMhXtErAgBgc4bti9cyUboPZmpB+rVyg@mail.gmail.com>
Message-ID: <20180516085544.lv2xicy6gaolzaf7@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 16, 2018 at 09:40:10AM +0200, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Tue, May 15, 2018 at 10:00 AM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > Describe CEU1 peripheral for Renesas R-Mobile A1 R8A7740 Soc.
> >
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > ---
> > v2
> > * Correct register range start address
> 
> Thanks for your patch!
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Minor question below.
> 
> > --- a/arch/arm/boot/dts/r8a7740.dtsi
> > +++ b/arch/arm/boot/dts/r8a7740.dtsi
> > @@ -77,6 +77,16 @@
> >                 status = "disabled";
> >         };
> >
> > +       ceu1: ceu at fe914000 {
> > +               reg = <0xfe914000 0x3000>;
> > +               compatible = "renesas,r8a7740-ceu";
> > +               interrupts = <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>;
> > +               clocks = <&mstp1_clks R8A7740_CLK_CEU21>;
> > +               clock-names = "ceu21";
> 
> Why the "clock-names" property? It's not mentioned in the DT bindings, and
> may cause issues if the bindings are ever amended.

Thanks, I copied this from CEU0 where you have also raised the same issue.
I have dropped the property for now.
