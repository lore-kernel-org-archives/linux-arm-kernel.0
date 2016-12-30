From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 30 Dec 2016 13:37:20 +0530
Subject: [PATCH] ARM: dts: am572x-idk: Add gpios property to control
 PCIE_RESETn
Message-ID: <1483085240-16102-1-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add 'gpios' property to pcie1 dt node and populate it with
GPIO3_23 in order to drive PCIE_RESETn high.

This gets PCIe cards to be detected in AM572X IDK board.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/am572x-idk.dts |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/am572x-idk.dts b/arch/arm/boot/dts/am572x-idk.dts
index 27d9149..1540f7a 100644
--- a/arch/arm/boot/dts/am572x-idk.dts
+++ b/arch/arm/boot/dts/am572x-idk.dts
@@ -87,3 +87,7 @@
 &sn65hvs882 {
 	load-gpios = <&gpio3 19 GPIO_ACTIVE_LOW>;
 };
+
+&pcie1 {
+	gpios = <&gpio3 23 GPIO_ACTIVE_HIGH>;
+};
-- 
1.7.9.5
