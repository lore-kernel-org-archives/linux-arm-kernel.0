From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 18 Sep 2012 15:20:08 +0000
Subject: [PATCH V6 2/2] dmaengine: add helper function to request a slave
 DMA channel
In-Reply-To: <20120918132113.GT27758@beef>
References: <1347662517-4210-1-git-send-email-jon-hunter@ti.com>
 <1347938035.1943.162.camel@vkoul-udesk3> <20120918132113.GT27758@beef>
Message-ID: <201209181520.08845.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 18 September 2012, Matt Porter wrote:
> On Tue, Sep 18, 2012 at 08:43:55AM +0530, Vinod Koul wrote:
> > 
> > Now would it make sense to NOT merge these changes for 3.7 and postpone
> > to 3.8. I can host these patches on a topic branch and merge them when
> > we are ready. I plan to spend some good amount of time on my work this
> > week so we should be ready pretty soon.
> > One these changes are merged, users can start moving to this scheme.
> 
> FWIW, I'm already basing the EDMA dmaengine support for OMAP (specifically
> for AM335x) on using these helpers since AM335x only boots from DT.

I suspect the same thing will be happening for a lot of platforms
after 3.7-rc1: ux500, lpc32xx, integrator, imx, mxs and probably
others are all waiting for this so they can complete the move
to DT-only booting.

Having some support for the new binding in 3.7 would be a great
help to reduce interdependencies for the 3.8 merge cycle. Both the
driver interface and the binding should actually be in a good
shape now, so I'd very much appriciate it getting merged for 3.7,
even if the implementation may have to change again in 3.8.

	Arnd
