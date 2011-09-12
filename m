From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 12 Sep 2011 22:28:27 +0200
Subject: [PATCH 3/6] arm/imx6q: add core drivers clock, gpc, mmdc and src
In-Reply-To: <20110912194032.GB23345@ponder.secretlab.ca>
References: <1315303120-24203-1-git-send-email-shawn.guo@linaro.org>
	<20110912161201.GN1258@S2100-06.ap.freescale.net>
	<20110912194032.GB23345@ponder.secretlab.ca>
Message-ID: <1703861.Hm5X9zr4LP@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 12 September 2011 13:40:33 Grant Likely wrote:
> On Tue, Sep 13, 2011 at 12:12:02AM +0800, Shawn Guo wrote:
> > On Wed, Sep 07, 2011 at 09:56:21AM +0200, Arnd Bergmann wrote:
> > > On Wednesday 07 September 2011 14:05:03 Shawn Guo wrote:
> > > > > My feeling is that this time, we should wait for the common clock
> > > > > framework to get in and simplify this. I believe Thomas is now planning
> > > > > to do this, but I haven't followed what the current state is.
> > > > > 
> > > > Sadly, if this is the position of entire arm-soc maintainer group,
> > > > I think I have made a wrong decision to start upstreaming imx6q now.
> > > 
> > > We haven't discussed it as a group, it's my own opinion.
> > > 
> > 
> > Hi Thomas, Grant,
> > 
> > Could you please share your opinion here?
> > 
> > I really do not see the hope that clock framework and device tree
> > binding could possibly catch v3.2 window, while I'm hoping that imx6q
> > series can go into v3.2.
> > 
> > Can you please agree that we can let the imx6q clock code in and then
> > migrate it to clock framework and device tree once they get ready?
> 
> I've not looked very deeply at this patch, but I completely agree that
> we cannot block new platforms on infrastructure that isn't remotely
> mergable at this point in time.
> 
> However, imx6 is a new platform.  There isn't any non-DT board support
> code to continue to support.  At the very least, the configurable
> parameters, like what is passed into mx6q_clocks_init() should be
> obtained from the device tree (maybe it already does this though, I
> haven't looked that closely).
> 
> In general, I say merge it.

Ok, thanks for taking a look. Do you believe that the clock binding is any
closer to being finalized than the actual code implementing it? I think
it would be very helpful to at least put all the clock related settings
into the device tree in a way that is going to be stable, even if the
code is still in flux.

Moreover, if we have a binding document, we can start implementing code
for one platform and then generalize it later.

	Arnd
