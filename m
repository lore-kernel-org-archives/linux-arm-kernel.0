From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Tue, 25 Aug 2015 00:26:31 +0530
Subject: [PATCH-v2 2/5] mfd: 88pm800: Update the header file with 32K clk
 related macros
In-Reply-To: <1440442594-3102-1-git-send-email-vaibhav.hiremath@linaro.org>
References: <1440442594-3102-1-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <1440442594-3102-4-git-send-email-vaibhav.hiremath@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update header file with required macros for 32KHz buffered clock
output of 88PM800 family of device.
These macros will be used in clk provider driver.

Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
---
 include/linux/mfd/88pm80x.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/mfd/88pm80x.h b/include/linux/mfd/88pm80x.h
index 122cfd2..0215d5f 100644
--- a/include/linux/mfd/88pm80x.h
+++ b/include/linux/mfd/88pm80x.h
@@ -91,6 +91,7 @@ enum {
 /* Referance and low power registers */
 #define PM800_LOW_POWER1		(0x20)
 #define PM800_LOW_POWER2		(0x21)
+#define PM800_LOW_POWER2_XO_LJ_EN	BIT(5)
 
 #define PM800_LOW_POWER_CONFIG3		(0x22)
 #define PM800_LDOBK_FREEZE		BIT(7)
@@ -138,6 +139,13 @@ enum {
 #define PM800_ALARM			BIT(5)
 #define PM800_RTC1_USE_XO		BIT(7)
 
+#define PM800_32K_OUTX_SEL_MASK		0x3
+/* 32KHz clk output sel mode */
+#define PM800_32K_OUTX_SEL_ZERO		0x0
+#define PM800_32K_OUTX_SEL_INT_32KHZ	0x1
+#define PM800_32K_OUTX_SEL_XO_32KHZ	0x2
+#define PM800_32K_OUTX_SEL_HIZ		0x3
+
 /* Regulator Control Registers: BUCK1,BUCK5,LDO1 have DVC */
 
 /* buck registers */
@@ -208,6 +216,10 @@ enum {
 #define PM800_PMOD_MEAS1		0x52
 #define PM800_PMOD_MEAS2		0x53
 
+/* Oscillator control */
+#define PM800_OSC_CNTRL1		0x50
+#define PM800_OSC_CNTRL1_OSC_FREERUN_EN	BIT(1)
+
 #define PM800_GPADC0_MEAS1		0x54
 #define PM800_GPADC0_MEAS2		0x55
 #define PM800_GPADC1_MEAS1		0x56
-- 
1.9.1
