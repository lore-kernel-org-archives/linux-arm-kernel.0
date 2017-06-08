From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 8 Jun 2017 14:48:41 +0200
Subject: [PATCH v2 2/2] ARM: sun8i: a83t: add dwmac-sun8i ethernet driver
In-Reply-To: <20170608084222.GA10830@Red>
References: <20170607173345.22462-1-clabbe.montjoie@gmail.com>
 <20170607173345.22462-3-clabbe.montjoie@gmail.com>
 <20170608083428.csv54tryvgwdb552@flea.home>
 <20170608084222.GA10830@Red>
Message-ID: <20170608124841.b6i5qphsyubksbvb@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 08, 2017 at 10:42:22AM +0200, Corentin Labbe wrote:
> On Thu, Jun 08, 2017 at 10:34:28AM +0200, Maxime Ripard wrote:
> > On Wed, Jun 07, 2017 at 07:33:45PM +0200, Corentin Labbe wrote:
> > > The dwmac-sun8i is an ethernet MAC hardware that support 10/100/1000 speed.
> > > This patch enable the dwmac-sun8i on the Allwinner a83t SoC Device-tree.
> > > 
> > > Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> > > Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> > > ---
> > >  arch/arm/boot/dts/sun8i-a83t.dtsi | 28 ++++++++++++++++++++++++++++
> > >  1 file changed, 28 insertions(+)
> > > 
> > > diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
> > > index 01a83406f9ae..7d719b4aeaa9 100644
> > > --- a/arch/arm/boot/dts/sun8i-a83t.dtsi
> > > +++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
> > > @@ -200,6 +200,14 @@
> > >  			#interrupt-cells = <3>;
> > >  			#gpio-cells = <3>;
> > >  
> > > +			emac_rgmii_pins: emac-rgmii-pins {
> > > +				pins = "PD2", "PD3", "PD4", "PD5", "PD6", "PD7",
> > > +				       "PD11", "PD12", "PD13", "PD14", "PD18",
> > > +				       "PD19", "PD21", "PD22", "PD23";
> > > +				function = "gmac";
> > > +				drive-strength = <40>;
> > > +			};
> > > +
> > 
> > This is not used anywhere.
> > 
> But will be used by bpim3 board

Then will add it when we'll add support for that board, until then,
it's dead code.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170608/e6027579/attachment-0001.sig>
