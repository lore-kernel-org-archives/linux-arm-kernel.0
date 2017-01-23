From: john@phrozen.org (John Crispin)
Date: Mon, 23 Jan 2017 12:29:21 +0100
Subject: [PATCH 02/16] arm: dts: add subsystem clock controller device nodes
In-Reply-To: <1485170975-51813-1-git-send-email-john@phrozen.org>
References: <1485170975-51813-1-git-send-email-john@phrozen.org>
Message-ID: <1485170975-51813-3-git-send-email-john@phrozen.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add MT7623 subsystem clock controllers for hifsys amd ethsys.

Signed-off-by: John Crispin <john@phrozen.org>
---
 arch/arm/boot/dts/mt7623.dtsi |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
index 592fc0a..87a55f5 100644
--- a/arch/arm/boot/dts/mt7623.dtsi
+++ b/arch/arm/boot/dts/mt7623.dtsi
@@ -186,4 +186,20 @@
 		clock-names = "baud", "bus";
 		status = "disabled";
 	};
+
+	hifsys: syscon at 1a000000 {
+		compatible = "mediatek,mt7623-hifsys",
+			     "mediatek,mt2701-hifsys",
+			     "syscon";
+		reg = <0 0x1a000000 0 0x1000>;
+		#clock-cells = <1>;
+	};
+
+	ethsys: syscon at 1b000000 {
+		compatible = "mediatek,mt7623-ethsys",
+			     "mediatek,mt2701-ethsys",
+			     "syscon";
+		reg = <0 0x1b000000 0 0x1000>;
+		#clock-cells = <1>;
+	};
 };
-- 
1.7.10.4
