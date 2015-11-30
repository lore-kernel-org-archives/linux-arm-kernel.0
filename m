From: vigneshr@ti.com (Vignesh R)
Date: Mon, 30 Nov 2015 10:45:15 +0530
Subject: [PATCH v4 5/5] ARM: dts: AM4372: add entry for qspi mmap region
In-Reply-To: <1448860515-28336-1-git-send-email-vigneshr@ti.com>
References: <1448860515-28336-1-git-send-email-vigneshr@ti.com>
Message-ID: <1448860515-28336-6-git-send-email-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add qspi memory mapped region entries for AM43xx based SoCs. Also,
update the binding documents for the controller to document this change.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Vignesh R <vigneshr@ti.com>
---

v4: No changes.

 Documentation/devicetree/bindings/spi/ti_qspi.txt | 5 +++--
 arch/arm/boot/dts/am4372.dtsi                     | 4 +++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/ti_qspi.txt b/Documentation/devicetree/bindings/spi/ti_qspi.txt
index 334aa3f32cbc..5a1542eda387 100644
--- a/Documentation/devicetree/bindings/spi/ti_qspi.txt
+++ b/Documentation/devicetree/bindings/spi/ti_qspi.txt
@@ -17,9 +17,10 @@ Recommended properties:
 
 Example:
 
+For am4372:
 qspi: qspi at 4b300000 {
-	compatible = "ti,dra7xxx-qspi";
-	reg = <0x47900000 0x100>, <0x30000000 0x3ffffff>;
+	compatible = "ti,am4372-qspi";
+	reg = <0x47900000 0x100>, <0x30000000 0x4000000>;
 	reg-names = "qspi_base", "qspi_mmap";
 	#address-cells = <1>;
 	#size-cells = <0>;
diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index d83ff9c9701e..e32d164102d1 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -963,7 +963,9 @@
 
 		qspi: qspi at 47900000 {
 			compatible = "ti,am4372-qspi";
-			reg = <0x47900000 0x100>;
+			reg = <0x47900000 0x100>,
+			      <0x30000000 0x4000000>;
+			reg-names = "qspi_base", "qspi_mmap";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "qspi";
-- 
2.6.3
