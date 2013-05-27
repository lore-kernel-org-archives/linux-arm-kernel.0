From: philippe.begnic.st@gmail.com (Philippe Begnic)
Date: Mon, 27 May 2013 14:41:30 +0200
Subject: [PATCH 2/4] mfd: db8500: Update register definition for u8540 clock
In-Reply-To: <1369658492-31358-1-git-send-email-philippe.begnic.st@gmail.com>
References: <1369658492-31358-1-git-send-email-philippe.begnic.st@gmail.com>
Message-ID: <1369658492-31358-3-git-send-email-philippe.begnic.st@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philippe Begnic <philippe.begnic@st.com>

PRCMU and ab8500 registers updated for u8540

Signed-off-by: Philippe Begnic <philippe.begnic@st.com>
---
 include/linux/mfd/abx500/ab8500-sysctrl.h |    4 ++--
 include/linux/mfd/dbx500-prcmu.h          |   11 +++++++++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/linux/mfd/abx500/ab8500-sysctrl.h b/include/linux/mfd/abx500/ab8500-sysctrl.h
index 990bc93..adba89d 100644
--- a/include/linux/mfd/abx500/ab8500-sysctrl.h
+++ b/include/linux/mfd/abx500/ab8500-sysctrl.h
@@ -278,8 +278,8 @@ struct ab8500_sysctrl_platform_data {
 
 #define AB9540_SYSCLK12CONFCTRL_PLL26TO38ENA BIT(0)
 #define AB9540_SYSCLK12CONFCTRL_SYSCLK12USBMUXSEL BIT(1)
-#define AB9540_SYSCLK12CONFCTRL_INT384MHZMUXSEL_MASK 0x0C
-#define AB9540_SYSCLK12CONFCTRL_INT384MHZMUXSEL_SHIFT 2
+#define AB9540_SYSCLK12CONFCTRL_INT384MHZMUXSEL0 BIT(2)
+#define AB9540_SYSCLK12CONFCTRL_INT384MHZMUXSEL1 BIT(3)
 #define AB9540_SYSCLK12CONFCTRL_SYSCLK12BUFMUX BIT(4)
 #define AB9540_SYSCLK12CONFCTRL_SYSCLK12PLLMUX BIT(5)
 #define AB9540_SYSCLK12CONFCTRL_SYSCLK2MUXVALID BIT(6)
diff --git a/include/linux/mfd/dbx500-prcmu.h b/include/linux/mfd/dbx500-prcmu.h
index 689e6a0..d0ba355 100644
--- a/include/linux/mfd/dbx500-prcmu.h
+++ b/include/linux/mfd/dbx500-prcmu.h
@@ -134,6 +134,10 @@ enum prcmu_clock {
 	PRCMU_SIACLK,
 	PRCMU_SVACLK,
 	PRCMU_ACLK,
+	PRCMU_HVACLK, /* Ux540 only */
+	PRCMU_G1CLK, /* Ux540 only */
+	PRCMU_SDMMCHCLK,
+	PRCMU_CAMCLK,
 	PRCMU_NUM_REG_CLOCKS,
 	PRCMU_SYSCLK = PRCMU_NUM_REG_CLOCKS,
 	PRCMU_CDCLK,
@@ -148,6 +152,13 @@ enum prcmu_clock {
 	PRCMU_DSI0ESCCLK,
 	PRCMU_DSI1ESCCLK,
 	PRCMU_DSI2ESCCLK,
+	/* LCD DSI PLL - Ux540 only */
+	PRCMU_PLLDSI_LCD,
+	PRCMU_DSI0CLK_LCD,
+	PRCMU_DSI1CLK_LCD,
+	PRCMU_DSI0ESCCLK_LCD,
+	PRCMU_DSI1ESCCLK_LCD,
+	PRCMU_DSI2ESCCLK_LCD,
 };
 
 /**
-- 
1.7.9.5
