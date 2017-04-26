From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Wed, 26 Apr 2017 17:25:52 +0800
Subject: [PATCH v2 08/30] arm: dts: mt7623: add pmic wrapper nodes to the
 mt7623 dtsi file
In-Reply-To: <1493198774-4478-1-git-send-email-sean.wang@mediatek.com>
References: <1493198774-4478-1-git-send-email-sean.wang@mediatek.com>
Message-ID: <1493198774-4478-9-git-send-email-sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: John Crispin <john@phrozen.org>

Add PMIC wrapper node to the mt7623.dtsi file which
is necessary for the control of PMIC from Mediatek.

Signed-off-by: John Crispin <john@phrozen.org>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 arch/arm/boot/dts/mt7623.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
index 1942bc7..6adc21d 100644
--- a/arch/arm/boot/dts/mt7623.dtsi
+++ b/arch/arm/boot/dts/mt7623.dtsi
@@ -158,6 +158,19 @@
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
1.9.1
