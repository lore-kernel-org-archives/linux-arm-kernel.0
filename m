From: john@phrozen.org (John Crispin)
Date: Mon, 23 Jan 2017 12:29:27 +0100
Subject: [PATCH 08/16] arm: dts: add spi nodes to the mt7623.dtsi file
In-Reply-To: <1485170975-51813-1-git-send-email-john@phrozen.org>
References: <1485170975-51813-1-git-send-email-john@phrozen.org>
Message-ID: <1485170975-51813-9-git-send-email-john@phrozen.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add SPI nodes to the mt7623.dtsi file.

Signed-off-by: John Crispin <john@phrozen.org>
---
 arch/arm/boot/dts/mt7623.dtsi |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
index 8ac4569..c8f38e1 100644
--- a/arch/arm/boot/dts/mt7623.dtsi
+++ b/arch/arm/boot/dts/mt7623.dtsi
@@ -15,6 +15,7 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/mt2701-clk.h>
+#include <dt-bindings/phy/phy.h>
 #include <dt-bindings/pinctrl/mt7623-pinfunc.h>
 #include <dt-bindings/power/mt2701-power.h>
 #include <dt-bindings/reset/mt2701-resets.h>
@@ -281,6 +282,17 @@
 		status = "disabled";
 	};
 
+	spi: spi at 1100a000 {
+		compatible = "mediatek,mt7623-spi",
+			     "mediatek,mt6589-spi";
+		reg = <0 0x1100a000 0 0x1000>;
+		interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&pericfg CLK_PERI_SPI0>;
+		clock-names = "main";
+
+		status = "disabled";
+	};
+
 	hifsys: syscon at 1a000000 {
 		compatible = "mediatek,mt7623-hifsys",
 			     "mediatek,mt2701-hifsys",
-- 
1.7.10.4
