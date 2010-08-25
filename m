From: ssanap@marvell.com (Sachin Sanap)
Date: Wed, 25 Aug 2010 14:48:41 +0530
Subject: [PATCH 2/3] [ARM] pxa: MFU pin configuration to support Fast ethernet.
Message-ID: <1282727921.6968.99.camel@pe-lt522.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Sachin Sanap <ssanap@marvell.com>
---
 arch/arm/mach-mmp/aspenite.c                |   18 ++++++++++++++++++
 arch/arm/mach-mmp/include/mach/mfp-pxa168.h |   19 +++++++++++++++++++
 2 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mmp/aspenite.c b/arch/arm/mach-mmp/aspenite.c
index d19c26c..a235551 100644
--- a/arch/arm/mach-mmp/aspenite.c
+++ b/arch/arm/mach-mmp/aspenite.c
@@ -74,6 +74,24 @@ static unsigned long common_pin_config[] __initdata = {
 	GPIO105_CI2C_SDA,
 	GPIO106_CI2C_SCL,
 
+	/* MFU */
+	GPIO86_TX_CLK,
+	GPIO87_TX_EN,
+	GPIO88_TX_DQ3,
+	GPIO89_TX_DQ2,
+	GPIO90_TX_DQ1,
+	GPIO91_TX_DQ0,
+	GPIO92_MII_CRS,
+	GPIO93_MII_COL,
+	GPIO94_RX_CLK,
+	GPIO95_RX_ER,
+	GPIO96_RX_DQ3,
+	GPIO97_RX_DQ2,
+	GPIO98_RX_DQ1,
+	GPIO99_RX_DQ0,
+	GPIO100_MII_MDC,
+	GPIO101_MII_MDIO,
+	GPIO103_RX_DV,
 };
 
 static struct smc91x_platdata smc91x_info = {
diff --git a/arch/arm/mach-mmp/include/mach/mfp-pxa168.h b/arch/arm/mach-mmp/include/mach/mfp-pxa168.h
index ded43c4..afea9dc 100644
--- a/arch/arm/mach-mmp/include/mach/mfp-pxa168.h
+++ b/arch/arm/mach-mmp/include/mach/mfp-pxa168.h
@@ -266,6 +266,25 @@
 #define GPIO116_I2S_RXD		MFP_CFG(GPIO116,AF2)
 #define GPIO117_I2S_TXD		MFP_CFG(GPIO117,AF2)
 
+/* MFU */
+#define GPIO86_TX_CLK		MFP_CFG(GPIO86, AF5)
+#define GPIO87_TX_EN		MFP_CFG(GPIO87, AF5)
+#define GPIO88_TX_DQ3		MFP_CFG(GPIO88, AF5)
+#define GPIO89_TX_DQ2		MFP_CFG(GPIO89, AF5)
+#define GPIO90_TX_DQ1		MFP_CFG(GPIO90, AF5)
+#define GPIO91_TX_DQ0		MFP_CFG(GPIO91, AF5)
+#define GPIO92_MII_CRS		MFP_CFG(GPIO92, AF5)
+#define GPIO93_MII_COL		MFP_CFG(GPIO93, AF5)
+#define GPIO94_RX_CLK		MFP_CFG(GPIO94, AF5)
+#define GPIO95_RX_ER		MFP_CFG(GPIO95, AF5)
+#define GPIO96_RX_DQ3		MFP_CFG(GPIO96, AF5)
+#define GPIO97_RX_DQ2		MFP_CFG(GPIO97, AF5)
+#define GPIO98_RX_DQ1		MFP_CFG(GPIO98, AF5)
+#define GPIO99_RX_DQ0		MFP_CFG(GPIO99, AF5)
+#define GPIO100_MII_MDC		MFP_CFG(GPIO100, AF5)
+#define GPIO101_MII_MDIO	MFP_CFG(GPIO101, AF5)
+#define GPIO103_RX_DV		MFP_CFG(GPIO103, AF5)
+
 /* PWM */
 #define GPIO96_PWM3_OUT		MFP_CFG(GPIO96, AF1)
 #define GPIO97_PWM2_OUT		MFP_CFG(GPIO97, AF1)
-- 
1.6.2.5
