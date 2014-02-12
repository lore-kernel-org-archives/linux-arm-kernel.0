From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 12 Feb 2014 19:15:51 +0800
Subject: [RFC PATCH 4/4] ARM: dts: imx6qdl: Add PU power-domain
 information to gpc node
In-Reply-To: <1392200455.5536.36.camel@pizza.hi.pengutronix.de>
References: <1392125231-28387-1-git-send-email-p.zabel@pengutronix.de>
 <1392125231-28387-5-git-send-email-p.zabel@pengutronix.de>
 <20140212072510.GI31484@S2101-09.ap.freescale.net>
 <1392200455.5536.36.camel@pizza.hi.pengutronix.de>
Message-ID: <20140212111549.GC24834@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 12, 2014 at 11:20:55AM +0100, Philipp Zabel wrote:
> > > @@ -598,9 +598,17 @@
> > >  			};
> > >  
> > >  			gpc: gpc at 020dc000 {
> > > +				#address-cells = <1>;
> > > +				#size-cells = <1>;
> > >  				compatible = "fsl,imx6q-gpc";
> > >  				reg = <0x020dc000 0x4000>;
> > >  				interrupts = <0 89 0x04 0 90 0x04>;
> > > +				pu-supply = <&reg_pu>;
> > > +
> > > +				pd_pu: power-domain at 020dc260 {
> > > +					compatible = "fsl,power-domain";
> > > +					reg = <0x020dc260 0x10>;
> > > +				};
> > 
> > It's time to have a binding doc for gpc/pgc?
> 
> Yes, I'll add one for the next version.
> 
> > And I'm not sure
> > "fsl,power-domain" is a good compatible as it's so generic.
> 
> fsl,imx6q-power-domain ?

It looks good to me.

Shawn
