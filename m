From: iwamatsu@nigauri.org (Nobuhiro Iwamatsu)
Date: Fri, 23 Nov 2012 06:58:34 +0900
Subject: [PATCH] ARM: kirkwood: Add support DT of second I2C bus
Message-ID: <1353621514-38476-1-git-send-email-iwamatsu@nigauri.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Second I2C bus is supported by 88f6282 and 88f6283.
This creates kirkwood-6282.dtsi, and defines DT table
of second I2C bus.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
---
 arch/arm/boot/dts/kirkwood-6282.dtsi |   14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 arch/arm/boot/dts/kirkwood-6282.dtsi

diff --git a/arch/arm/boot/dts/kirkwood-6282.dtsi b/arch/arm/boot/dts/kirkwood-6282.dtsi
new file mode 100644
index 0000000..fa4d57a
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-6282.dtsi
@@ -0,0 +1,14 @@
+/ {
+	ocp at f1000000 {
+
+		i2c at 11100 {
+			compatible = "marvell,mv64xxx-i2c";
+			reg = <0x11100 0x20>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <32>;
+			clock-frequency = <100000>;
+			status = "disabled";
+		};
+	};
+};
-- 
1.7.10.4
