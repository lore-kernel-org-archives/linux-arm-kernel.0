From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 19 Mar 2010 15:33:22 +0900
Subject: [PATCH v2 2/3] ARM: S5P6442: Bug fix on PWM Timer
Message-ID: <1268980402-2545-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jongpill Lee <boyko.lee@samsung.com>

This patch fixes return value in below functions
- pwm_cfg_src_is_tclk
- tcfg_to_divisor
- pwm_tdiv_has_div1
- pwm_tdiv_div_bits

And this patch changes Copyright ordering.

Signed-off-by: Jongpill Lee <boyko.lee@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5p6442/include/mach/pwm-clock.h |   21 +++++++++++----------
 1 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-s5p6442/include/mach/pwm-clock.h b/arch/arm/mach-s5p6442/include/mach/pwm-clock.h
index 15e8525..1d00b4d 100644
--- a/arch/arm/mach-s5p6442/include/mach/pwm-clock.h
+++ b/arch/arm/mach-s5p6442/include/mach/pwm-clock.h
@@ -1,13 +1,14 @@
 /* linux/arch/arm/mach-s5p6442/include/mach/pwm-clock.h
  *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * Copyright 2008 Openmoko, Inc.
  * Copyright 2008 Simtec Electronics
  *      Ben Dooks <ben@simtec.co.uk>
  *      http://armlinux.simtec.co.uk/
  *
- * Copyright 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * Based on arch/arm/plat-s3c24xx/include/mach/pwm-clock.h
+ * Based on arch/arm/mach-s3c64xx/include/mach/pwm-clock.h
  *
  * S5P6442 - pwm clock and timer support
  *
@@ -21,14 +22,14 @@
 
 /**
  * pwm_cfg_src_is_tclk() - return whether the given mux config is a tclk
- * @cfg: The timer TCFG1 register bits shifted down to 0.
+ * @tcfg: The timer TCFG1 register bits shifted down to 0.
  *
  * Return true if the given configuration from TCFG1 is a TCLK instead
  * any of the TDIV clocks.
  */
 static inline int pwm_cfg_src_is_tclk(unsigned long tcfg)
 {
-	return tcfg == S3C2410_TCFG1_MUX_TCLK;
+	return tcfg == S3C64XX_TCFG1_MUX_TCLK;
 }
 
 /**
@@ -40,7 +41,7 @@ static inline int pwm_cfg_src_is_tclk(unsigned long tcfg)
  */
 static inline unsigned long tcfg_to_divisor(unsigned long tcfg1)
 {
-	return 1 << (1 + tcfg1);
+	return 1 << tcfg1;
 }
 
 /**
@@ -50,7 +51,7 @@ static inline unsigned long tcfg_to_divisor(unsigned long tcfg1)
  */
 static inline unsigned int pwm_tdiv_has_div1(void)
 {
-	return 0;
+	return 1;
 }
 
 /**
@@ -61,9 +62,9 @@ static inline unsigned int pwm_tdiv_has_div1(void)
  */
 static inline unsigned long pwm_tdiv_div_bits(unsigned int div)
 {
-	return ilog2(div) - 1;
+	return ilog2(div);
 }
 
-#define S3C_TCFG1_MUX_TCLK S3C2410_TCFG1_MUX_TCLK
+#define S3C_TCFG1_MUX_TCLK S3C64XX_TCFG1_MUX_TCLK
 
 #endif /* __ASM_ARCH_PWMCLK_H */
-- 
1.6.2.5
