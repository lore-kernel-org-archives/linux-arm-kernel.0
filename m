From: anup.patel@broadcom.com (Anup Patel)
Date: Mon, 22 May 2017 17:28:22 +0530
Subject: [PATCH v4 06/11] arm64: dts: Add NAND DT nodes for Stingray SOC
In-Reply-To: <1495454307-23464-1-git-send-email-anup.patel@broadcom.com>
References: <1495454307-23464-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1495454307-23464-7-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Pramod Kumar <pramod.kumar@broadcom.com>

This patch adds NAND controller DT Node and NAND chip DT
node for Stingray SOC and Stingray reference boards.

Signed-off-by: Pramod Kumar <pramod.kumar@broadcom.com>
Signed-off-by: Abhishek Shah <abhishek.shah@broadcom.com>
Reviewed-by: Vikram Prakash <vikram.prakash@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
---
 arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi | 15 +++++++++++++++
 arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi       | 13 +++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi b/arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi
index 992944b..aad45a2 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi
@@ -53,3 +53,18 @@
 &uart1 {
 	status = "okay";
 };
+
+&nand {
+	status = "ok";
+	nandcs at 0 {
+		compatible = "brcm,nandcs";
+		reg = <0>;
+		nand-ecc-mode = "hw";
+		nand-ecc-strength = <8>;
+		nand-ecc-step-size = <512>;
+		nand-bus-width = <16>;
+		brcm,nand-oob-sector-size = <16>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+	};
+};
diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
index 6b690db..003f814 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
@@ -307,5 +307,18 @@
 			compatible = "brcm,iproc-rng200";
 			reg = <0x00220000 0x28>;
 		};
+
+		nand: nand at 68c60000 {
+			compatible = "brcm,nand-iproc", "brcm,brcmnand-v6.1";
+			reg = <0x00360000 0x600>,
+			      <0x0050a408 0x600>,
+			      <0x00360f00 0x20>;
+			reg-names = "nand", "iproc-idm", "iproc-ext";
+			interrupts = <GIC_SPI 203 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			brcm,nand-has-wp;
+			status = "disabled";
+		};
 	};
 };
-- 
2.7.4
