From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 13 Nov 2014 21:04:49 +0530
Subject: [PATCH 1/7] dmaengine: at_xdmac: prefer usage of
 readl/writel_relaxed
In-Reply-To: <2791155.z0l2TZezWO@wuerfel>
References: <1415875965-6905-1-git-send-email-ludovic.desroches@atmel.com>
 <1415875965-6905-2-git-send-email-ludovic.desroches@atmel.com>
 <2791155.z0l2TZezWO@wuerfel>
Message-ID: <20141113153449.GO24582@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 13, 2014 at 12:01:49PM +0100, Arnd Bergmann wrote:
> On Thursday 13 November 2014 11:52:39 Ludovic Desroches wrote:
> > _relaxed version of readl and writel are not implemented on all
> > architecture so COMPILE_TEST has to be removed in order to not cause
> > some build failures.
> > 
> > Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> > ---
> > 
> 
> I've queued up Will Deacon's series to enable the relaxed accessors
> on all architectures, so the Kconfig change should no longer
> be required in 3.19.
And why is _relaxed() version required for thsi driver. Why cant readl(),
writel() with barriers do?

-- 
~Vinod
