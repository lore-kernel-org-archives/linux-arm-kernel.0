From: heiko@sntech.de (Heiko Stuebner)
Date: Mon,  3 Apr 2017 12:22:12 +0200
Subject: [PATCH] multi_v7_defconfig: make Rockchip usb2-phy built-in
Message-ID: <20170403102212.6802-1-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The phy is necessary for the dwc2 controllers driving the usb ports
on all arm32 Rockchip socs. Both the dwc2 as well as usb downstream
drivers (mass-storage as well as usb networking) are already built-in,
so only the phy is missing to allow booting from usb-devices without
to much hassle.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
Ideally to be applied directly to some armsoc defconfig branch.

 arch/arm/configs/multi_v7_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index d160b1b6c677..d8812f870d23 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -884,7 +884,7 @@ CONFIG_TI_PIPE3=y
 CONFIG_PHY_BERLIN_USB=y
 CONFIG_PHY_BERLIN_SATA=y
 CONFIG_PHY_ROCKCHIP_DP=m
-CONFIG_PHY_ROCKCHIP_USB=m
+CONFIG_PHY_ROCKCHIP_USB=y
 CONFIG_PHY_QCOM_APQ8064_SATA=m
 CONFIG_PHY_MIPHY28LP=y
 CONFIG_PHY_RCAR_GEN2=m
-- 
2.11.0
