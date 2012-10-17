From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 17 Oct 2012 16:38:32 +0900
Subject: [PATCH] mfd: wm5102: Mark some more status registers as volatile
In-Reply-To: <1350459519-20462-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20121017073813.GI14199@opensource.wolfsonmicro.com>
 <1350459519-20462-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <1350459519-20462-2-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/mfd/wm5102-tables.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mfd/wm5102-tables.c b/drivers/mfd/wm5102-tables.c
index 14490cc..e1dc022 100644
--- a/drivers/mfd/wm5102-tables.c
+++ b/drivers/mfd/wm5102-tables.c
@@ -1814,6 +1814,9 @@ static bool wm5102_volatile_register(struct device *dev, unsigned int reg)
 	case ARIZONA_SOFTWARE_RESET:
 	case ARIZONA_DEVICE_REVISION:
 	case ARIZONA_OUTPUT_STATUS_1:
+	case ARIZONA_RAW_OUTPUT_STATUS_1:
+	case ARIZONA_SLIMBUS_RX_PORT_STATUS:
+	case ARIZONA_SLIMBUS_TX_PORT_STATUS:
 	case ARIZONA_SAMPLE_RATE_1_STATUS:
 	case ARIZONA_SAMPLE_RATE_2_STATUS:
 	case ARIZONA_SAMPLE_RATE_3_STATUS:
-- 
1.7.10.4
