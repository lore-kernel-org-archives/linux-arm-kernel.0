From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Thu, 6 Jul 2017 21:05:41 +0200
Subject: [PATCH] ARM: sunxi: h3/h5: Correct emac register size
In-Reply-To: <20170706185205.f4jwskpnz4d3udvv@flea>
References: <20170706085334.25380-1-clabbe.montjoie@gmail.com>
 <20170706185205.f4jwskpnz4d3udvv@flea>
Message-ID: <20170706190541.GA28678@Red>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 06, 2017 at 08:52:05PM +0200, Maxime Ripard wrote:
> On Thu, Jul 06, 2017 at 10:53:34AM +0200, Corentin Labbe wrote:
> > The datasheet said that emac register size is 0x1000 not 0x104
> > 
> > Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> > ---
> >  arch/arm/boot/dts/sunxi-h3-h5.dtsi | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> > index 716e7d668dec..5a57b67c9b77 100644
> > --- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> > +++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> > @@ -406,7 +406,7 @@
> >  		emac: ethernet at 1c30000 {
> >  			compatible = "allwinner,sun8i-h3-emac";
> >  			syscon = <&syscon>;
> > -			reg = <0x01c30000 0x104>;
> > +			reg = <0x01c30000 0x1000>;
> 
> The size is actually 0x10000. I fixed it and applied.
> 
> The A64 DTSI has the same issue, can you send a patch for this one
> too?
> 

Yes
Thanks for the fixing
Regards
Corentin Labbe
