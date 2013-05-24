From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Fri, 24 May 2013 14:35:42 +0200 (CEST)
Subject: LVDS (LDB) driver for i.MX53 IPU
In-Reply-To: <20130310223241.GQ1906@pengutronix.de>
References: <5134DF0E.7010402@parkeon.com>
 <20130310223241.GQ1906@pengutronix.de>
Message-ID: <Pine.LNX.4.64.1305241431460.2226@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha

On Sun, 10 Mar 2013, Sascha Hauer wrote:

> Hi Martin,
> 
> On Mon, Mar 04, 2013 at 06:51:10PM +0100, Martin Fuzzey wrote:
> > Hi Sascha,
> > 
> > I need to add LVDS support to your staging imx/drm driver.
> > 
> > First of all are there any patches floating around to do that? (a
> > search of the mailing list didn't turn up any).
> > 
> > From a hardware point of view it looks quite simple (just one
> > register to configure) but unfortunately that register is in the
> > IOMUXC region.
> > 
> > That means that if I write a new platform driver similar to
> > drivers/staging/imx-drm/parallel-display.c (with a new DT node
> > pointing to the reg) the request_resource() will fail since it will
> > already be claimed by the iomuxc driver.
> > 
> > The only solutions I can think of are:
> > 1) Add exported function to the iomuxc driver to get the register
> > or
> > 2) Directly ioremap() the address
> > 
> > Both of these sound horrible.
> > 
> > Do you have any suggestions?
> > 
> > I guess the generic question I'm asking is how to handle the case
> > where unrelated drivers require access to the same memory regions?
> 
> We have a driver for the ldb. Indeed the driver itself is trivial, but
> the integration is tricky. For accessing the register the syscon binding
> can be used. The clock is also a problem, also the mux to the IPU(s)
> 
> I'll talk with Philipp tomorrow and I think we can send you the current
> state then.

How's it looking in the meantime? Any plans to mainline it? Or would you 
be prepared to publish what you've got to try and see whether others can 
help you with this?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
