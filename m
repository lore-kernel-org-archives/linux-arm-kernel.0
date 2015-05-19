From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 19 May 2015 17:11:08 +0200
Subject: [PATCH] phy: qcom-ufs: fix platform dependency
Message-ID: <4583047.eZev6xPGf6@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The UFS PHY driver is written for the QCOM platform, but
has an incorrect dependency pointing to the recently
removed MSM platform, causing a warning whenever it
gets selected:

warning: (SCSI_UFS_QCOM) selects PHY_QCOM_UFS which has unmet direct dependencies (OF && ARCH_MSM)

This fixes the dependency.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: af6f8fff446 ("ufs-qcom: Switch dependency to ARCH_QCOM")

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 1b5c235562c9..c4d599976306 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -304,7 +304,7 @@ config PHY_STIH41X_USB
 
 config PHY_QCOM_UFS
 	tristate "Qualcomm UFS PHY driver"
-	depends on OF && ARCH_MSM
+	depends on OF && ARCH_QCOM
 	select GENERIC_PHY
 	help
 	  Support for UFS PHY on QCOM chipsets.
