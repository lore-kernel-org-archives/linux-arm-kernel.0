From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 6 Oct 2017 11:34:27 +0200
Subject: [PATCH 19/20] ARM: dts: sun9i: Change node names to remove
 underscores
In-Reply-To: <CAGb2v65UhyGqU4mm0z1V7ioM3e=3UgFkpokAnuRB5U9qTuMjNQ@mail.gmail.com>
References: <cover.f5f905a5434f2a540d6844d23369a04af9f5314c.1507198895.git-series.maxime.ripard@free-electrons.com>
 <708449b45b1ef546a4c27d99bc68d6cc151e8ad3.1507198895.git-series.maxime.ripard@free-electrons.com>
 <CAGb2v65UhyGqU4mm0z1V7ioM3e=3UgFkpokAnuRB5U9qTuMjNQ@mail.gmail.com>
Message-ID: <20171006093427.qpsjvwa376kt2x73@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 05, 2017 at 03:56:29PM +0000, Chen-Yu Tsai wrote:
> On Thu, Oct 5, 2017 at 6:49 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Some node names in the A80 DTSI still have underscores in them. Remove them
> > in favour of hyphens to remove DTC warnings.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  arch/arm/boot/dts/sun9i-a80.dtsi | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
> > index f9cb701f29b0..70d79ef711b3 100644
> > --- a/arch/arm/boot/dts/sun9i-a80.dtsi
> > +++ b/arch/arm/boot/dts/sun9i-a80.dtsi
> > @@ -139,7 +139,7 @@
> >                  * would also throw all the PLL clock rates off, or just the
> >                  * downstream clocks in the PRCM.
> >                  */
> > -               osc24M: osc24M_clk {
> > +               osc24M: clk-24M {
> 
> Can we stick with the same style for all clks? Like "X-clk"?
> 
> >                         #clock-cells = <0>;
> >                         compatible = "fixed-clock";
> >                         clock-frequency = <24000000>;
> > @@ -151,7 +151,7 @@
> >                  * AC100 codec/RTC chip. This serves as a placeholder for
> >                  * board dts files to specify the source.
> >                  */
> > -               osc32k: osc32k_clk {
> > +               osc32k: clk-32k {
> 
> And here.

I guess that's the same argument for buttons. Most of the other nodes
are starting with the device class, and have a suffix to make them
generic.

> >                         #clock-cells = <0>;
> >                         compatible = "fixed-factor-clock";
> >                         clock-div = <1>;
> > @@ -169,7 +169,7 @@
> >                         clock-output-names = "cpus";
> >                 };
> >
> > -               ahbs: ahbs_clk {
> > +               ahbs: ahbs-clk {
> >                         compatible = "fixed-factor-clock";
> >                         #clock-cells = <0>;
> >                         clock-div = <1>;
> > @@ -708,12 +708,12 @@
> >                         #interrupt-cells = <3>;
> >                         #gpio-cells = <3>;
> >
> > -                       r_ir_pins: r_ir {
> > +                       r_ir_pins: r-ir {
> 
> "r-ir-pins".
> 
> >                                 pins = "PL6";
> >                                 function = "s_cir_rx";
> >                         };
> >
> > -                       r_rsb_pins: r_rsb {
> > +                       r_rsb_pins: r-rsb {
> 
> "r-rsb-pins".

I'll address those comments, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171006/10e5cbd4/attachment-0001.sig>
