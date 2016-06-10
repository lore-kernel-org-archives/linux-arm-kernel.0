From: tony@atomide.com (Tony Lindgren)
Date: Fri, 10 Jun 2016 05:08:30 -0700
Subject: [PATCH v5 2/7] ARM: OMAP3: hwmod data: Fix McBSP2/3 sidetone data
In-Reply-To: <20160530082350.24285-3-peter.ujfalusi@ti.com>
References: <20160530082350.24285-1-peter.ujfalusi@ti.com>
 <20160530082350.24285-3-peter.ujfalusi@ti.com>
Message-ID: <20160610120830.GM22406@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [160530 01:26]:
> The McBSPLP's sidetone main clock is the McBSPLP's ICLK, not FCLK as the
> sidetone only receives the ICLK from the main McBSP module.
> Since the McBSP and sidetone is using the very same clock from PRCM level
> the sidetone must not have the prcm section to check the clock status since
> the sidetone is only used when McBSP is already configured.
> If two separate hwmods looking at the same bit and they would use
> pm_runtime in nested way (as it must happen with McBSP and it's ST module)
> the hwmod would warn, because the idlest will not match what it is expected
> after enable/disable of the clocks.

OK thanks for fixing this. I'm applying patches 2-7 into
omap-for-v4.8/soc.

Regards,

Tony
