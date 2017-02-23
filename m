From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 23 Feb 2017 17:14:45 +0100
Subject: [PATCH] wireless/atmel: remove time_t usage
Message-ID: <20170223161445.19200-1-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

last_qual never really holds a time. It only holds jiffies. Make it the
same type as jiffies.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/net/wireless/atmel/atmel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/atmel/atmel.c b/drivers/net/wireless/atmel/atmel.c
index e12f62356fd1..27b110dc8cc6 100644
--- a/drivers/net/wireless/atmel/atmel.c
+++ b/drivers/net/wireless/atmel/atmel.c
@@ -513,7 +513,7 @@ struct atmel_private {
 	} station_state;
 
 	int operating_mode, power_mode;
-	time_t last_qual;
+	unsigned long last_qual;
 	int beacons_this_sec;
 	int channel;
 	int reg_domain, config_reg_domain;
-- 
2.11.0
