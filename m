From: robh@kernel.org (Rob Herring)
Date: Wed, 7 Jun 2017 17:36:25 -0500
Subject: [PATCH 19/19] ARM: sun6i: a31s: Enable HDMI display output on
 the MSI Primo81 tablet
In-Reply-To: <20170602194219.hiajr7dt2oikm52q@flea.lan>
References: <20170602101024.18940-1-wens@csie.org>
 <20170602101024.18940-20-wens@csie.org>
 <20170602194219.hiajr7dt2oikm52q@flea.lan>
Message-ID: <20170607223625.aofk3cba3w4cvlys@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 02, 2017 at 09:42:19PM +0200, Maxime Ripard wrote:
> On Fri, Jun 02, 2017 at 06:10:24PM +0800, Chen-Yu Tsai wrote:
> > The MSI Primo81 tablet has a micro HDMI connector at the bottom.
> > This is connected to the SoCs HDMI output.
> > 
> > Enable the display pipeline and the HDMI output.
> > 
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > ---
> >  arch/arm/boot/dts/sun6i-a31s-primo81.dts | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/sun6i-a31s-primo81.dts b/arch/arm/boot/dts/sun6i-a31s-primo81.dts
> > index f3712753fa42..26154b2f87a3 100644
> > --- a/arch/arm/boot/dts/sun6i-a31s-primo81.dts
> > +++ b/arch/arm/boot/dts/sun6i-a31s-primo81.dts
> > @@ -52,17 +52,42 @@
> >  / {
> >  	model = "MSI Primo81 tablet";
> >  	compatible = "msi,primo81", "allwinner,sun6i-a31s";
> > +
> > +	hdmi-connector {
> > +		compatible = "hdmi-connector";
> > +		type = "c";
> 
> Should we add a connector type for this one?

c as in USB Type C? I'd prefer to see a new compatible string. Is type 
even documented?

Rob
