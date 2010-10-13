From: sbkim73@samsung.com (Sangbeom Kim)
Date: Wed, 13 Oct 2010 09:10:24 +0900
Subject: [PATCH 1/4] ARM: S3C2416: Add USB Phy register definitions
In-Reply-To: <1286928627-22824-1-git-send-email-sbkim73@samsung.com>
References: <1286928627-22824-1-git-send-email-sbkim73@samsung.com>
Message-ID: <1286928627-22824-2-git-send-email-sbkim73@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Abraham <thomas.ab@samsung.com>

Add register definitions required to configure the USB Phy. The definitions
for PHYCTRL, PHYPWR, URSTCON and UCLKCON registers and corresponding bit
field definitions are added.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Sangbeom Kim <sbkim73@samsung.com>
---
 .../mach-s3c2410/include/mach/regs-s3c2443-clock.h |   25 ++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c2410/include/mach/regs-s3c2443-clock.h b/arch/arm/mach-s3c2410/include/mach/regs-s3c2443-clock.h
index 08ab9df..2c93d83 100644
--- a/arch/arm/mach-s3c2410/include/mach/regs-s3c2443-clock.h
+++ b/arch/arm/mach-s3c2410/include/mach/regs-s3c2443-clock.h
@@ -37,6 +37,10 @@
 #define S3C2443_SYSID			S3C2443_CLKREG(0x5C)
 #define S3C2443_PWRCFG			S3C2443_CLKREG(0x60)
 #define S3C2443_RSTCON			S3C2443_CLKREG(0x64)
+#define S3C2443_PHYCTRL			S3C2443_CLKREG(0x80)
+#define S3C2443_PHYPWR			S3C2443_CLKREG(0x84)
+#define S3C2443_URSTCON			S3C2443_CLKREG(0x88)
+#define S3C2443_UCLKCON			S3C2443_CLKREG(0x8C)
 
 #define S3C2443_SWRST_RESET		(0x533c2443)
 
@@ -118,6 +122,27 @@
 #define S3C2443_SCLKCON_UARTCLK		(1<<8)
 #define S3C2443_SCLKCON_USBHOST		(1<<1)
 
+#define S3C2443_PWRCFG_USBPHY		(1 << 4)
+
+#define S3C2443_URSTCON_FUNCRST		(1 << 2)
+#define S3C2443_URSTCON_PHYRST		(1 << 0)
+
+#define S3C2443_PHYCTRL_CLKSEL		(1 << 3)
+#define S3C2443_PHYCTRL_EXTCLK		(1 << 2)
+#define S3C2443_PHYCTRL_PLLSEL		(1 << 1)
+#define S3C2443_PHYCTRL_DSPORT		(1 << 0)
+
+#define S3C2443_PHYPWR_COMMON_ON	(1 << 31)
+#define S3C2443_PHYPWR_ANALOG_PD	(1 << 4)
+#define S3C2443_PHYPWR_PLL_REFCLK	(1 << 3)
+#define S3C2443_PHYPWR_XO_ON		(1 << 2)
+#define S3C2443_PHYPWR_PLL_PWRDN	(1 << 1)
+#define S3C2443_PHYPWR_FSUSPEND		(1 << 0)
+
+#define S3C2443_UCLKCON_DETECT_VBUS	(1 << 31)
+#define S3C2443_UCLKCON_FUNC_CLKEN	(1 << 2)
+#define S3C2443_UCLKCON_TCLKEN		(1 << 0)
+
 #include <asm/div64.h>
 
 static inline unsigned int
-- 
1.6.6.rc2
