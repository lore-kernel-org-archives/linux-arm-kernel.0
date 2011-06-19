From: shawn.guo@freescale.com (Shawn Guo)
Date: Sun, 19 Jun 2011 15:40:11 +0800
Subject: [PATCH 1/3] serial/imx: add device tree support
In-Reply-To: <201106181821.46574.arnd@arndb.de>
References: <1308410354-21387-1-git-send-email-shawn.guo@linaro.org>
	<1308410354-21387-2-git-send-email-shawn.guo@linaro.org>
	<201106181821.46574.arnd@arndb.de>
Message-ID: <20110619074010.GB23171@S2100-06.ap.freescale.net>
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
I would ignore it for a while until we have common clock api and
corresponding binding settled.  For now, I would have nothing clock
related parsed from device tree.

-- 
Regards,
Shawn
