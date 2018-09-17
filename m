From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 17 Sep 2018 16:54:52 +0200
Subject: [PATCH 5/5] ARM: sun8i: dts: drop A64 HDMI PHY fallback
 compatible from R40 DT
In-Reply-To: <1926288.mXGsSvSKgU@jernej-laptop>
References: <20180907072234.48282-1-icenowy@aosc.io>
 <20180907072234.48282-6-icenowy@aosc.io>
 <20180910142354.5ldexkvnan6ohz4x@flea>
 <1926288.mXGsSvSKgU@jernej-laptop>
Message-ID: <20180917145452.ewfuqkrxjjosbawd@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 10, 2018 at 04:32:30PM +0200, Jernej ?krabec wrote:
> Dne ponedeljek, 10. september 2018 ob 16:23:54 CEST je Maxime Ripard 
> napisal(a):
> > On Fri, Sep 07, 2018 at 03:22:34PM +0800, Icenowy Zheng wrote:
> > > The R40 HDMI PHY seems to be different to the A64 one, the A64 one
> > > has no input mux, but the R40 one has.
> > > 
> > > Drop the A64 fallback compatible from the HDMI PHY node in R40 DT.
> > > 
> > > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > > ---
> > > 
> > >  arch/arm/boot/dts/sun8i-r40.dtsi | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > 
> > > diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi
> > > b/arch/arm/boot/dts/sun8i-r40.dtsi index ffd9f00f74a4..5f547c161baf
> > > 100644
> > > --- a/arch/arm/boot/dts/sun8i-r40.dtsi
> > > +++ b/arch/arm/boot/dts/sun8i-r40.dtsi
> > > @@ -800,8 +800,7 @@
> > > 
> > >  		};
> > >  		
> > >  		hdmi_phy: hdmi-phy at 1ef0000 {
> > > 
> > > -			compatible = "allwinner,sun8i-r40-hdmi-phy",
> > > -				     "allwinner,sun50i-a64-hdmi-phy";
> > > +			compatible = "allwinner,sun8i-r40-hdmi-phy";
> > 
> > If you could use the A64 phy before, you can still use it now.
> 
> Not exactly. Given that we don't know how to switch between HDMI PHY clock 
> parents on A64 (if it is actually connected at all, there is no information 
> about that in manual and AW didn't answered our questions, despite asking them 
> through different channels), A64 compatible will be associated with quirk, 
> which will tell that only one clock parent is usable.
> 
> However, R40 HDMI PHY has definetly two clock parents, as it was tested by me 
> and Icenowy and we know how to switch between them without issues. 
> Technically, we could have A64 compatible there, but that would mean only 
> single PHY parent is considered instead of two.

The DT change above would mean that you can't operate the R40 phy in
the same way than the A64's. From what you're telling me now, this
isn't exactly what is going on: you can operate the R40 phy just like
the A64: with a single PLL instead of two. You operate in a degraded
and non-optimal mode, but it still works.

And it's exactly what the DT is already saying.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180917/f6fa302a/attachment.sig>
