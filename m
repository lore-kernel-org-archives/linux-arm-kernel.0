From: rogerq@ti.com (Roger Quadros)
Date: Tue, 21 Oct 2014 13:41:20 +0300
Subject: [PATCH 4/4] ARM: dts: dra72-evm: Add regulator information to USB2
 PHYs
In-Reply-To: <1413888080-2669-1-git-send-email-rogerq@ti.com>
References: <1413888080-2669-1-git-send-email-rogerq@ti.com>
Message-ID: <1413888080-2669-5-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ldo4_reg regulator provides power to the USB1 and USB2
High Speed PHYs.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/dra72-evm.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/dra72-evm.dts b/arch/arm/boot/dts/dra72-evm.dts
index ad6ec4a..b135aab 100644
--- a/arch/arm/boot/dts/dra72-evm.dts
+++ b/arch/arm/boot/dts/dra72-evm.dts
@@ -270,6 +270,14 @@
 	};
 };
 
+&usb2_phy1 {
+	phy-supply = <&ldo4_reg>;
+};
+
+&usb2_phy2 {
+	phy-supply = <&ldo4_reg>;
+};
+
 &usb1 {
 	dr_mode = "peripheral";
 	pinctrl-names = "default";
-- 
1.8.3.2
