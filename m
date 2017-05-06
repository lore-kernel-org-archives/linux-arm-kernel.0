From: anup.patel@broadcom.com (Anup Patel)
Date: Sat,  6 May 2017 17:24:41 +0530
Subject: [PATCH 06/11] arm64: dts: Add NAND DT nodes for Stingray SOC
In-Reply-To: <1494071686-19098-1-git-send-email-anup.patel@broadcom.com>
References: <1494071686-19098-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1494071686-19098-7-git-send-email-anup.patel@broadcom.com>
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
index e3a2a36..6014525 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi
@@ -62,3 +62,18 @@
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
index c60de96..dbdafcb 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
@@ -305,5 +305,18 @@
 			compatible = "brcm,iproc-rng200";
 			reg = <0x68b20000 0x28>;
 		};
+
+		nand: nand at 68c60000 {
+			compatible = "brcm,nand-iproc", "brcm,brcmnand-v6.1";
+			reg = <0x68c60000 0x600>,
+			      <0x68e0a408 0x600>,
+			      <0x68c60f00 0x20>;
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
