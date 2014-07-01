From: silvio.fricke@gmail.com (Silvio Fricke)
Date: Tue,  1 Jul 2014 13:08:59 +0200
Subject: [PATCH v2 2/5] ARM: dts: imx6: edmqmx6: Add PCIe support
In-Reply-To: <cover.1404212584.git.silvio.fricke@gmail.com>
References: <cover.1404212584.git.silvio.fricke@gmail.com>
Message-ID: <a8be8a24e5e5d76d8652010a6af6f532c478bdee.1404212584.git.silvio.fricke@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the PCI express bus available on MX6 Data Modul
edm-qmx6 board.

Signed-off-by: Silvio Fricke <silvio.fricke@gmail.com>
---
 arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts b/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
index e030263..f36dab0 100644
--- a/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
+++ b/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
@@ -323,6 +323,12 @@
 			>;
 		};
 
+		pinctrl_pcie: pciegrp {
+			fsl,pins = <
+				MX6QDL_PAD_KEY_COL1__GPIO4_IO08		0x100b1
+			>;
+		};
+
 		pinctrl_pfuze: pfuze100grp1 {
 			fsl,pins = <
 				MX6QDL_PAD_EIM_D20__GPIO3_IO20		0x80000000
@@ -385,6 +391,13 @@
 	};
 };
 
+&pcie {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pcie>;
+	reset-gpio = <&gpio4 8 0>;
+	status = "okay";
+};
+
 &sata {
 	status = "okay";
 };
-- 
2.0.0
