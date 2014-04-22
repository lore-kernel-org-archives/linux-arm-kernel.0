From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 22 Apr 2014 23:26:09 +0200
Subject: [PATCH v2 05/38] memory: mvebu-devbus: use ARMADA_ prefix in defines
In-Reply-To: <1398202002-28530-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1398202002-28530-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1398202002-28530-6-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mvebu-devbus driver currently only supports the Armada 370/XP
family, but it can also cover the Orion5x family. However, the Orion5x
family has a different organization of the register. Therefore, in
preparation to the introduction of Orion5x support, we rename the
Armada 370/XP specific definitions to have an ARMADA_ prefix.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/memory/mvebu-devbus.c | 48 +++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/memory/mvebu-devbus.c b/drivers/memory/mvebu-devbus.c
index b59a17f..e66de7f 100644
--- a/drivers/memory/mvebu-devbus.c
+++ b/drivers/memory/mvebu-devbus.c
@@ -30,19 +30,19 @@
 #include <linux/platform_device.h>
 
 /* Register definitions */
-#define DEV_WIDTH_BIT		30
-#define BADR_SKEW_BIT		28
-#define RD_HOLD_BIT		23
-#define ACC_NEXT_BIT		17
-#define RD_SETUP_BIT		12
-#define ACC_FIRST_BIT		6
+#define ARMADA_DEV_WIDTH_BIT		30
+#define ARMADA_BADR_SKEW_BIT		28
+#define ARMADA_RD_HOLD_BIT		23
+#define ARMADA_ACC_NEXT_BIT		17
+#define ARMADA_RD_SETUP_BIT		12
+#define ARMADA_ACC_FIRST_BIT		6
 
-#define SYNC_ENABLE_BIT		24
-#define WR_HIGH_BIT		16
-#define WR_LOW_BIT		8
+#define ARMADA_SYNC_ENABLE_BIT		24
+#define ARMADA_WR_HIGH_BIT		16
+#define ARMADA_WR_LOW_BIT		8
 
-#define READ_PARAM_OFFSET	0x0
-#define WRITE_PARAM_OFFSET	0x4
+#define ARMADA_READ_PARAM_OFFSET	0x0
+#define ARMADA_WRITE_PARAM_OFFSET	0x4
 
 struct devbus_read_params {
 	u32 bus_width;
@@ -178,31 +178,31 @@ static int devbus_set_timing_params(struct devbus *devbus,
 		return err;
 
 	/* Set read timings */
-	value = r.bus_width << DEV_WIDTH_BIT |
-		r.badr_skew << BADR_SKEW_BIT |
-		r.rd_hold   << RD_HOLD_BIT   |
-		r.acc_next  << ACC_NEXT_BIT  |
-		r.rd_setup  << RD_SETUP_BIT  |
-		r.acc_first << ACC_FIRST_BIT |
+	value = r.bus_width << ARMADA_DEV_WIDTH_BIT |
+		r.badr_skew << ARMADA_BADR_SKEW_BIT |
+		r.rd_hold   << ARMADA_RD_HOLD_BIT   |
+		r.acc_next  << ARMADA_ACC_NEXT_BIT  |
+		r.rd_setup  << ARMADA_RD_SETUP_BIT  |
+		r.acc_first << ARMADA_ACC_FIRST_BIT |
 		r.turn_off;
 
 	dev_dbg(devbus->dev, "read parameters register 0x%p = 0x%x\n",
-		devbus->base + READ_PARAM_OFFSET,
+		devbus->base + ARMADA_READ_PARAM_OFFSET,
 		value);
 
-	writel(value, devbus->base + READ_PARAM_OFFSET);
+	writel(value, devbus->base + ARMADA_READ_PARAM_OFFSET);
 
 	/* Set write timings */
-	value = w.sync_enable  << SYNC_ENABLE_BIT |
-		w.wr_low       << WR_LOW_BIT      |
-		w.wr_high      << WR_HIGH_BIT     |
+	value = w.sync_enable  << ARMADA_SYNC_ENABLE_BIT |
+		w.wr_low       << ARMADA_WR_LOW_BIT      |
+		w.wr_high      << ARMADA_WR_HIGH_BIT     |
 		w.ale_wr;
 
 	dev_dbg(devbus->dev, "write parameters register: 0x%p = 0x%x\n",
-		devbus->base + WRITE_PARAM_OFFSET,
+		devbus->base + ARMADA_WRITE_PARAM_OFFSET,
 		value);
 
-	writel(value, devbus->base + WRITE_PARAM_OFFSET);
+	writel(value, devbus->base + ARMADA_WRITE_PARAM_OFFSET);
 
 	return 0;
 }
-- 
1.9.2
