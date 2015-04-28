From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 28 Apr 2015 14:08:04 +0200
Subject: [PATCH 2/2] ARM: multi_v7_defconfig: Replace USB_RCAR_GEN2_PHY by
 PHY_RCAR_GEN2
In-Reply-To: <1430222884-2095-1-git-send-email-geert+renesas@glider.be>
References: <1430222884-2095-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1430222884-2095-2-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The legacy-only USB_RCAR_GEN2_PHY driver was replaced by the DT-only
PHY_RCAR_GEN2 driver.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Oops, CONFIG_USB_RCAR_GEN2_PHY shouldn't have been in a multiplatform
defconfig, as it supports legacy platform data only.

 arch/arm/configs/multi_v7_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 06e7e887fea550b3..2835ffda3bfed8ed 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -447,7 +447,6 @@ CONFIG_USB_GPIO_VBUS=y
 CONFIG_USB_ISP1301=y
 CONFIG_USB_MXS_PHY=y
 CONFIG_USB_RCAR_PHY=m
-CONFIG_USB_RCAR_GEN2_PHY=m
 CONFIG_USB_GADGET=y
 CONFIG_USB_RENESAS_USBHS_UDC=m
 CONFIG_MMC=y
@@ -561,6 +560,7 @@ CONFIG_OMAP_USB2=y
 CONFIG_TI_PIPE3=y
 CONFIG_PHY_MIPHY28LP=y
 CONFIG_PHY_MIPHY365X=y
+CONFIG_PHY_RCAR_GEN2=m
 CONFIG_PHY_STIH41X_USB=y
 CONFIG_PHY_STIH407_USB=y
 CONFIG_PHY_SUN4I_USB=y
-- 
1.9.1
