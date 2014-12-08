From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 8 Dec 2014 19:00:47 +0530
Subject: [PATCH v5 00/61] dmaengine: Implement generic slave capabilities
 retrieval
In-Reply-To: <20141208093246.GB27228@ldesroches-Latitude-E6320>
References: <1416231775-31252-1-git-send-email-maxime.ripard@free-electrons.com>
 <20141208061746.GD16827@intel.com>
 <20141208093246.GB27228@ldesroches-Latitude-E6320>
Message-ID: <20141208133047.GM16827@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 08, 2014 at 10:32:47AM +0100, Ludovic Desroches wrote:
> On Mon, Dec 08, 2014 at 11:47:46AM +0530, Vinod Koul wrote:
> > On Mon, Nov 17, 2014 at 02:41:54PM +0100, Maxime Ripard wrote:
> > > Hi,
> > > 
> > > As we discussed a couple of weeks ago, this is the third attempt at
> > > creating a generic behaviour for slave capabilities retrieval so that
> > > generic layers using dmaengine can actually rely on that.
> > > 
> > > That has been done mostly through two steps: by moving out the
> > > sub-commands of the device_control callback, so that the dmaengine
> > > core can then infer from that wether a sub-command is implemented, and
> > > then by moving the slave properties, such as the supported buswidth,
> > > to the structure dma_device itself.
> > 
> > Okay managed to get this done. Apart from the two issues identified didn't
> > find anything so applied and pushed to a branch
> > "topic/slave_caps_device_control_fix"
> > 
> > Today did some compile tests and found few warnings, were trivial but I
> > am worried about the testing of this code. Has anyone tested this, if so
> > which platforms are covered Since I pushed base branch last night, Feng's
> > bot covered it and all was OK. Looks like Feng's bot doesn't have wide
> > coverage of arm platforms, wasn't there one run by arm guys which tries to
> > test and boot, if so can we get this tested there please.
> 
> Tested with your branch on sama5d3 and sama5d4 so at_hdmac and at xdmac.
> 
> I have also sent some patches based on Maxime's series for at_xdmac.
Thank You!

Anymore voluteers? I am looking at omap, mxs, tegra ones (these had issues)

-- 
~Vinod
