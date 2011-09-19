From: ajaykumar.rs@samsung.com (Ajay Kumar)
Date: Mon, 19 Sep 2011 13:53:57 -0400
Subject: [PATCH RESEND V5 2/6] ARM: S5P64X0: Add register base and IRQ for
	Framebuffer
In-Reply-To: <1316454841-20869-1-git-send-email-ajaykumar.rs@samsung.com>
References: <1316454841-20869-1-git-send-email-ajaykumar.rs@samsung.com>
Message-ID: <1316454841-20869-3-git-send-email-ajaykumar.rs@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds:
	-- Framebuffer related register mappings and bit fields.
	-- IRQ number being used.

Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
---
 arch/arm/mach-s5p64x0/include/mach/irqs.h |    4 ++++
 arch/arm/mach-s5p64x0/include/mach/map.h  |    3 +++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5p64x0/include/mach/irqs.h b/arch/arm/mach-s5p64x0/include/mach/irqs.h
index 5837a36..53982db 100644
--- a/arch/arm/mach-s5p64x0/include/mach/irqs.h
+++ b/arch/arm/mach-s5p64x0/include/mach/irqs.h
@@ -87,6 +87,10 @@
 
 #define IRQ_I2S0		IRQ_I2SV40
 
+#define IRQ_LCD_FIFO		IRQ_DISPCON0
+#define IRQ_LCD_VSYNC		IRQ_DISPCON1
+#define IRQ_LCD_SYSTEM		IRQ_DISPCON2
+
 /* S5P6450 EINT feature will be added */
 
 /*
diff --git a/arch/arm/mach-s5p64x0/include/mach/map.h b/arch/arm/mach-s5p64x0/include/mach/map.h
index 95c9125..c5ef50c 100644
--- a/arch/arm/mach-s5p64x0/include/mach/map.h
+++ b/arch/arm/mach-s5p64x0/include/mach/map.h
@@ -47,6 +47,8 @@
 
 #define S5P64X0_PA_HSMMC(x)	(0xED800000 + ((x) * 0x100000))
 
+#define S5P64X0_PA_FB		0xEE000000
+
 #define S5P64X0_PA_I2S		0xF2000000
 #define S5P6450_PA_I2S1		0xF2800000
 #define S5P6450_PA_I2S2		0xF2900000
@@ -64,6 +66,7 @@
 #define S3C_PA_IIC1		S5P6440_PA_IIC1
 #define S3C_PA_RTC		S5P64X0_PA_RTC
 #define S3C_PA_WDT		S5P64X0_PA_WDT
+#define S3C_PA_FB		S5P64X0_PA_FB
 
 #define S5P_PA_CHIPID		S5P64X0_PA_CHIPID
 #define S5P_PA_SROMC		S5P64X0_PA_SROMC
-- 
1.7.0.4
