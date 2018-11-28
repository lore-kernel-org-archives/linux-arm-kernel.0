From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 28 Nov 2018 15:02:00 +0100
Subject: [PATCH 65/77] ARM: dts: sunxi: reference: Move the muxing back
 to the common DTSI
In-Reply-To: <CAGb2v656FWyqqzmC9BJD0Am+ic1BEH+ntqxiW45sTsTQ28eixQ@mail.gmail.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <0d7bc6062323688d22b7873e2a1fa354ab42a0af.1543321707.git-series.maxime.ripard@bootlin.com>
 <CAGb2v656FWyqqzmC9BJD0Am+ic1BEH+ntqxiW45sTsTQ28eixQ@mail.gmail.com>
Message-ID: <20181128140200.stnkwd3q6cn5sgvl@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2018 at 08:41:46PM +0800, Chen-Yu Tsai wrote:
> On Tue, Nov 27, 2018 at 8:47 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > Now that all the SoCs using the tablet reference design DTSI are using the
> > same pinctrl naming scheme, we can move back the pinctrl phandles to the
> > main DTSI.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> > ---
> >  arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi |  8 --------
> >  arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi |  9 ---------
> >  arch/arm/boot/dts/sunxi-reference-design-tablet.dtsi |  6 +++---
> >  3 files changed, 3 insertions(+), 20 deletions(-)
> 
> [...]
> 
> > diff --git a/arch/arm/boot/dts/sunxi-reference-design-tablet.dtsi b/arch/arm/boot/dts/sunxi-reference-design-tablet.dtsi
> > index 00dc6623f30f..117198c52e1f 100644
> > --- a/arch/arm/boot/dts/sunxi-reference-design-tablet.dtsi
> > +++ b/arch/arm/boot/dts/sunxi-reference-design-tablet.dtsi
> > @@ -46,13 +46,13 @@
> >
> >  &i2c0 {
> >         pinctrl-names = "default";
> > -       pinctrl-0 = <&i2c0_pins_a>;
> > +       pinctrl-0 = <&i2c0_pins>;
> >         status = "okay";
> >  };
> >
> >  &i2c1 {
> >         pinctrl-names = "default";
> > -       pinctrl-0 = <&i2c1_pins_a>;
> > +       pinctrl-0 = <&i2c1_pins>;
> 
> I assume a build break was avoided because we were overriding these?

Yep, exactly.

> Acked-by: Chen-Yu Tsai <wens@csie.org>

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181128/69d8f386/attachment.sig>
