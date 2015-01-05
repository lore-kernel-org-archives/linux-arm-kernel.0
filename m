From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 5 Jan 2015 20:45:46 +0800
Subject: [PATCH v2] ARM: i.MX53: dts: add sahara module
In-Reply-To: <20150105123726.GA24511@dragon>
References: <1418115412-20691-1-git-send-email-s.trumtrar@pengutronix.de>
 <20141216090442.GJ2411@dragon>
 <20141216092441.GD13070@pengutronix.de>
 <20150105123726.GA24511@dragon>
Message-ID: <20150105124542.GA14108@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 05, 2015 at 08:37:28PM +0800, Shawn Guo wrote:
> On Tue, Dec 16, 2014 at 10:24:41AM +0100, Steffen Trumtrar wrote:
> > On Tue, Dec 16, 2014 at 05:04:43PM +0800, Shawn Guo wrote:
> > > On Tue, Dec 09, 2014 at 09:56:52AM +0100, Steffen Trumtrar wrote:
> > > > The i.MX53 has a SAHARA v4 core. Add it to the dtsi.
> > > > 
> > > > Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> > > > ---
> > > > Changes since v1:
> > > > 	- remove status property
> > > > 
> > > >  arch/arm/boot/dts/imx53.dtsi | 9 +++++++++
> > > >  1 file changed, 9 insertions(+)
> > > > 
> > > > diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
> > > > index b96213ba0671..ff4fa7ecacd8 100644
> > > > --- a/arch/arm/boot/dts/imx53.dtsi
> > > > +++ b/arch/arm/boot/dts/imx53.dtsi
> > > > @@ -765,6 +765,15 @@
> > > >  				resets = <&src 1>;
> > > >  				iram = <&ocram>;
> > > >  			};
> > > > +
> > > > +			sahara: crypto at 63ff8000 {
> > > > +				compatible = "fsl,imx53-sahara";
> > > 
> > > Is there already a driver for it in the kernel?
> > > 
> > 
> > Herbert Xu queued the driver in his crypto tree.
> 
> Okay.  I have seen the driver change in 3.19-rc.  But the compatible
> string is still undocumented.

Ah, I see.  The compatible is written as "fsl,<soc>-sahara" in the
binding doc.

Patch applied, thanks.

Shawn
