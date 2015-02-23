From: rogerq@ti.com (Roger Quadros)
Date: Mon, 23 Feb 2015 17:18:37 +0200
Subject: [PATCH 2/2] ARM: omap2plus_defconfig: Fix SATA boot
In-Reply-To: <1424704717-29728-1-git-send-email-rogerq@ti.com>
References: <1424704717-29728-1-git-send-email-rogerq@ti.com>
Message-ID: <1424704717-29728-3-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SATA operation depends on PIPE3 PHY and if we want
to boot from SATA drives, we have to have the PIPE3 PHY
driver built-in.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/configs/omap2plus_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index b674245..088096f 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -375,7 +375,7 @@ CONFIG_PWM_TIEHRPWM=m
 CONFIG_PWM_TWL=m
 CONFIG_PWM_TWL_LED=m
 CONFIG_OMAP_USB2=m
-CONFIG_TI_PIPE3=m
+CONFIG_TI_PIPE3=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 # CONFIG_EXT3_FS_XATTR is not set
-- 
2.1.0
