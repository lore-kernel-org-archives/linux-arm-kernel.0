From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Thu, 24 Sep 2015 13:39:18 +0200
Subject: [PATCH v2 4/5] ARM: multi_v7_defconfig: Enable the Rockchip USB 2.0
 phy
In-Reply-To: <1443094759-28531-1-git-send-email-sjoerd.simons@collabora.co.uk>
References: <1443094759-28531-1-git-send-email-sjoerd.simons@collabora.co.uk>
Message-ID: <1443094759-28531-5-git-send-email-sjoerd.simons@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most Rockchip SoCs have a DesignWare HS OTG USB 2.0 controller, enable
the driver for the Rockchip USB 2.0 PHY to make that functional.

Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>

---

Changes in v2:
- Only enable the USB 2 phy, not the controller as that came in through
  another tree
- Enable USB 2.0 phy as a module as the controller is a module as well

 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 660e72a..2ce0d63 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -662,6 +662,7 @@ CONFIG_PHY_HIX5HD2_SATA=y
 CONFIG_PWM_STI=m
 CONFIG_OMAP_USB2=y
 CONFIG_TI_PIPE3=y
+CONFIG_PHY_ROCKCHIP_USB=m
 CONFIG_PHY_MIPHY28LP=y
 CONFIG_PHY_MIPHY365X=y
 CONFIG_PHY_RCAR_GEN2=m
-- 
2.5.3
