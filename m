From: j-keerthy@ti.com (Keerthy)
Date: Mon, 12 Nov 2018 10:47:40 +0530
Subject: [PATCH] soc: ti: wkup_m3: Add PRCM int16 as the wake up source
Message-ID: <1541999860-14550-1-git-send-email-j-keerthy@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add PRCM int16 as the wake up source.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 drivers/soc/ti/wkup_m3_ipc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/ti/wkup_m3_ipc.c b/drivers/soc/ti/wkup_m3_ipc.c
index f5cb8c0..d65e361 100644
--- a/drivers/soc/ti/wkup_m3_ipc.c
+++ b/drivers/soc/ti/wkup_m3_ipc.c
@@ -57,6 +57,7 @@
 static struct wkup_m3_ipc *m3_ipc_state;
 
 static const struct wkup_m3_wakeup_src wakeups[] = {
+	{.irq_nr = 16,	.src = "PRCM"},
 	{.irq_nr = 35,	.src = "USB0_PHY"},
 	{.irq_nr = 36,	.src = "USB1_PHY"},
 	{.irq_nr = 40,	.src = "I2C0"},
-- 
1.9.1
