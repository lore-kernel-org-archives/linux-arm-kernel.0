From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Mon, 12 May 2014 16:02:37 +0300
Subject: [PATCH] ARM: dts: keystone-evm: add spi nor flash support
Message-ID: <1399899757-15767-1-git-send-email-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Murali Karicheri <m-karicheri2@ti.com>

k2hk, k2e, k2l EVM board have the same Micron N25Q128A11
SPI NOR Flash installed on SPI0 bus.

The NOR Flash is splitted on two partistions:
partition at 0
	label = "u-boot-spl";
	reg = <0x0 0x80000>;
partition at 1
	label = "misc";
	reg = <0x80000 0xf80000>;

Hence, add SPI NOR Flash nodes to all k2hk, k2e, k2l EVM boards.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 arch/arm/boot/dts/k2e-evm.dts  |   22 ++++++++++++++++++++++
 arch/arm/boot/dts/k2hk-evm.dts |   22 ++++++++++++++++++++++
 arch/arm/boot/dts/k2l-evm.dts  |   22 ++++++++++++++++++++++
 3 files changed, 66 insertions(+)

diff --git a/arch/arm/boot/dts/k2e-evm.dts b/arch/arm/boot/dts/k2e-evm.dts
index fb7afab..c568f06 100644
--- a/arch/arm/boot/dts/k2e-evm.dts
+++ b/arch/arm/boot/dts/k2e-evm.dts
@@ -117,3 +117,25 @@
 		};
 	};
 };
+
+&spi0 {
+	nor_flash: n25q128a11 at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "Micron,n25q128a11";
+		spi-max-frequency = <54000000>;
+		m25p,fast-read;
+		reg = <0>;
+
+		partition at 0 {
+			label = "u-boot-spl";
+			reg = <0x0 0x80000>;
+			read-only;
+		};
+
+		partition at 1 {
+			label = "misc";
+			reg = <0x80000 0xf80000>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/k2hk-evm.dts b/arch/arm/boot/dts/k2hk-evm.dts
index d2aa102..1f90cbf 100644
--- a/arch/arm/boot/dts/k2hk-evm.dts
+++ b/arch/arm/boot/dts/k2hk-evm.dts
@@ -145,3 +145,25 @@
 		reg = <0x50>;
 	};
 };
+
+&spi0 {
+	nor_flash: n25q128a11 at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "Micron,n25q128a11";
+		spi-max-frequency = <54000000>;
+		m25p,fast-read;
+		reg = <0>;
+
+		partition at 0 {
+			label = "u-boot-spl";
+			reg = <0x0 0x80000>;
+			read-only;
+		};
+
+		partition at 1 {
+			label = "misc";
+			reg = <0x80000 0xf80000>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/k2l-evm.dts b/arch/arm/boot/dts/k2l-evm.dts
index 8ff2d33..fec4312 100644
--- a/arch/arm/boot/dts/k2l-evm.dts
+++ b/arch/arm/boot/dts/k2l-evm.dts
@@ -94,3 +94,25 @@
 		};
 	};
 };
+
+&spi0 {
+	nor_flash: n25q128a11 at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "Micron,n25q128a11";
+		spi-max-frequency = <54000000>;
+		m25p,fast-read;
+		reg = <0>;
+
+		partition at 0 {
+			label = "u-boot-spl";
+			reg = <0x0 0x80000>;
+			read-only;
+		};
+
+		partition at 1 {
+			label = "misc";
+			reg = <0x80000 0xf80000>;
+		};
+	};
+};
-- 
1.7.9.5
