From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 13 Sep 2013 16:38:08 +0800
Subject: [PATCH 1/2] ARM: dts: imx53-qsb: add TVE entry
In-Reply-To: <1379060710.4396.7.camel@pizza.hi.pengutronix.de>
References: <1378893068-22235-1-git-send-email-l.stach@pengutronix.de>
 <20130913065855.GA31147@S2101-09.ap.freescale.net>
 <1379060710.4396.7.camel@pizza.hi.pengutronix.de>
Message-ID: <20130913083806.GB31147@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 13, 2013 at 10:25:10AM +0200, Philipp Zabel wrote:
> > > @@ -297,6 +306,18 @@
> > >  	status = "okay";
> > >  };
> > >  
> > > +&tve {
> > > +	pinctrl-names = "default";
> > > +	pinctrl-0 = <&pinctrl_vga_sync_1>;
> > > +	ddc = <&i2c2>;
> > > +	fsl,tve-mode = "vga";
> > 
> > Are these custom properties documented anywhere?  I cannot find the
> > device tree bindings document for them.  Anyway, it should be another
> > patch to provide the document, if you like.
> 
> No, and I'd actually like to get rid of them, eventually.
> 
> If we can use the CDF/V4L2 entity model, the TVE will just be an encoder
> entity with an output pad connected to a VGA connector node (or FBAS, or
> S-Video, ...).
> The ddc i2c bus property should then be placed on the actual (VGA)
> connector node. Also the tve-mode could be inferred from the type of
> connector (and even changed at runtime if there's both an S-Video and a
> Composite connector, for example).
> 
> Maybe I should send a minimal patch without the two custom device tree
> properties for now?

Yeah, sounds good.

Shawn
