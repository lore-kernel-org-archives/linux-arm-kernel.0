From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 20 Dec 2011 11:03:48 +0800
Subject: [PATCH v3 1/3] mfd: mc13xxx: add device tree probe support
In-Reply-To: <20111220015931.GX2860@opensource.wolfsonmicro.com>
References: <1323702958-4831-1-git-send-email-shawn.guo@linaro.org>
 <1323702958-4831-2-git-send-email-shawn.guo@linaro.org>
 <20111220005708.GM2860@opensource.wolfsonmicro.com>
 <20111220020101.GD5683@S2100-06.ap.freescale.net>
 <20111220015931.GX2860@opensource.wolfsonmicro.com>
Message-ID: <20111220030347.GB2995@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 20, 2011 at 01:59:32AM +0000, Mark Brown wrote:
> On Tue, Dec 20, 2011 at 10:01:02AM +0800, Shawn Guo wrote:
> > On Tue, Dec 20, 2011 at 12:57:09AM +0000, Mark Brown wrote:
> > > On Mon, Dec 12, 2011 at 11:15:56PM +0800, Shawn Guo wrote:
> 
> > > > +Sub-nodes:
> > > > +- regulators : Contain the regulator nodes.  The name of regulator node
> > > > +  is being used by mc13xxx regulator driver to find the correct relator
> > > > +  device.
> 
> > > Reading this I'm not clear what the name of the node is, or what the
> > > valid node names are.
> 
> > In the example below, the name would be 'mc13892__sw1'.
> 
> You're missing the point - someone reading the documentation needs to be
> able to figure out what strings they need to use for all the different
> regulators on the chip are without groveling through the driver code.
> 
> > > > +			sw1_reg: mc13892__sw1 {
> 
> > > The examples don't really elucidate this either (and the __ is rather
> > > odd).
> 
> > Yes, that's because the name defined by mc13892 regulator driver is odd.
> 
> That's *not* something that we should be exposing in the device tree
> bindings.  This is an implementation detail of the Linux driver which
> might well change in future.
> 
Any suggestion on a better binding for mc13892 regulator device?

-- 
Regards,
Shawn
