From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 16 Dec 2016 10:05:08 +0100
Subject: [PATCH] ARM: imx: remove unused device definitions
Message-ID: <20161216090533.2195228-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I stumbled over these during build testing, they are evidently
not referenced anywhere any more.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-imx/devices/platform-flexcan.c         |  9 ---------
 arch/arm/mach-imx/devices/platform-sdhci-esdhc-imx.c | 10 ----------
 2 files changed, 19 deletions(-)

diff --git a/arch/arm/mach-imx/devices/platform-flexcan.c b/arch/arm/mach-imx/devices/platform-flexcan.c
index 55d61eaf63c6..8a1a2fc4ce10 100644
--- a/arch/arm/mach-imx/devices/platform-flexcan.c
+++ b/arch/arm/mach-imx/devices/platform-flexcan.c
@@ -19,15 +19,6 @@
 #define imx_flexcan_data_entry(soc, _id, _hwid, _size)			\
 	[_id] = imx_flexcan_data_entry_single(soc, _id, _hwid, _size)
 
-#ifdef CONFIG_SOC_IMX25
-const struct imx_flexcan_data imx25_flexcan_data[] __initconst = {
-#define imx25_flexcan_data_entry(_id, _hwid)				\
-	imx_flexcan_data_entry(MX25, _id, _hwid, SZ_16K)
-	imx25_flexcan_data_entry(0, 1),
-	imx25_flexcan_data_entry(1, 2),
-};
-#endif /* ifdef CONFIG_SOC_IMX25 */
-
 #ifdef CONFIG_SOC_IMX35
 const struct imx_flexcan_data imx35_flexcan_data[] __initconst = {
 #define imx35_flexcan_data_entry(_id, _hwid)				\
diff --git a/arch/arm/mach-imx/devices/platform-sdhci-esdhc-imx.c b/arch/arm/mach-imx/devices/platform-sdhci-esdhc-imx.c
index 3d039ef021e0..466c9ccc6675 100644
--- a/arch/arm/mach-imx/devices/platform-sdhci-esdhc-imx.c
+++ b/arch/arm/mach-imx/devices/platform-sdhci-esdhc-imx.c
@@ -22,16 +22,6 @@
 #define imx_sdhci_esdhc_imx_data_entry(soc, devid, id, hwid)	\
 	[id] = imx_sdhci_esdhc_imx_data_entry_single(soc, devid, id, hwid)
 
-#ifdef CONFIG_SOC_IMX25
-const struct imx_sdhci_esdhc_imx_data
-imx25_sdhci_esdhc_imx_data[] __initconst = {
-#define imx25_sdhci_esdhc_imx_data_entry(_id, _hwid)			\
-	imx_sdhci_esdhc_imx_data_entry(MX25, "sdhci-esdhc-imx25", _id, _hwid)
-	imx25_sdhci_esdhc_imx_data_entry(0, 1),
-	imx25_sdhci_esdhc_imx_data_entry(1, 2),
-};
-#endif /* ifdef CONFIG_SOC_IMX25 */
-
 #ifdef CONFIG_SOC_IMX35
 const struct imx_sdhci_esdhc_imx_data
 imx35_sdhci_esdhc_imx_data[] __initconst = {
-- 
2.9.0
