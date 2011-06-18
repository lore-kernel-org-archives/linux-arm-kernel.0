From: grant.likely@secretlab.ca (Grant Likely)
Date: Sat, 18 Jun 2011 10:26:55 -0600
Subject: [PATCH 1/3] serial/imx: add device tree support
In-Reply-To: <201106181821.46574.arnd@arndb.de>
References: <1308410354-21387-1-git-send-email-shawn.guo@linaro.org>
	<1308410354-21387-2-git-send-email-shawn.guo@linaro.org>
	<201106181821.46574.arnd@arndb.de>
Message-ID: <20110618162655.GK8195@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 18, 2011 at 06:21:46PM +0200, Arnd Bergmann wrote:
> On Saturday 18 June 2011 17:19:12 Shawn Guo wrote:
> >
> > +Required properties:
> > +- compatible : should be "fsl,<soc>-uart", "fsl,imx-uart"
> > +- reg : address and length of the register set for the device
> > +- interrupts : should contain uart interrupt
> > +- id : should be the port ID defined by soc
> > +
> > +Optional properties:
> > +- fsl,has-rts-cts : indicate it has rts-cts
> > +- fsl,irda-mode : support irda mode
> > +
> > +Example:
> > +
> > +uart at 73fbc000 {
> > +	compatible = "fsl,imx51-uart", "fsl,imx-uart";
> > +	reg = <0x73fbc000 0x4000>;
> > +	interrupts = <31>;
> > +	id = <1>;
> > +	fsl,has-rts-cts;
> > +};
> 
> Should this also support the "clock-frequency" property that 8250-style
> serial ports support [1]?
> 
> For the flow-control properties, should we name that more generic? The
> same property certainly makes sense for other serial-ports if it does
> here. OTOH, I'm not sure it's actually reliable, because it also depends
> on whether the other side of the connection and the cable support hw flow
> control.

I'd like to see a few use cases before defining a common property.
That said, has-rts-cts does sound like a useful generic property.
Or maybe named "uart-has-rts-cts" to make it clear that it is a uart
specific binding?

g.

> 
> 
> 	Arnd
> 
> [1] http://playground.sun.com/1275/bindings/devices/html/serial-1_0d.html#HDR9
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
