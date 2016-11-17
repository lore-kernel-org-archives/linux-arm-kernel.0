From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 17 Nov 2016 15:22:52 +0530
Subject: [PATCH v10 01/11] remoteproc: st_slim_rproc: add a slimcore
 rproc driver
In-Reply-To: <20161117063646.GE28340@tuxbot>
References: <1476783556-2501-1-git-send-email-peter.griffin@linaro.org>
 <1476783556-2501-2-git-send-email-peter.griffin@linaro.org>
 <20161103213703.GA15449@tuxbot>
 <20161107135735.GA27280@griffinp-ThinkPad-X1-Carbon-2nd>
 <20161114051854.GW3000@localhost> <20161117063646.GE28340@tuxbot>
Message-ID: <20161117095252.GC2698@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 16, 2016 at 10:36:46PM -0800, Bjorn Andersson wrote:
> On Sun 13 Nov 21:18 PST 2016, Vinod Koul wrote:
> 
> > On Mon, Nov 07, 2016 at 01:57:35PM +0000, Peter Griffin wrote:
> > > > 
> > > > As you now make changes to the entire remoteproc Kconfig file, rather
> > > > than simply add a Kconfig symbol we can't bring this in via Vinod's tree
> > > > without providing Linus with a messy merge conflict.
> > > > 
> > > > So the remoteproc parts now has to go through my tree.
> > > 
> > > OK, I think the best approach is for Vinod to create an immutable
> > > branch with the entire fdma series on, and then both of you merge that branch into
> > > your respective trees.
> > 
> > my topic/st_fdma is immutable branch. You cna merge it, if you need a signed
> > tag, please do let me know
> > 
> 
> Hi Vinod,
> 
> It looks like you reverted the wrong Kconfig fix, the one I objected to
> was the change in drivers/remoteproc, not the one in drivers/dma.
> 
> The ST_FMDA depends on functions exposed by REMOTEPROC and
> ST_SLIM_REMOTEPROC, the latter in turn depends on REMOTEPROC, which you
> guys made user selectable - and as such should not be selected - but I
> think we should move forward and get everything merged and then we can
> go back and figure out how this should be addressed (or left alone?).
> 
> I have merged "topic/st_fdma" into rproc-next, so that I can fix up the
> now broken drivers/remoteproc/Kconfig.
> 
> We do however both need to revert the revert or there will be link
> errors if you build the dma driver with remoteproc=n. If you do this I
> can merge the topic once more and we'll keep the set of changes in sync.

Oops my bad, thanks for letting me know. I have reverted this now and
pushing out. Please do let me know if this was fine

Thanks
-- 
~Vinod
