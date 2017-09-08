From: fcooper@ti.com (Franklin S Cooper Jr)
Date: Fri, 8 Sep 2017 13:41:32 -0500
Subject: [PATCH v2 2/2] ARM: dts: k2g-evm: Enable USB 0 and 1
In-Reply-To: <20170908184132.6155-1-fcooper@ti.com>
References: <20170908184132.6155-1-fcooper@ti.com>
Message-ID: <20170908184132.6155-3-fcooper@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Roger Quadros <rogerq@ti.com>

Enable USB 0 which will be used as a host port and USB 1 which will be
used in peripheral mode.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
---
 arch/arm/boot/dts/keystone-k2g-evm.dts | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/keystone-k2g-evm.dts b/arch/arm/boot/dts/keystone-k2g-evm.dts
index 61883cb..4f56295 100644
--- a/arch/arm/boot/dts/keystone-k2g-evm.dts
+++ b/arch/arm/boot/dts/keystone-k2g-evm.dts
@@ -41,3 +41,29 @@
 	pinctrl-0 = <&uart0_pins>;
 	status = "okay";
 };
+
+&keystone_usb0 {
+	status = "okay";
+};
+
+&usb0_phy {
+	status = "okay";
+};
+
+&usb0 {
+	dr_mode = "host";
+	status = "okay";
+};
+
+&keystone_usb1 {
+	status = "okay";
+};
+
+&usb1_phy {
+	status = "okay";
+};
+
+&usb1 {
+	dr_mode = "peripheral";
+	status = "okay";
+};
-- 
2.9.4.dirty
