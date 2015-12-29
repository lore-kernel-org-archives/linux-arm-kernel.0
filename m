From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 29 Dec 2015 11:34:41 +0100
Subject: [PATCH] ARM: multi_v7_defconfig: MFD_DA9063 is boolean, not tristate
Message-ID: <1451385281-21210-1-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

The MFD_DA9063 Kconfig symbol is a boolean, not tristate, and therefore
m is not a valid value.

Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Note that the driver builds fine as a module, but I suspect that there
was some other reason for making it boolean only.

 arch/arm/configs/multi_v7_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 3a4dafdf3b60..96c8a4c2ebcd 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -430,7 +430,7 @@ CONFIG_MFD_AXP20X_RSB=m
 CONFIG_MFD_CROS_EC=m
 CONFIG_MFD_CROS_EC_I2C=m
 CONFIG_MFD_CROS_EC_SPI=m
-CONFIG_MFD_DA9063=m
+CONFIG_MFD_DA9063=y
 CONFIG_MFD_MAX14577=y
 CONFIG_MFD_MAX77686=y
 CONFIG_MFD_MAX77693=y
-- 
2.5.0
