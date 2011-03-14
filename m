From: tony@atomide.com (Tony Lindgren)
Date: Mon, 14 Mar 2011 11:12:30 -0700
Subject: [PATCH] arm: plat-omap: iommu: fix request_mem_region() error path
In-Reply-To: <20110314.145029.848855634033118142.Hiroshi.DOYU@nokia.com>
References: <1300105712-12656-1-git-send-email-aaro.koskinen@nokia.com>
	<20110314.145029.848855634033118142.Hiroshi.DOYU@nokia.com>
Message-ID: <20110314181230.GE7258@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Hiroshi DOYU <Hiroshi.DOYU@nokia.com> [110314 05:50]:
> Hi Aaro,
> 
> From: Aaro Koskinen <aaro.koskinen@nokia.com>
> Subject: [PATCH] arm: plat-omap: iommu: fix request_mem_region() error path
> Date: Mon, 14 Mar 2011 14:28:32 +0200
> 
> > request_mem_region() error exit will leak ioremapped memory. Fix this
> > by moving the ioremap() after request_mem_region(), which is the proper
> > order to do this anyway.
> > 
> > Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
> > ---
> >  arch/arm/plat-omap/iommu.c |   14 ++++++++------
> >  1 files changed, 8 insertions(+), 6 deletions(-)
> 
> True. Thank you for catching this.

Applying.

Tony
