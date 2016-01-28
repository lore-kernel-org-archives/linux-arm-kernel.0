From: jamesjj.liao@mediatek.com (James Liao)
Date: Thu, 28 Jan 2016 16:58:57 +0800
Subject: [PATCH v2] clk: Move vendor's Kconfig into CCF menu section
Message-ID: <1453971537-5510-1-git-send-email-jamesjj.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move all vendor's Kconfig into CCF menu section to prevent
new drivers putting their Kconfig files in a wrong place.

Some Kconigs need to modify at the same time to avoid build
warnings.

Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
---
This patch is based on v4.5-rc1.

changes since v1:
- Modify s3c24xx and samsung's Kconfig to avoid build warngings.

 arch/arm/mach-s3c24xx/Kconfig | 1 +
 drivers/clk/Kconfig           | 8 +++-----
 drivers/clk/samsung/Kconfig   | 1 -
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
index ef68ecb..f02495f 100644
--- a/arch/arm/mach-s3c24xx/Kconfig
+++ b/arch/arm/mach-s3c24xx/Kconfig
@@ -15,6 +15,7 @@ config PLAT_S3C24XX
 	select NO_IOPORT_MAP
 	select S3C_DEV_NAND
 	select IRQ_DOMAIN
+	select COMMON_CLK
 	help
 	  Base platform code for any Samsung S3C24XX device
 
diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index eca8e01..de707b2 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -202,11 +202,9 @@ config COMMON_CLK_CDCE706
 
 source "drivers/clk/bcm/Kconfig"
 source "drivers/clk/hisilicon/Kconfig"
-source "drivers/clk/qcom/Kconfig"
-
-endmenu
-
 source "drivers/clk/mvebu/Kconfig"
-
+source "drivers/clk/qcom/Kconfig"
 source "drivers/clk/samsung/Kconfig"
 source "drivers/clk/tegra/Kconfig"
+
+endmenu
diff --git a/drivers/clk/samsung/Kconfig b/drivers/clk/samsung/Kconfig
index 84196ec..b3fe5cb 100644
--- a/drivers/clk/samsung/Kconfig
+++ b/drivers/clk/samsung/Kconfig
@@ -1,6 +1,5 @@
 config COMMON_CLK_SAMSUNG
 	bool
-	select COMMON_CLK
 
 config S3C2410_COMMON_CLK
 	bool
-- 
1.9.1
