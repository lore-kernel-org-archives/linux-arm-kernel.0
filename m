From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 7 Jul 2011 12:28:38 -0600
Subject: [RFC PATCH 5/5] OMAP: I2C: Convert I2C driver to use device tree
In-Reply-To: <20110707171349.GC3124@manju-desktop>
References: <1309426647-31587-1-git-send-email-manjugk@ti.com>
	<1309426647-31587-6-git-send-email-manjugk@ti.com>
	<20110706190803.GN4871@ponder.secretlab.ca>
	<20110707171349.GC3124@manju-desktop>
Message-ID: <20110707182838.GC2824@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 07, 2011 at 10:43:49PM +0530, G, Manjunath Kondaiah wrote:
> On Wed, Jul 06, 2011 at 01:08:03PM -0600, Grant Likely wrote:
> > On Thu, Jun 30, 2011 at 03:07:27PM +0500, G, Manjunath Kondaiah wrote:
> > > 
> > > The OMAP I2C driver is modified to use platform_device data from
> > > device tree data structures.
> > > 
> > > Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
> > 
> > Mostly looks good, but a few things that need to be fixed.  You can
> > probably even get this change merged for v3.1
> 
> Thanks. I will fix the review comments and we can have these changes with
> board-omapx-dt.c file so that dt and not dt builds can co exist.
> 
> For complete functionality with dt build, omap hwmod needs to be handled
> through DT framework. I am waiting for comments from omap hwmod maintainers.

You should be able to sidestep this issue in the short term.  As long
as you can get the of_platform_populate() function to create
omap_devices that look identical to the current statically allocated
omap_devices.  If you need to extend the auxdata structure to do so,
then I'm okay with that.  You could add special handling for devices
compatible with "ti,omap3-device" or "ti,omap4-device".

I'm keen to see this done, and if you can put it together quickly,
then I think I still have time to queue it up for v3.1 (especially
since it would be a new block of code that should not break any
existing boards).

g.
