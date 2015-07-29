From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 29 Jul 2015 16:19:34 +0200
Subject: [PATCH v2] ARM64: zynqmp: Add eeprom memories on i2c bus
Message-ID: <827fe968a448dd25e133ce3509d91fd2482bd850.1438179569.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add i2c eeprom memories on i2c bus.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2:
- Change eeprom max freq from 100k to 400k

---
 arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts b/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts
index c5cc8dbd0968..3b1011169756 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts
@@ -50,6 +50,24 @@
 	status = "okay";
 };
 
+&i2c0 {
+	status = "okay";
+	clock-frequency = <400000>;
+	eeprom at 54 {
+		compatible = "at,24c64";
+		reg = <0x54>;
+	};
+};
+
+&i2c1 {
+	status = "okay";
+	clock-frequency = <400000>;
+	eeprom at 55 {
+		compatible = "at,24c64";
+		reg = <0x55>;
+	};
+};
+
 &sata {
 	status = "okay";
 	ceva,broken-gen2;
-- 
2.3.5
