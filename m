From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sat, 22 Jul 2017 21:19:44 +0200
Subject: [PATCH v4 5/7] clk: meson: meson8b: export the CPU soft reset lines
In-Reply-To: <20170722191946.22938-1-martin.blumenstingl@googlemail.com>
References: <20170722191946.22938-1-martin.blumenstingl@googlemail.com>
Message-ID: <20170722191946.22938-6-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Export the soft reset lines for the CPU cores so they can be used in the
dt-bindings (required for SMP booting the CPU cores).

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/meson/meson8b.h              | 8 ++++----
 include/dt-bindings/clock/meson8b-clkc.h | 7 ++++++-
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/meson/meson8b.h b/drivers/clk/meson/meson8b.h
index 5f4d8e49dd4d..d6e35c1acc05 100644
--- a/drivers/clk/meson/meson8b.h
+++ b/drivers/clk/meson/meson8b.h
@@ -169,10 +169,10 @@
 #define RESETID_L2_CACHE_SOFT_RESET				0
 #define RESETID_AXI_64_TO_128_BRIDGE_A5_SOFT_RESET		1
 #define RESETID_SCU_SOFT_RESET					2
-#define RESETID_CPU0_SOFT_RESET					3
-#define RESETID_CPU1_SOFT_RESET					4
-#define RESETID_CPU2_SOFT_RESET					5
-#define RESETID_CPU3_SOFT_RESET					6
+/* RESETID_CPU0_SOFT_RESET */
+/* RESETID_CPU1_SOFT_RESET */
+/* RESETID_CPU2_SOFT_RESET */
+/* RESETID_CPU3_SOFT_RESET */
 #define RESETID_A5_GLOBAL_RESET					7
 #define RESETID_A5_AXI_SOFT_RESET				8
 #define RESETID_A5_ABP_SOFT_RESET				9
diff --git a/include/dt-bindings/clock/meson8b-clkc.h b/include/dt-bindings/clock/meson8b-clkc.h
index e29227fb52a1..76920cfd1f33 100644
--- a/include/dt-bindings/clock/meson8b-clkc.h
+++ b/include/dt-bindings/clock/meson8b-clkc.h
@@ -1,5 +1,5 @@
 /*
- * Meson8b clock tree IDs
+ * Meson8b clock and reset tree IDs
  */
 
 #ifndef __MESON8B_CLKC_H
@@ -32,4 +32,9 @@
 #define CLKID_USB0_DDR_BRIDGE	65
 #define CLKID_SANA		69
 
+#define RESETID_CPU0_SOFT_RESET					3
+#define RESETID_CPU1_SOFT_RESET					4
+#define RESETID_CPU2_SOFT_RESET					5
+#define RESETID_CPU3_SOFT_RESET					6
+
 #endif /* __MESON8B_CLKC_H */
-- 
2.13.3
