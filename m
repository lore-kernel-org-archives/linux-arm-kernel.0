From: govinds@codeaurora.org (Govind Singh)
Date: Mon, 26 Nov 2018 19:51:33 +0530
Subject: [PATCH] arm64: dts: qcom: qcs404: Add WCN3990 WLAN module device node
Message-ID: <20181126142133.16966-1-govinds@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device node for the ath10k SNOC platform driver probe
and add resources required for WCN3990 on qcs404 soc.
Optional clock and regulator controls are not yet available in
upstream, hence add them once available.

Signed-off-by: Govind Singh <govinds@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index 9ca4f061ecc5..1a401a32d4a1 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -958,6 +958,25 @@
 				status = "disabled";
 			};
 		};
+
+		wifi: wifi at 0A000000 {
+			compatible = "qcom,wcn3990-wifi";
+			reg = <0x0A000000 0x800000>;
+			reg-names = "membase";
+			memory-region = <&wlan_msa_mem>;
+			interrupts = <GIC_SPI 277 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 278 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 279 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 280 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 281 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 284 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 285 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 288 IRQ_TYPE_LEVEL_HIGH>;
+		};
 	};
 
 	timer {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
