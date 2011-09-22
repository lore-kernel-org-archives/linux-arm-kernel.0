From: rogerio.pimentel@freescale.com (Rogerio Pimentel)
Date: Thu, 22 Sep 2011 14:30:34 -0300
Subject: [PATCH v3 3/4] ARM: mx53: Add resources for flexcan
In-Reply-To: <1316712635-25126-1-git-send-email-rogerio.pimentel@freescale.com>
References: <1316712635-25126-1-git-send-email-rogerio.pimentel@freescale.com>
Message-ID: <1316712635-25126-3-git-send-email-rogerio.pimentel@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding resources for flexcan on i.MX53

Signed-off-by: Rogerio Pimentel <rogerio.pimentel@freescale.com>
---
Changes since v2: 
Rebased to imx-cleanup
 arch/arm/mach-mx5/devices-imx53.h            |    6 ++++++
 arch/arm/plat-mxc/devices/platform-flexcan.c |    7 +++++++
 arch/arm/plat-mxc/include/mach/mx53.h        |    2 ++
 3 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/devices-imx53.h b/arch/arm/mach-mx5/devices-imx53.h
index c27fe8b..a3e1375 100644
--- a/arch/arm/mach-mx5/devices-imx53.h
+++ b/arch/arm/mach-mx5/devices-imx53.h
@@ -40,3 +40,9 @@ extern const struct imx_imx_ssi_data imx53_imx_ssi_data[];
 extern const struct imx_imx_keypad_data imx53_imx_keypad_data;
 #define imx53_add_imx_keypad(pdata)	\
 	imx_add_imx_keypad(&imx53_imx_keypad_data, pdata)
+
+extern const struct imx_flexcan_data imx53_flexcan_data[];
+#define imx53_add_flexcan(id, pdata)	\
+	imx_add_flexcan(&imx53_flexcan_data[id], pdata)
+#define imx53_add_flexcan0(pdata)	imx53_add_flexcan(0, pdata)
+#define imx53_add_flexcan1(pdata)	imx53_add_flexcan(1, pdata)
diff --git a/arch/arm/plat-mxc/devices/platform-flexcan.c b/arch/arm/plat-mxc/devices/platform-flexcan.c
index 4e8497a..4cce16b 100644
--- a/arch/arm/plat-mxc/devices/platform-flexcan.c
+++ b/arch/arm/plat-mxc/devices/platform-flexcan.c
@@ -37,6 +37,13 @@ const struct imx_flexcan_data imx35_flexcan_data[] __initconst = {
 };
 #endif /* ifdef CONFIG_SOC_IMX35 */
 
+#ifdef CONFIG_SOC_IMX53
+const struct imx_flexcan_data imx53_flexcan_data[] __initconst = {
+	imx_flexcan_data_entry(MX53, 0, 1, SZ_16K),
+	imx_flexcan_data_entry(MX53, 1, 2, SZ_16K),
+};
+#endif /* ifdef CONFIG_SOC_IMX53 */
+
 struct platform_device *__init imx_add_flexcan(
 		const struct imx_flexcan_data *data,
 		const struct flexcan_platform_data *pdata)
diff --git a/arch/arm/plat-mxc/include/mach/mx53.h b/arch/arm/plat-mxc/include/mach/mx53.h
index a37e8c3..13cb2a5 100644
--- a/arch/arm/plat-mxc/include/mach/mx53.h
+++ b/arch/arm/plat-mxc/include/mach/mx53.h
@@ -91,6 +91,8 @@
 #define MX53_PWM2_BASE_ADDR	(MX53_AIPS1_BASE_ADDR + 0x000B8000)
 #define MX53_UART1_BASE_ADDR	(MX53_AIPS1_BASE_ADDR + 0x000BC000)
 #define MX53_UART2_BASE_ADDR	(MX53_AIPS1_BASE_ADDR + 0x000C0000)
+#define MX53_CAN1_BASE_ADDR	(MX53_AIPS1_BASE_ADDR + 0x000C8000)
+#define MX53_CAN2_BASE_ADDR	(MX53_AIPS1_BASE_ADDR + 0x000CC000)
 #define MX53_SRC_BASE_ADDR	(MX53_AIPS1_BASE_ADDR + 0x000D0000)
 #define MX53_CCM_BASE_ADDR	(MX53_AIPS1_BASE_ADDR + 0x000D4000)
 #define MX53_GPC_BASE_ADDR	(MX53_AIPS1_BASE_ADDR + 0x000D8000)
-- 
1.7.1
