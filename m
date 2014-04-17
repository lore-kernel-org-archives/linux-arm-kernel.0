From: joelf@ti.com (Joel Fernandes)
Date: Wed, 16 Apr 2014 19:03:13 -0500
Subject: [PATCH 3/9] ARM: OMAP: dmtimer: Add note to set parent from DT
In-Reply-To: <1397692999-7800-1-git-send-email-joelf@ti.com>
References: <1397692999-7800-1-git-send-email-joelf@ti.com>
Message-ID: <1397692999-7800-3-git-send-email-joelf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Once clock-parents or default-parent support for DT clocks is available,
we should use it to set clock parent and turn clk_set_parent into a NOOP.

Signed-off-by: Joel Fernandes <joelf@ti.com>
---
 arch/arm/plat-omap/dmtimer.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index f5a674c..4debb3d 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -165,6 +165,10 @@ static int omap_dm_timer_prepare(struct omap_dm_timer *timer)
 	__omap_dm_timer_enable_posted(timer);
 	omap_dm_timer_disable(timer);
 
+	/*
+	 * FIXME: Once DT clock-parents or set-parents support is upstream,
+	 * this is to become a NOOP.
+	 */
 	return omap_dm_timer_set_source(timer, OMAP_TIMER_SRC_32_KHZ);
 }
 
-- 
1.7.9.5
