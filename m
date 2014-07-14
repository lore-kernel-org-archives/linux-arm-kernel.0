From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 14 Jul 2014 17:54:20 +0200
Subject: [PATCH v2 3/6] arm: pxa: add clock pll selection bits
In-Reply-To: <1405353263-13424-1-git-send-email-robert.jarzmik@free.fr>
References: <1405353263-13424-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1405353263-13424-4-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing bits for CCCR and CCSR :
 - CPLL and PPLL selection, either full speed or 13MHz
 - CPSR masks

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/mach-pxa/include/mach/pxa2xx-regs.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/mach-pxa/include/mach/pxa2xx-regs.h b/arch/arm/mach-pxa/include/mach/pxa2xx-regs.h
index ee6ced1..f1dd629 100644
--- a/arch/arm/mach-pxa/include/mach/pxa2xx-regs.h
+++ b/arch/arm/mach-pxa/include/mach/pxa2xx-regs.h
@@ -143,6 +143,16 @@
 #define CCCR_M_MASK	0x0060	/* Memory Frequency to Run Mode Frequency Multiplier */
 #define CCCR_L_MASK	0x001f	/* Crystal Frequency to Memory Frequency Multiplier */
 
+#define CCCR_CPDIS_BIT	(31)
+#define CCCR_PPDIS_BIT	(30)
+#define CCCR_LCD_26_BIT	(27)
+#define CCCR_A_BIT	(25)
+
+#define CCSR_N2_MASK	CCCR_N_MASK
+#define CCSR_M_MASK	CCCR_M_MASK
+#define CCSR_L_MASK	CCCR_L_MASK
+#define CCSR_N2_SHIFT	7
+
 #define CKEN_AC97CONF   (31)    /* AC97 Controller Configuration */
 #define CKEN_CAMERA	(24)	/* Camera Interface Clock Enable */
 #define CKEN_SSP1	(23)	/* SSP1 Unit Clock Enable */
-- 
2.0.0.rc2
