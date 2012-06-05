From: tony@atomide.com (Tony Lindgren)
Date: Tue, 5 Jun 2012 00:59:52 -0700
Subject: [PATCH-V2 0/4] ARM: OMAP2+: am33xx: Add clocktree and hwmod data
In-Reply-To: <1338285402-11306-1-git-send-email-hvaibhav@ti.com>
References: <1338285402-11306-1-git-send-email-hvaibhav@ti.com>
Message-ID: <20120605075952.GJ12766@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Vaibhav Hiremath <hvaibhav@ti.com> [120529 03:01]:
> This patch adds complete clockctree and hwmod data for the
> AM33XX family of devices.
> 
> This patch-series is cleaned up further from Paul's cleanup
> activity on AM33xx clocktree, where all leaf nodes have been
> removed and now modules enable/disable is controlled only
> using hwmod framework interface.
> 
> There are certain modules, like clkdiv32k, debugss, etc..., for
> which we still doesn't have hwmod_data present, so in order to
> disable these modules during boot time, we still have to maintain
> clk node for them. Comment has been added to highlight this, and
> in the future we will cleanup this.
> As far as, CLKDIV32K module, in reality is not module but still
> we have MODULEMODE to control it, so we may have to keep this node
> alone in the clocktree.

Considering that we have the RFC patches available for common
clk fwk, we should probably avoid the extra churn and have this
use the common clk fwk instead. Of course that is assuming the
common clk fwk patches will be mergeable soonish.

Regards,

Tony
