From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 28 Nov 2018 11:42:30 +0100
Subject: [PATCH 10/77] ARM: dts: sun5i: Remove all useless pinctrl nodes
In-Reply-To: <CAGb2v64rQ25Q1Q2JLXUw8wjya-Rvf7-jW1vzGW0zSMQiZhRxbA@mail.gmail.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <820ad10fea1f06f9be94497f82df3cd6cad070b1.1543321707.git-series.maxime.ripard@bootlin.com>
 <CAGb2v64rQ25Q1Q2JLXUw8wjya-Rvf7-jW1vzGW0zSMQiZhRxbA@mail.gmail.com>
Message-ID: <20181128104230.do6bxtmmymc3varp@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2018 at 11:28:57AM +0800, Chen-Yu Tsai wrote:
> On Tue, Nov 27, 2018 at 8:46 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > The gpio pinctrl nodes are redundant and as such useless most of the times.
> > Since they will also generate warnings in DTC, we can simply remove most of
> > them.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> > ---
> >  arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts         |  6 +---
> >  arch/arm/boot/dts/sun5i-a10s-mk802.dts               | 13 +------
> >  arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts     |  6 +---
> >  arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts        |  6 +---
> >  arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts             | 14 +-------
> >  arch/arm/boot/dts/sun5i-a13-hsg-h702.dts             |  7 +---
> >  arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts      | 12 +------
> >  arch/arm/boot/dts/sun5i-a13-olinuxino.dts            |  6 +---
> >  arch/arm/boot/dts/sun5i-a13-utoo-p66.dts             |  8 +----
> >  arch/arm/boot/dts/sun5i-gr8-chip-pro.dts             | 16 +--------
> >  arch/arm/boot/dts/sun5i-gr8-evb.dts                  | 27 +-------------
> >  arch/arm/boot/dts/sun5i-r8-chip.dts                  | 19 +---------
> >  arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi | 21 +----------
> >  13 files changed, 2 insertions(+), 159 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts b/arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts
> > index 8d4fb9331212..d5bca68ca6ca 100644
> > --- a/arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts
> > +++ b/arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts
> > @@ -72,7 +72,6 @@
> >         reg_vmmc1: vmmc1 {
> >                 compatible = "regulator-fixed";
> >                 pinctrl-names = "default";
> 
> You can also drop pinctrl-names? Or is it actually desired?
> IIRC the pinctrl core complains if it can't find a default setting.

Yeah, I just forgot to remove this one. I've fixed it, and applied, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181128/75632566/attachment.sig>
