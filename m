From: rogerio.pimentel@freescale.com (Rogerio Pimentel)
Date: Fri, 9 Sep 2011 17:00:07 -0300
Subject: [PATCH v2 3/4] ARM: mx53: Add resources for flexcan
In-Reply-To: <1315598408-29563-1-git-send-email-rogerio.pimentel@freescale.com>
References: <1315598408-29563-1-git-send-email-rogerio.pimentel@freescale.com>
Message-ID: <1315598408-29563-3-git-send-email-rogerio.pimentel@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding resources for flexcan on i.MX53

Signed-off-by: Rogerio Pimentel <rogerio.pimentel@freescale.com>
---
Changes since v1: 
Changed the way imx_flexcan_data_entry is called
 arch/arm/mach-mx5/devices-imx53.h            |    6 ++++++
 arch/arm/plat-mxc/devices/platform-flexcan.c |    7 +++++++
 arch/arm/plat-mxc/include/mach/mx53.h        |    2 ++
 3 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/devices-imx53.h b/arch/arm/mach-mx5/devices-imx53.h
index 7ca5d0c..8c00464 100644
--- a/arch/arm/mach-mx5/devices-imx53.h
+++ b/arch/arm/mach-mx5/devices-imx53.h
@@ -44,3 +44,9 @@ extern const struct imx_imx_keypad_data imx53_imx_keypad_data;
 extern const struct imx_pata_imx_data imx53_pata_imx_data;
 #define imx53_add_pata_imx() \
 	imx_add_pata_imx(&imx53_pata_imx_data)
+
+extern const struct imx_flexcan_data imx53_flexcan_data[];
+#define imx53_add_flexcan(id, pdata)	\
+	imx_add_flexcan(&imx53_flexcan_data[id], pdata)
+#define imx53_add_flexcan0(pdata)	imx53_add_flexcan(0, pdata)
+#define imx53_add_flexcan1(pdata)	imx53_add_flexcan(1, pdata)
diff --git a/arch/arm/plat-mxc/devices/platform-flexcan.c b/arch/arm/plat-mxc/devices/platform-flexcan.c
index 4e8497a..1c9612f 100644
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
index 5e3c323..e96ed9f 100644
--- a/arch/arm/plat-mxc/include/mach/mx53.h
+++ b/arch/arm/plat-mxc/include/mach/mx53.h
@@ -90,6 +90,8 @@
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
