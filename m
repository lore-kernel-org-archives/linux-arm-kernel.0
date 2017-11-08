From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 8 Nov 2017 08:48:58 +0100
Subject: [PATCH 1/2] ARM: sun8i: a83t: add dwmac-sun8i ethernet driver
In-Reply-To: <CAGb2v64zkEoy=_9D7g+GC5ZxYg_zuaTo3LL1e=4RXLnL0VDWaA@mail.gmail.com>
References: <20171107201326.17401-1-clabbe.montjoie@gmail.com>
 <CAGb2v64zkEoy=_9D7g+GC5ZxYg_zuaTo3LL1e=4RXLnL0VDWaA@mail.gmail.com>
Message-ID: <20171108074858.ompog5in7xi776d6@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 08, 2017 at 02:27:21PM +0800, Chen-Yu Tsai wrote:
> On Wed, Nov 8, 2017 at 4:13 AM, Corentin Labbe
> <clabbe.montjoie@gmail.com> wrote:
> > The dwmac-sun8i is an ethernet MAC hardware that support 10/100/1000 speed.
> > This patch enable the dwmac-sun8i on the Allwinner a83t SoC Device-tree.
> 
> The subject should say "add .... device node", not driver.
> 
> >
> > Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> > Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> > ---
> >  arch/arm/boot/dts/sun8i-a83t.dtsi | 29 +++++++++++++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
> > index 19acae1b4089..68e5135410ec 100644
> > --- a/arch/arm/boot/dts/sun8i-a83t.dtsi
> > +++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
> > @@ -336,6 +336,14 @@
> >                         #interrupt-cells = <3>;
> >                         #gpio-cells = <3>;
> >
> > +                       emac_rgmii_pins: emac-rgmii-pins {
> > +                               pins = "PD2", "PD3", "PD4", "PD5", "PD6", "PD7",
> > +                                      "PD11", "PD12", "PD13", "PD14", "PD18",
> > +                                      "PD19", "PD21", "PD22", "PD23";
> > +                               function = "gmac";
> > +                               drive-strength = <40>;
> > +                       };
> > +
> 
> You should mention this change in your commit log.

And add a comment about why that drive strength is needed.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171108/98b3fb88/attachment.sig>
