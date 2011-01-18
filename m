From: michael.williamson@criticallink.com (Michael Williamson)
Date: Tue, 18 Jan 2011 12:21:43 -0500
Subject: [PATCH v1 2/5] davinci: da850: remove unused emif pinmux array
In-Reply-To: <1295371306-24035-1-git-send-email-michael.williamson@criticallink.com>
References: <1295371306-24035-1-git-send-email-michael.williamson@criticallink.com>
Message-ID: <1295371306-24035-3-git-send-email-michael.williamson@criticallink.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The da850_emif25_pins pinmux array is not used.  Remove it.

Signed-off-by: Michael Williamson <michael.williamson@criticallink.com>
---
 arch/arm/mach-davinci/da850.c              |   16 ----------------
 arch/arm/mach-davinci/include/mach/da8xx.h |    1 -
 2 files changed, 0 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index a39767c..ca4f595 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -600,22 +600,6 @@ const short da850_mmcsd0_pins[] __initdata = {
 	-1
 };
 
-const short da850_emif25_pins[] __initdata = {
-	DA850_EMA_BA_1, DA850_EMA_CLK, DA850_EMA_WAIT_1, DA850_NEMA_CS_2,
-	DA850_NEMA_CS_3, DA850_NEMA_CS_4, DA850_NEMA_WE, DA850_NEMA_OE,
-	DA850_EMA_D_0, DA850_EMA_D_1, DA850_EMA_D_2, DA850_EMA_D_3,
-	DA850_EMA_D_4, DA850_EMA_D_5, DA850_EMA_D_6, DA850_EMA_D_7,
-	DA850_EMA_D_8, DA850_EMA_D_9, DA850_EMA_D_10, DA850_EMA_D_11,
-	DA850_EMA_D_12, DA850_EMA_D_13, DA850_EMA_D_14, DA850_EMA_D_15,
-	DA850_EMA_A_0, DA850_EMA_A_1, DA850_EMA_A_2, DA850_EMA_A_3,
-	DA850_EMA_A_4, DA850_EMA_A_5, DA850_EMA_A_6, DA850_EMA_A_7,
-	DA850_EMA_A_8, DA850_EMA_A_9, DA850_EMA_A_10, DA850_EMA_A_11,
-	DA850_EMA_A_12, DA850_EMA_A_13, DA850_EMA_A_14, DA850_EMA_A_15,
-	DA850_EMA_A_16, DA850_EMA_A_17, DA850_EMA_A_18, DA850_EMA_A_19,
-	DA850_EMA_A_20, DA850_EMA_A_21, DA850_EMA_A_22, DA850_EMA_A_23,
-	-1
-};
-
 /* FIQ are pri 0-1; otherwise 2-7, with 7 lowest priority */
 static u8 da850_default_priorities[DA850_N_CP_INTC_IRQ] = {
 	[IRQ_DA8XX_COMMTX]		= 7,
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index 5f634c8..4297f1e 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -131,6 +131,5 @@ extern const short da850_i2c1_pins[];
 extern const short da850_mcasp_pins[];
 extern const short da850_lcdcntl_pins[];
 extern const short da850_mmcsd0_pins[];
-extern const short da850_emif25_pins[];
 
 #endif /* __ASM_ARCH_DAVINCI_DA8XX_H */
-- 
1.7.0.4
