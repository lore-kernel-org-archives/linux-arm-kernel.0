From: icenowy@aosc.io (Icenowy Zheng)
Date: Sat, 20 Jan 2018 07:17:30 +0800
Subject: [RFC PATCH 4/9] clocksource: sun4i: add a compatible for suniv
In-Reply-To: <20180119231735.61504-1-icenowy@aosc.io>
References: <20180119231735.61504-1-icenowy@aosc.io>
Message-ID: <20180119231735.61504-5-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The suniv (new F-series) chip has a timer with less functionality than
the A10 timer, e.g. it has only 3 channels.

Add a new compatible for it. As we didn't use the extra channels on A10
either now, the code needn't to be changed.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/clocksource/sun4i_timer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clocksource/sun4i_timer.c b/drivers/clocksource/sun4i_timer.c
index 6e0180aaf784..88e09554ce7a 100644
--- a/drivers/clocksource/sun4i_timer.c
+++ b/drivers/clocksource/sun4i_timer.c
@@ -218,3 +218,5 @@ static int __init sun4i_timer_init(struct device_node *node)
 }
 TIMER_OF_DECLARE(sun4i, "allwinner,sun4i-a10-timer",
 		       sun4i_timer_init);
+TIMER_OF_DECLARE(suniv, "allwinner,suniv-timer",
+		       sun4i_timer_init);
-- 
2.14.2
