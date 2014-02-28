From: elder@linaro.org (Alex Elder)
Date: Fri, 28 Feb 2014 07:49:27 -0600
Subject: [PATCH 1/5] clk: bcm281xx: move compatible string definitions
In-Reply-To: <1393595371-3789-1-git-send-email-elder@linaro.org>
References: <1393595371-3789-1-git-send-email-elder@linaro.org>
Message-ID: <1393595371-3789-2-git-send-email-elder@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Broadcom 281xx clock code uses a #define for the compatible
string for it's clock control units (CCUs).  Rather than defining
those in the C source file, define them in the header file that's
shared by both the code and the device tree source file (along with
all the clock ids).

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/clk/bcm/clk-bcm281xx.c       |   12 ------------
 include/dt-bindings/clock/bcm281xx.h |   12 ++++++++++++
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/bcm/clk-bcm281xx.c b/drivers/clk/bcm/clk-bcm281xx.c
index d0d3dde..b937fc9 100644
--- a/drivers/clk/bcm/clk-bcm281xx.c
+++ b/drivers/clk/bcm/clk-bcm281xx.c
@@ -18,18 +18,6 @@
 #define BCM281XX_CCU_COMMON(_name, _ucase_name) \
 	KONA_CCU_COMMON(BCM281XX, _name, _ucase_name)
 
-/*
- * These are the bcm281xx CCU device tree "compatible" strings.
- * We're stuck with using "bcm11351" in the string because wild
- * cards aren't allowed, and that name was the first one defined
- * in this family of devices.
- */
-#define BCM281XX_DT_ROOT_CCU_COMPAT	"brcm,bcm11351-root-ccu"
-#define BCM281XX_DT_AON_CCU_COMPAT	"brcm,bcm11351-aon-ccu"
-#define BCM281XX_DT_HUB_CCU_COMPAT	"brcm,bcm11351-hub-ccu"
-#define BCM281XX_DT_MASTER_CCU_COMPAT	"brcm,bcm11351-master-ccu"
-#define BCM281XX_DT_SLAVE_CCU_COMPAT	"brcm,bcm11351-slave-ccu"
-
 /* Root CCU */
 
 static struct peri_clk_data frac_1m_data = {
diff --git a/include/dt-bindings/clock/bcm281xx.h b/include/dt-bindings/clock/bcm281xx.h
index 57591b1..99f4aad 100644
--- a/include/dt-bindings/clock/bcm281xx.h
+++ b/include/dt-bindings/clock/bcm281xx.h
@@ -20,6 +20,18 @@
  * the clock control units (CCUs) on Broadcom BCM281XX family SoCs.
  */
 
+/*
+ * These are the bcm281xx CCU device tree "compatible" strings.
+ * We're stuck with using "bcm11351" in the string because wild
+ * cards aren't allowed, and that name was the first one defined
+ * in this family of devices.
+ */
+#define BCM281XX_DT_ROOT_CCU_COMPAT	"brcm,bcm11351-root-ccu"
+#define BCM281XX_DT_AON_CCU_COMPAT	"brcm,bcm11351-aon-ccu"
+#define BCM281XX_DT_HUB_CCU_COMPAT	"brcm,bcm11351-hub-ccu"
+#define BCM281XX_DT_MASTER_CCU_COMPAT	"brcm,bcm11351-master-ccu"
+#define BCM281XX_DT_SLAVE_CCU_COMPAT	"brcm,bcm11351-slave-ccu"
+
 /* root CCU clock ids */
 
 #define BCM281XX_ROOT_CCU_FRAC_1M		0
-- 
1.7.9.5
