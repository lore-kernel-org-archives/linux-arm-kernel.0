From: horms@verge.net.au (Simon Horman)
Date: Wed, 26 Apr 2017 09:58:43 +0200
Subject: [PATCH/RFT v2] ARM: dts: silk: Enable UHS-I SDR-50
In-Reply-To: <20170419072709.5kerc7y4437to2d3@ninjato>
References: <1492500887-20084-1-git-send-email-horms+renesas@verge.net.au>
 <20170419072709.5kerc7y4437to2d3@ninjato>
Message-ID: <20170426075842.GJ25517@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 19, 2017 at 09:27:09AM +0200, Wolfram Sang wrote:
> On Tue, Apr 18, 2017 at 04:34:47PM +0900, Simon Horman wrote:
> > Add the "1v8" pinctrl state and sd-uhs-sdr50 property to SDHI1.
> > 
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > ---
> > * Compile tested only; no access to silk board
> > ---
> >  arch/arm/boot/dts/r8a7794-silk.dts | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/r8a7794-silk.dts b/arch/arm/boot/dts/r8a7794-silk.dts
> > index 4cb5278d104d..bb0c41c2f3ac 100644
> > --- a/arch/arm/boot/dts/r8a7794-silk.dts
> > +++ b/arch/arm/boot/dts/r8a7794-silk.dts
> > @@ -196,6 +196,13 @@
> >  	sdhi1_pins: sd1 {
> >  		groups = "sdhi1_data4", "sdhi1_ctrl";
> >  		function = "sdhi1";
> > +		power-source = <3300>;
> > +	};
> > +
> > +	sdhi1_pins_uhs: sd1_uhs {
> > +		groups = "sdhi1_data4", "sdhi1_ctrl";
> > +		function = "sdhi1";
> > +		power-source = <1800>;
> >  	};
> >  
> >  	qspi_pins: qspi {
> > @@ -343,6 +350,7 @@
> 
> No "pinctrl-1" for the uhs state?

My bad, I will send v3.
