From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 19 Jan 2018 20:21:29 +0530
Subject: [PATCH] ARM: davinci: board-da830-evm: fix unused const variable
 warning
Message-ID: <20180119145129.16818-1-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

da830_evm_emif25_pins[] is used only when CONFIG_DA830_UI_NAND
is enabled. It gives the following warning when the config is
switched off. Fix it.

arch/arm/mach-davinci/board-da830-evm.c:245:20: warning: ?da830_evm_emif25_pins? defined but not used [-Wunused-const-variable=]
 static const short da830_evm_emif25_pins[] = {
                    ^~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/mach-davinci/board-da830-evm.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index a58bfcac8e9c..3c12e239f279 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -239,20 +239,6 @@ static inline void da830_evm_init_mmc(void)
 	}
 }
 
-/*
- * UI board NAND/NOR flashes only use 8-bit data bus.
- */
-static const short da830_evm_emif25_pins[] = {
-	DA830_EMA_D_0, DA830_EMA_D_1, DA830_EMA_D_2, DA830_EMA_D_3,
-	DA830_EMA_D_4, DA830_EMA_D_5, DA830_EMA_D_6, DA830_EMA_D_7,
-	DA830_EMA_A_0, DA830_EMA_A_1, DA830_EMA_A_2, DA830_EMA_A_3,
-	DA830_EMA_A_4, DA830_EMA_A_5, DA830_EMA_A_6, DA830_EMA_A_7,
-	DA830_EMA_A_8, DA830_EMA_A_9, DA830_EMA_A_10, DA830_EMA_A_11,
-	DA830_EMA_A_12, DA830_EMA_BA_0, DA830_EMA_BA_1, DA830_NEMA_WE,
-	DA830_NEMA_CS_2, DA830_NEMA_CS_3, DA830_NEMA_OE, DA830_EMA_WAIT_0,
-	-1
-};
-
 #define HAS_MMC		IS_ENABLED(CONFIG_MMC_DAVINCI)
 
 #ifdef CONFIG_DA830_UI_NAND
@@ -357,6 +343,20 @@ static struct platform_device da830_evm_nand_device = {
 	.resource	= da830_evm_nand_resources,
 };
 
+/*
+ * UI board NAND/NOR flashes only use 8-bit data bus.
+ */
+static const short da830_evm_emif25_pins[] = {
+	DA830_EMA_D_0, DA830_EMA_D_1, DA830_EMA_D_2, DA830_EMA_D_3,
+	DA830_EMA_D_4, DA830_EMA_D_5, DA830_EMA_D_6, DA830_EMA_D_7,
+	DA830_EMA_A_0, DA830_EMA_A_1, DA830_EMA_A_2, DA830_EMA_A_3,
+	DA830_EMA_A_4, DA830_EMA_A_5, DA830_EMA_A_6, DA830_EMA_A_7,
+	DA830_EMA_A_8, DA830_EMA_A_9, DA830_EMA_A_10, DA830_EMA_A_11,
+	DA830_EMA_A_12, DA830_EMA_BA_0, DA830_EMA_BA_1, DA830_NEMA_WE,
+	DA830_NEMA_CS_2, DA830_NEMA_CS_3, DA830_NEMA_OE, DA830_EMA_WAIT_0,
+	-1
+};
+
 static inline void da830_evm_init_nand(int mux_mode)
 {
 	int ret;
-- 
2.9.0
