From: woogyom.kim@gmail.com (Milo Kim)
Date: Mon,  5 Dec 2016 11:00:31 +0900
Subject: [PATCH 1/2] ARM: dts: sun8i: Specify memblock for Nano Pi M1
Message-ID: <20161205020032.26586-1-woogyom.kim@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The board has DDR3 512MB. This patch helps scanning the memory and
adding memblock through the DT.

Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
---
 arch/arm/boot/dts/sun8i-h3-nanopi-m1.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi-m1.dts b/arch/arm/boot/dts/sun8i-h3-nanopi-m1.dts
index ec63d10..be3668f 100644
--- a/arch/arm/boot/dts/sun8i-h3-nanopi-m1.dts
+++ b/arch/arm/boot/dts/sun8i-h3-nanopi-m1.dts
@@ -45,6 +45,11 @@
 / {
 	model = "FriendlyArm NanoPi M1";
 	compatible = "friendlyarm,nanopi-m1", "allwinner,sun8i-h3";
+
+	memory at 40000000 {
+		device_type = "memory";
+		reg = <0x40000000 0x20000000>;
+	};
 };
 
 &ehci1 {
-- 
2.9.3
