From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 13 May 2015 10:52:33 +0200
Subject: [PATCH 05/15] thermal: Add comment explaining test for critical
 temperature
In-Reply-To: <1431507163-19933-1-git-send-email-s.hauer@pengutronix.de>
References: <1431507163-19933-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1431507163-19933-6-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The code testing if a temperature should be emulated or not is
not obvious. Add a comment explaining why this test is done.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/thermal/thermal_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 3e0fe55..e204deb 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -435,6 +435,11 @@ int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
 			}
 		}
 
+		/*
+		 * Only allow emulating a temperature when the real temperature
+		 * is below the critical temperature so that the emulation code
+		 * cannot hide critical conditions.
+		 */
 		if (!ret && *temp < crit_temp)
 			*temp = tz->emul_temperature;
 	}
-- 
2.1.4
