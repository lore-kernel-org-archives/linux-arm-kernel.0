From: xypron.glpk@gmx.de (Heinrich Schuchardt)
Date: Tue, 17 Apr 2018 22:56:23 +0200
Subject: [PATCH 1/1] arm: dts: rockchip: default serial for Tinker Board
Message-ID: <20180417205623.764-1-xypron.glpk@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Asus Tinker Board uses serial 2 with 115,200 baud by default for
communication in U-Boot. The same value is also chosen for other RK3288
boards.

So let us set the same value in the Tinker Board device tree.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
 arch/arm/boot/dts/rk3288-tinker.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-tinker.dts b/arch/arm/boot/dts/rk3288-tinker.dts
index 346b0d8b474d..127488f9f174 100644
--- a/arch/arm/boot/dts/rk3288-tinker.dts
+++ b/arch/arm/boot/dts/rk3288-tinker.dts
@@ -49,6 +49,10 @@
 	model = "Rockchip RK3288 Tinker Board";
 	compatible = "asus,rk3288-tinker", "rockchip,rk3288";
 
+	chosen {
+		stdout-path = "serial2:115200n8";
+	};
+
 	memory {
 		reg = <0x0 0x0 0x0 0x80000000>;
 		device_type = "memory";
-- 
2.17.0
