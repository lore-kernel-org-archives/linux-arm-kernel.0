From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 17 Nov 2014 14:04:00 +0530
Subject: [PATCH 1/7] dmaengine: at_xdmac: prefer usage of
 readl/writel_relaxed
In-Reply-To: <20141113154551.GV3639@ldesroches-Latitude-E6320>
References: <1415875965-6905-1-git-send-email-ludovic.desroches@atmel.com>
 <1415875965-6905-2-git-send-email-ludovic.desroches@atmel.com>
 <2791155.z0l2TZezWO@wuerfel> <20141113153449.GO24582@intel.com>
 <20141113154551.GV3639@ldesroches-Latitude-E6320>
Message-ID: <20141117083400.GS24582@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 13, 2014 at 04:45:51PM +0100, Ludovic Desroches wrote:
> On Thu, Nov 13, 2014 at 09:04:49PM +0530, Vinod Koul wrote:
> > On Thu, Nov 13, 2014 at 12:01:49PM +0100, Arnd Bergmann wrote:
> > > On Thursday 13 November 2014 11:52:39 Ludovic Desroches wrote:
> > > > _relaxed version of readl and writel are not implemented on all
> > > > architecture so COMPILE_TEST has to be removed in order to not cause
> > > > some build failures.
> > > > 
> > > > Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> > > > ---
> > > > 
> > > 
> > > I've queued up Will Deacon's series to enable the relaxed accessors
> > > on all architectures, so the Kconfig change should no longer
> > > be required in 3.19.
> > And why is _relaxed() version required for thsi driver. Why cant readl(),
> > writel() with barriers do?
> 
> Required not but preferred to my mind. I don't need a barrier for all
> read and write I am performing. Barriers have been added when needed.
> 
> When you have fixed my code because of the compilation breakage on other
> architecture, you only change the read and write macros. Currently, there are
> some redundancies because of the barriers added in the code.
> 
> To be honest, I have no idea about the performance impact between the
> use of read/write and read/write_relaxed. Then two choices:
> - go back to relaxed version, good new can keep COMPILE_TEST thanks to
>   Will Deacon
But that would merged after merge window. This was also reported on next.
So lets keep this patch for now and you can enabled COMPILE_TEST after next
merge window.
> - remove barrier since they are no more needed if using readl/writel
I think that should be right fix along with checking performance of driver and
optimize/stress it

So for now, I am applying this whole series.

-- 
~Vinod
