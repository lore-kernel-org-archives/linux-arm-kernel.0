From: horms@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 11:50:38 +0200
Subject: [PATCH 3/3] arm64: dts: renesas: r8a7795: add ccree binding
In-Reply-To: <CAOtvUMcnrPnkx35Sgru+3EUxYn+FY9FmDSYSNnZEaVUODHA7+w@mail.gmail.com>
References: <1526387370-17142-1-git-send-email-gilad@benyossef.com>
 <1526387370-17142-4-git-send-email-gilad@benyossef.com>
 <CAMuHMdWzeNqsho1V6ezZb81T3_HcRzrtuQpmGXsjtFgt9BtZDQ@mail.gmail.com>
 <20180516074333.i2672u435ymwffk3@verge.net.au>
 <CAOtvUMfFjokOLCg6aHNQESJ_q4Jiok3izrPtae5wR+cND=XL6g@mail.gmail.com>
 <20180517090438.pqggltzkcdhzktsp@verge.net.au>
 <CAOtvUMcnrPnkx35Sgru+3EUxYn+FY9FmDSYSNnZEaVUODHA7+w@mail.gmail.com>
Message-ID: <20180518095038.lti4lzeadxd4kqsy@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 17, 2018 at 04:12:23PM +0300, Gilad Ben-Yossef wrote:
> On Thu, May 17, 2018 at 12:04 PM, Simon Horman <horms@verge.net.au> wrote:
> > On Thu, May 17, 2018 at 11:01:57AM +0300, Gilad Ben-Yossef wrote:
> >> On Wed, May 16, 2018 at 10:43 AM, Simon Horman <horms@verge.net.au> wrote:
> >> > On Tue, May 15, 2018 at 04:50:44PM +0200, Geert Uytterhoeven wrote:
> >> >> Hi Gilad,
> >> >>
> >> >> On Tue, May 15, 2018 at 2:29 PM, Gilad Ben-Yossef <gilad@benyossef.com> wrote:
> >> >> > Add bindings for CryptoCell instance in the SoC.
> >> >> >
> >> >> > Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
> >> >>
> >> >> Thanks for your patch!
> >> >>
> >> >> > --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> >> >> > +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> >> >> > @@ -528,6 +528,14 @@
> >> >> >                         status = "disabled";
> >> >> >                 };
> >> >> >
> >> >> > +               arm_cc630p: crypto at e6601000 {
> >> >> > +                       compatible = "arm,cryptocell-630p-ree";
> >> >> > +                       interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
> >> >> > +                       #interrupt-cells = <2>;
> >> >>
> >> >> I believe the #interrupt-cells property is not needed.
> >> >>
> >> >> > +                       reg = <0x0 0xe6601000 0 0x1000>;
> >> >> > +                       clocks = <&cpg CPG_MOD 229>;
> >> >> > +               };
> >> >>
> >> >> The rest looks good, but I cannot verify the register block.
> >> >>
> >> >> > +
> >> >> >                 i2c3: i2c at e66d0000 {
> >> >> >                         #address-cells = <1>;
> >> >> >                         #size-cells = <0>;
> >> >
> >> > Thanks, I have applied this after dropping the #interrupt-cells property.
> >>
> >> Thanks you!
> >>
> >> Alas, it will not work without the clk patch (the previous one in the
> >> series) so they need to be
> >> taken or dropped together.
> >
> > I think its fine if it does not yet work.
> > But not if its causes things that previously worked to stop working.
> 
> Based on the further discussion with Geert my recommendation is to
> drop my patch for now,
> take Geert CR clock  patch and I will follow up next week with a v2
> that fixes the clock
> handing as discussed with Geert.

Thanks, I will drop the patch.
