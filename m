From: vigneshr@ti.com (Vignesh R)
Date: Mon, 30 Nov 2015 10:45:14 +0530
Subject: [PATCH v4 4/5] ARM: dts: DRA7: add entry for qspi mmap region
In-Reply-To: <1448860515-28336-1-git-send-email-vigneshr@ti.com>
References: <1448860515-28336-1-git-send-email-vigneshr@ti.com>
Message-ID: <1448860515-28336-5-git-send-email-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add qspi memory mapped region entries for DRA7xx based SoCs. Also,
update the binding documents for the controller to document this change.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Vignesh R <vigneshr@ti.com>
---

v4: No changes.

 Documentation/devicetree/bindings/spi/ti_qspi.txt | 14 ++++++++++++++
 arch/arm/boot/dts/dra7.dtsi                       |  7 +++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/ti_qspi.txt b/Documentation/devicetree/bindings/spi/ti_qspi.txt
index 601a360531a5..334aa3f32cbc 100644
--- a/Documentation/devicetree/bindings/spi/ti_qspi.txt
+++ b/Documentation/devicetree/bindings/spi/ti_qspi.txt
@@ -26,3 +26,17 @@ qspi: qspi at 4b300000 {
 	spi-max-frequency = <25000000>;
 	ti,hwmods = "qspi";
 };
+
+For dra7xx:
+qspi: qspi at 4b300000 {
+	compatible = "ti,dra7xxx-qspi";
+	reg = <0x4b300000 0x100>,
+	      <0x5c000000 0x4000000>,
+	      <0x4a002558 0x4>;
+	reg-names = "qspi_base", "qspi_mmap",
+		    "qspi_ctrlmod";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	spi-max-frequency = <48000000>;
+	ti,hwmods = "qspi";
+};
diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index fe99231cbde5..debe7523643d 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1153,8 +1153,11 @@
 
 		qspi: qspi at 4b300000 {
 			compatible = "ti,dra7xxx-qspi";
-			reg = <0x4b300000 0x100>;
-			reg-names = "qspi_base";
+			reg = <0x4b300000 0x100>,
+			      <0x5c000000 0x4000000>,
+			      <0x4a002558 0x4>;
+			reg-names = "qspi_base", "qspi_mmap",
+				    "qspi_ctrlmod";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "qspi";
-- 
2.6.3
