From: briannorris@chromium.org (Brian Norris)
Date: Fri, 13 May 2016 15:12:02 -0700
Subject: [PATCH v4 1/3] ARM64: dts: rockchip: make rk3399's grf a "simple-mfd"
Message-ID: <1463177524-113856-1-git-send-email-briannorris@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Per the examples in
Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt, we need the
grf node to be a simple-mfd in order to properly enumerate child devices
like our eMMC PHY.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
v4:

 * New, split out of patch 2, per Heiko's recommendation

 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 46f325a143b0..e1c3667a9bea 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -481,8 +481,11 @@
 	};
 
 	grf: syscon at ff770000 {
-		compatible = "rockchip,rk3399-grf", "syscon";
+		compatible = "rockchip,rk3399-grf", "syscon", "simple-mfd";
 		reg = <0x0 0xff770000 0x0 0x10000>;
+
+		#address-cells = <1>;
+		#size-cells = <1>;
 	};
 
 	watchdog at ff840000 {
-- 
2.8.0.rc3.226.g39d4020
