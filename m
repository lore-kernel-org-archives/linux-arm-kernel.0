From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Wed, 14 Dec 2016 14:27:03 +0530
Subject: [PATCH] ARM: dts: dra72-evm-tps65917: Add voltage supplies to usb_phy, mmc,
 dss
Message-ID: <20161214085703.506-1-lokeshvutla@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 5d080aa30681 ("ARM: dts: dra72: Add separate dtsi for tps65917")
added a separate dtsi for dra72-evm-tps65917 moving all the voltage supplies
to this file. But it missed adding voltage supplies to usb_phy, mmc,
dss and deleted from dra72-evm-common.dtsi. Adding the voltage supply
phandles to these nodes in dra72-evm-tps65917.dtsi

Fixes: 5d080aa30681 ("ARM: dts: dra72: Add separate dtsi for tps65917")
Reported-by: Carlos Hernandez <ceh@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
Logs:
- DRA72-evm revC: http://pastebin.ubuntu.com/23627665/ 
- DRA72-evm revB: http://pastebin.ubuntu.com/23627658/
 arch/arm/boot/dts/dra72-evm-tps65917.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/dra72-evm-tps65917.dtsi b/arch/arm/boot/dts/dra72-evm-tps65917.dtsi
index ee6dac44edf1..e6df676886c0 100644
--- a/arch/arm/boot/dts/dra72-evm-tps65917.dtsi
+++ b/arch/arm/boot/dts/dra72-evm-tps65917.dtsi
@@ -132,3 +132,19 @@
 		ti,palmas-long-press-seconds = <6>;
 	};
 };
+
+&usb2_phy1 {
+	phy-supply = <&ldo4_reg>;
+};
+
+&usb2_phy2 {
+	phy-supply = <&ldo4_reg>;
+};
+
+&dss {
+	vdda_video-supply = <&ldo5_reg>;
+};
+
+&mmc1 {
+	vmmc_aux-supply = <&ldo1_reg>;
+};
-- 
2.11.0
