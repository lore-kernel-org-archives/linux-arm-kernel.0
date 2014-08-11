From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 11 Aug 2014 11:45:35 +0900
Subject: [PATCH 1/5] ARM: shmobile: r8a7740: Add CMT1 device to DT
In-Reply-To: <1407725139-16156-1-git-send-email-horms+renesas@verge.net.au>
References: <1407725139-16156-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1407725139-16156-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the CMT0 counters to the r8a7740 device tree and make it
disabled by default.

Based on work by Magnus Damm.

Cc: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7740.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index 6cd6a46..1067a96 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -41,6 +41,18 @@
 		interrupts = <0 83 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
+	cmt1: timer at e6138000 {
+		compatible = "renesas,cmt-48";
+		reg = <0xe6138000 0x170>;
+		interrupts = <0 58 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7740_CLK_CMT1>;
+		clock-names = "fck";
+
+		renesas,channels-mask = <0x3f>;
+
+		status = "disabled";
+	};
+
 	/* irqpin0: IRQ0 - IRQ7 */
 	irqpin0: irqpin at e6900000 {
 		compatible = "renesas,intc-irqpin-r8a7740", "renesas,intc-irqpin";
-- 
2.0.1
