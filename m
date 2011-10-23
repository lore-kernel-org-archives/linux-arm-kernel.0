From: shawn.guo@freescale.com (Shawn Guo)
Date: Sun, 23 Oct 2011 22:24:59 +0800
Subject: [PATCH v2 2/7] clk: Implement clk_set_rate
In-Reply-To: <1316730422-20027-3-git-send-email-mturquette@ti.com>
References: <1316730422-20027-1-git-send-email-mturquette@ti.com>
	<1316730422-20027-3-git-send-email-mturquette@ti.com>
Message-ID: <20111023142458.GE1401@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 22, 2011 at 03:26:57PM -0700, Mike Turquette wrote:
> From: Jeremy Kerr <jeremy.kerr@canonical.com>
> 
> Implement clk_set_rate by adding a set_rate callback to clk_hw_ops.
> Rates are propagated down the clock tree and recalculated.  Also adds a
> flag for signaling that parents must change rates to achieve the desired
> frequency (upstream propagation).
> 
> TODO:
> Upstream propagation is not yet implemented.
> Device pre-change and post-change notifications are not implemented, but
> are marked up as FIXME comments.
> 
> Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Signed-off-by: Mike Turquette <mturquette@ti.com>
> ---
> Changes since v1:
> Remove upstream propagation (for now)
> Rename CLK_SET_RATE_PROPAGATE to CLK_PARENT_RATE_CHANGE

[...]

> + * @set_rate	Change the rate of this clock. If this callback returns
> + *		CLK_SET_RATE_PROPAGATE, the rate change will be propagated to

s/CLK_SET_RATE_PROPAGATE/CLK_PARENT_RATE_CHANGE, as suggested by your
change log above?

> + *		the parent clock (which may propagate again). The requested
> + *		rate of the parent is passed back from the callback in the
> + *		second 'unsigned long *' argument.
> + *

-- 
Regards,
Shawn
