From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Wed, 26 Apr 2017 17:26:03 +0800
Subject: [PATCH v2 19/30] arm: dts: mt7623: add rng nodes to the mt7623.dtsi
 file
In-Reply-To: <1493198774-4478-1-git-send-email-sean.wang@mediatek.com>
References: <1493198774-4478-1-git-send-email-sean.wang@mediatek.com>
Message-ID: <1493198774-4478-20-git-send-email-sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Add rng  nodes to the mt7623.dtsi file.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 arch/arm/boot/dts/mt7623.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
index a2b6238..707f0e5 100644
--- a/arch/arm/boot/dts/mt7623.dtsi
+++ b/arch/arm/boot/dts/mt7623.dtsi
@@ -197,6 +197,13 @@
 		#clock-cells = <1>;
 	};
 
+	rng: rng at 1020f000 {
+		compatible = "mediatek,mt7623-rng";
+		reg = <0 0x1020f000 0 0x1000>;
+		clocks = <&infracfg CLK_INFRA_TRNG>;
+		clock-names = "rng";
+	};
+
 	gic: interrupt-controller at 10211000 {
 		compatible = "arm,cortex-a7-gic";
 		interrupt-controller;
-- 
1.9.1
