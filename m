From: anup.patel@broadcom.com (Anup Patel)
Date: Fri, 2 Oct 2015 23:24:23 +0530
Subject: [PATCH 6/6] arm64: dts: Add I2C nodes for NS2
In-Reply-To: <1443808463-21120-1-git-send-email-anup.patel@broadcom.com>
References: <1443808463-21120-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1443808463-21120-7-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ray Jui <rjui@broadcom.com>

This patch adds iProc I2C DT nodes for NS2 and enable them for the NS2
SVK board

Signed-off-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Vikram Prakash <vikramp@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
---
 arch/arm64/boot/dts/broadcom/ns2-svk.dts |  8 ++++++++
 arch/arm64/boot/dts/broadcom/ns2.dtsi    | 20 ++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/ns2-svk.dts b/arch/arm64/boot/dts/broadcom/ns2-svk.dts
index 244baf8..e5950d5 100644
--- a/arch/arm64/boot/dts/broadcom/ns2-svk.dts
+++ b/arch/arm64/boot/dts/broadcom/ns2-svk.dts
@@ -52,6 +52,14 @@
 	};
 
 	soc: soc {
+		i2c0: i2c at 66080000 {
+			status = "ok";
+		};
+
+		i2c1: i2c at 660b0000 {
+			status = "ok";
+		};
+
 		uart3: serial at 66130000 {
 			status = "ok";
 		};
diff --git a/arch/arm64/boot/dts/broadcom/ns2.dtsi b/arch/arm64/boot/dts/broadcom/ns2.dtsi
index 92ecf1c..f603277 100644
--- a/arch/arm64/boot/dts/broadcom/ns2.dtsi
+++ b/arch/arm64/boot/dts/broadcom/ns2.dtsi
@@ -178,6 +178,26 @@
 			      <0x65260000 0x1000>;
 		};
 
+		i2c0: i2c at 66080000 {
+			compatible = "brcm,iproc-i2c";
+			reg = <0x66080000 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <GIC_SPI 394 IRQ_TYPE_NONE>;
+			clock-frequency = <100000>;
+			status = "disabled";
+		};
+
+		i2c1: i2c at 660b0000 {
+			compatible = "brcm,iproc-i2c";
+			reg = <0x660b0000 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <GIC_SPI 395 IRQ_TYPE_NONE>;
+			clock-frequency = <100000>;
+			status = "disabled";
+		};
+
 		uart3: serial at 66130000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x66130000 0x100>;
-- 
1.9.1
