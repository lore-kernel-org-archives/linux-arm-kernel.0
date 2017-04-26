From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Wed, 26 Apr 2017 17:25:48 +0800
Subject: [PATCH v2 04/30] arm: dts: mt7623: add subsystem clock controller
 device nodes
In-Reply-To: <1493198774-4478-1-git-send-email-sean.wang@mediatek.com>
References: <1493198774-4478-1-git-send-email-sean.wang@mediatek.com>
Message-ID: <1493198774-4478-5-git-send-email-sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: John Crispin <john@phrozen.org>

Add MT7623 subsystem clock controllers for hifsys and ethsys.

Signed-off-by: John Crispin <john@phrozen.org>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 arch/arm/boot/dts/mt7623.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
index b97b2ba..54cff6a 100644
--- a/arch/arm/boot/dts/mt7623.dtsi
+++ b/arch/arm/boot/dts/mt7623.dtsi
@@ -190,4 +190,20 @@
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
1.9.1
