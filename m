From: tony@atomide.com (Tony Lindgren)
Date: Fri, 16 Dec 2011 17:39:39 -0800
Subject: [PATCH v4 4/4] OMAP3/4: iommu: adapt to runtime pm
In-Reply-To: <1323922709-6986-5-git-send-email-omar.ramirez@ti.com>
References: <1323922709-6986-1-git-send-email-omar.ramirez@ti.com>
 <1323922709-6986-5-git-send-email-omar.ramirez@ti.com>
Message-ID: <20111217013939.GG6464@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Omar Ramirez Luna <omar.ramirez@ti.com> [111214 19:47]:
> Use runtime PM functionality interfaced with hwmod enable/idle
> functions, to replace direct clock operations, reset and sysconfig
> handling.
> 
> Removed clk handling during interrupt, given that in order to receive one,
> the device should be powered on in advance. Now doing pm_runtime_get/put
> on iommu_enable/disable so it doesn't rely on others to keep the clocks on.
> 
> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>

The omap parts look OK to me for Ohad to queue:

Acked-by: Tony Lindgren <tony@atomide.com>
