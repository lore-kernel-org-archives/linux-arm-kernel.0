From: tony@atomide.com (Tony Lindgren)
Date: Fri, 29 Apr 2016 08:34:30 -0700
Subject: [PATCH v3 1/7] ARM: OMAP3: hwmod data: Fix McBSP2/3 sidetone data
In-Reply-To: <1461927202-17677-2-git-send-email-peter.ujfalusi@ti.com>
References: <1461927202-17677-1-git-send-email-peter.ujfalusi@ti.com>
 <1461927202-17677-2-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20160429153430.GK5995@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [160429 03:55]:
> The McBSPLP's sidetone main clock is the McBSPLP's ICLK, not FCLK as the
> sidetone only receives the ICLK from the main McBSP module.
> Since the McBSP and sidetone is using the very same clock from PRCM level
> the sidetone must not have the prcm section to check the clock status since
> the sidetone is only used when McBSP is already configured.
> If two separate hwmods looking at the same bit and they would use
> pm_runtime in nested way (as it must happen with McBSP and it's ST module)
> the hwmod would warn, because the idlest will not match what it is expected
> after enable/disable of the clocks.

Thanks for looking into it, this looks right to me.

Tony
