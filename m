From: john@phrozen.org (John Crispin)
Date: Mon, 23 Jan 2017 12:29:25 +0100
Subject: [PATCH 06/16] arm: dts: add pmic nodes to the mt7623 dtsi file
In-Reply-To: <1485170975-51813-1-git-send-email-john@phrozen.org>
References: <1485170975-51813-1-git-send-email-john@phrozen.org>
Message-ID: <1485170975-51813-7-git-send-email-john@phrozen.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add PMIC node to the mt7623.dtsi file.

Signed-off-by: John Crispin <john@phrozen.org>
---
 arch/arm/boot/dts/mt7623.dtsi |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
index c64117b..6099f05 100644
--- a/arch/arm/boot/dts/mt7623.dtsi
+++ b/arch/arm/boot/dts/mt7623.dtsi
@@ -155,6 +155,19 @@
 		clock-names = "system-clk", "rtc-clk";
 	};
 
+	pwrap: pwrap at 1000d000 {
+		compatible = "mediatek,mt7623-pwrap",
+			     "mediatek,mt2701-pwrap";
+		reg = <0 0x1000d000 0 0x1000>;
+		reg-names = "pwrap";
+		interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
+		resets = <&infracfg MT2701_INFRA_PMIC_WRAP_RST>;
+		reset-names = "pwrap";
+		clocks = <&infracfg CLK_INFRA_PMICSPI>,
+			 <&infracfg CLK_INFRA_PMICWRAP>;
+		clock-names = "spi", "wrap";
+	};
+
 	sysirq: interrupt-controller at 10200100 {
 		compatible = "mediatek,mt7623-sysirq",
 			     "mediatek,mt6577-sysirq";
-- 
1.7.10.4
