From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 27 Jul 2015 11:48:15 +0200
Subject: [PATCH 7/7] ARM64: zynqmp: Add eeprom memories on i2c bus
In-Reply-To: <48a75b64b05dc094e34fe27e5d03552dbfe77fe2.1437990464.git.michal.simek@xilinx.com>
References: <48a75b64b05dc094e34fe27e5d03552dbfe77fe2.1437990464.git.michal.simek@xilinx.com>
Message-ID: <84f7d2137afdc5581c1d5d9b27feb2c5e5592308.1437990464.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add i2c eeprom memories on i2c bus.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts b/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts
index 206e18eca2fb..47debdcbefbf 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts
@@ -36,6 +36,24 @@
 	status = "okay";
 };
 
+&i2c0 {
+	status = "okay";
+	clock-frequency = <100000>;
+	eeprom at 54 {
+		compatible = "at,24c64";
+		reg = <0x54>;
+	};
+};
+
+&i2c1 {
+	status = "okay";
+	clock-frequency = <100000>;
+	eeprom at 55 {
+		compatible = "at,24c64";
+		reg = <0x55>;
+	};
+};
+
 &gem0 {
 	status = "okay";
 	phy-handle = <&phy0>;
-- 
2.3.5
