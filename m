From: vigneshr@ti.com (Vignesh R)
Date: Fri, 4 Sep 2015 14:00:01 +0530
Subject: [PATCH 4/5] ARM: dts: DRA7: add entry for qspi mmap region
In-Reply-To: <1441355402-6837-1-git-send-email-vigneshr@ti.com>
References: <1441355402-6837-1-git-send-email-vigneshr@ti.com>
Message-ID: <1441355402-6837-5-git-send-email-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add qspi memory mapped region entries for DRA7xx based SoCs. Also,
update the binding documents for the controller to document this change.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 Documentation/devicetree/bindings/spi/ti_qspi.txt | 13 +++++++++++++
 arch/arm/boot/dts/dra7.dtsi                       |  6 ++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/ti_qspi.txt b/Documentation/devicetree/bindings/spi/ti_qspi.txt
index 601a360531a5..f05dd631bef1 100644
--- a/Documentation/devicetree/bindings/spi/ti_qspi.txt
+++ b/Documentation/devicetree/bindings/spi/ti_qspi.txt
@@ -26,3 +26,16 @@ qspi: qspi at 4b300000 {
 	spi-max-frequency = <25000000>;
 	ti,hwmods = "qspi";
 };
+
+For dra7xx:
+qspi: qspi at 4b300000 {
+	compatible = "ti,dra7xxx-qspi";
+	reg = <0x4b300000 0x100>, <0x4a002558 0x4>,
+	      <0x5c000000 0x4000000>;
+	reg-names = "qspi_base", "qspi_ctrlmod",
+		    "qspi_mmap";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	spi-max-frequency = <48000000>;
+	ti,hwmods = "qspi";
+};
diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 1e29ccf77ea2..f6798d6ecd60 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1103,8 +1103,10 @@
 
 		qspi: qspi at 4b300000 {
 			compatible = "ti,dra7xxx-qspi";
-			reg = <0x4b300000 0x100>;
-			reg-names = "qspi_base";
+			reg = <0x4b300000 0x100>, <0x4a002558 0x4>,
+			      <0x5c000000 0x4000000>;
+			reg-names = "qspi_base", "qspi_ctrlmod",
+				    "qspi_mmap";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "qspi";
-- 
2.5.1
