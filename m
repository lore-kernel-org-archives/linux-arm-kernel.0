From: enric.balletbo@collabora.com (Enric Balletbo i Serra)
Date: Mon,  9 Jul 2018 22:57:54 +0200
Subject: [PATCH] arm64: dts: rockchip: remove deprecated Type-C PHY properties
 on rk3399
Message-ID: <20180709205754.29132-1-enric.balletbo@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 0fbc47d9e426 ("phy: rockchip-typec: deprecate some DT properties
for various register fields.") deprecates some Rockchip Type-C
properties. As these are now not needed, remove from the device tree
file.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index e0040b648f43..180dd9d2cc23 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1446,10 +1446,6 @@
 			 <&cru SRST_P_UPHY0_TCPHY>;
 		reset-names = "uphy", "uphy-pipe", "uphy-tcphy";
 		rockchip,grf = <&grf>;
-		rockchip,typec-conn-dir = <0xe580 0 16>;
-		rockchip,usb3tousb2-en = <0xe580 3 19>;
-		rockchip,external-psm = <0xe588 14 30>;
-		rockchip,pipe-status = <0xe5c0 0 0>;
 		status = "disabled";
 
 		tcphy0_dp: dp-port {
@@ -1475,10 +1471,6 @@
 			 <&cru SRST_P_UPHY1_TCPHY>;
 		reset-names = "uphy", "uphy-pipe", "uphy-tcphy";
 		rockchip,grf = <&grf>;
-		rockchip,typec-conn-dir = <0xe58c 0 16>;
-		rockchip,usb3tousb2-en = <0xe58c 3 19>;
-		rockchip,external-psm = <0xe594 14 30>;
-		rockchip,pipe-status = <0xe5c0 16 16>;
 		status = "disabled";
 
 		tcphy1_dp: dp-port {
-- 
2.18.0
