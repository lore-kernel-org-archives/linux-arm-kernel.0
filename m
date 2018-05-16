From: horms@verge.net.au (Simon Horman)
Date: Wed, 16 May 2018 09:43:34 +0200
Subject: [PATCH 3/3] arm64: dts: renesas: r8a7795: add ccree binding
In-Reply-To: <CAMuHMdWzeNqsho1V6ezZb81T3_HcRzrtuQpmGXsjtFgt9BtZDQ@mail.gmail.com>
References: <1526387370-17142-1-git-send-email-gilad@benyossef.com>
 <1526387370-17142-4-git-send-email-gilad@benyossef.com>
 <CAMuHMdWzeNqsho1V6ezZb81T3_HcRzrtuQpmGXsjtFgt9BtZDQ@mail.gmail.com>
Message-ID: <20180516074333.i2672u435ymwffk3@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 15, 2018 at 04:50:44PM +0200, Geert Uytterhoeven wrote:
> Hi Gilad,
> 
> On Tue, May 15, 2018 at 2:29 PM, Gilad Ben-Yossef <gilad@benyossef.com> wrote:
> > Add bindings for CryptoCell instance in the SoC.
> >
> > Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
> 
> Thanks for your patch!
> 
> > --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> > +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> > @@ -528,6 +528,14 @@
> >                         status = "disabled";
> >                 };
> >
> > +               arm_cc630p: crypto at e6601000 {
> > +                       compatible = "arm,cryptocell-630p-ree";
> > +                       interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
> > +                       #interrupt-cells = <2>;
> 
> I believe the #interrupt-cells property is not needed.
> 
> > +                       reg = <0x0 0xe6601000 0 0x1000>;
> > +                       clocks = <&cpg CPG_MOD 229>;
> > +               };
> 
> The rest looks good, but I cannot verify the register block.
> 
> > +
> >                 i2c3: i2c at e66d0000 {
> >                         #address-cells = <1>;
> >                         #size-cells = <0>;

Thanks, I have applied this after dropping the #interrupt-cells property.
