From: arun.parameswaran@broadcom.com (Arun Parameswaran)
Date: Thu, 26 Jul 2018 11:36:24 -0700
Subject: [PATCH 7/7] net: phy: Add pm support for scan ctrl register to bcm
 mdio mux
In-Reply-To: <1532630184-29450-1-git-send-email-arun.parameswaran@broadcom.com>
References: <1532630184-29450-1-git-send-email-arun.parameswaran@broadcom.com>
Message-ID: <1532630184-29450-8-git-send-email-arun.parameswaran@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for saving and restoring the 'scan control' register
in the Broadcom iProc mdio mux driver.

Signed-off-by: Arun Parameswaran <arun.parameswaran@broadcom.com>
---
 drivers/net/phy/mdio-mux-bcm-iproc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/mdio-mux-bcm-iproc.c b/drivers/net/phy/mdio-mux-bcm-iproc.c
index 89c18d6..d1fce1e 100644
--- a/drivers/net/phy/mdio-mux-bcm-iproc.c
+++ b/drivers/net/phy/mdio-mux-bcm-iproc.c
@@ -26,6 +26,9 @@
 #define MDIO_RATE_ADJ_INT_OFFSET	0x004
 #define MDIO_RATE_ADJ_DIVIDENT_SHIFT	16
 
+#define MDIO_SCAN_CTRL_OFFSET	0x008
+#define MDIO_SCAN_CTRL_OVERRIDE_EXT_MSTR	28
+
 #define MDIO_PARAM_OFFSET		0x23c
 #define MDIO_PARAM_MIIM_CYCLE		29
 #define MDIO_PARAM_INTERNAL_SEL		25
@@ -51,7 +54,7 @@
 #define MDIO_OPERATING_FREQUENCY	11000000
 #define MDIO_RATE_ADJ_DIVIDENT		1
 
-#define MDIO_NUM_OF_REGS_TO_RESTORE	2
+#define MDIO_NUM_OF_REGS_TO_RESTORE	3
 
 struct iproc_mdiomux_desc {
 	void *mux_handle;
@@ -68,6 +71,7 @@ struct iproc_mdiomux_desc {
 static const u16 restore_reg_offsets[MDIO_NUM_OF_REGS_TO_RESTORE] = {
 	MDIO_RATE_ADJ_EXT_OFFSET,
 	MDIO_RATE_ADJ_INT_OFFSET,
+	MDIO_SCAN_CTRL_OVERRIDE_EXT_MSTR,
 };
 #endif
 
-- 
1.9.1
