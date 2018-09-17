From: biao.huang@mediatek.com (Biao Huang)
Date: Mon, 17 Sep 2018 14:29:22 +0800
Subject: [PATCH 1/2] dt-binding: mediatek: Add binding document for MediaTek
 GMAC
In-Reply-To: <1537165763-13112-1-git-send-email-biao.huang@mediatek.com>
References: <1537165763-13112-1-git-send-email-biao.huang@mediatek.com>
Message-ID: <1537165763-13112-2-git-send-email-biao.huang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The commit adds the device tree binding documentation for the MediaTek
GMAC found on Mediatek MT2712.

Signed-off-by: Biao Huang <biao.huang@mediatek.com>
---
 .../devicetree/bindings/net/mediatek-gmac.txt      |   45 ++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/mediatek-gmac.txt

diff --git a/Documentation/devicetree/bindings/net/mediatek-gmac.txt b/Documentation/devicetree/bindings/net/mediatek-gmac.txt
new file mode 100644
index 0000000..14876ed
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/mediatek-gmac.txt
@@ -0,0 +1,45 @@
+MediaTek Gigabit Ethernet controller
+=========================================
+
+The gigabit ethernet controller can be found on MediaTek SoCs.
+
+* Ethernet controller node
+
+Required properties:
+- compatible: Should be
+	"mediatek,mt2712-eth": for MT2712 SoC
+- reg: Address and length of the register set for the device
+- interrupts: Should contain the MAC interrupts
+- interrupt-names: the name of interrupt in the interrupts property. These are
+	"macirq": For MT2712 SoC
+- clocks: the clock used by the controller
+- clock-names: the names of the clock listed in the clocks property. These are
+	"axi", "apb", "mac_ext", "ptp", "ptp_parent", "ptp_top": For MT2712 SoC
+- mac-address: See ethernet.txt in the same directory
+- power-domains: phandle to the power domain that the ethernet is part of
+- phy-mode: See ethernet.txt file in the same directory.
+- reset-gpio: gpio number for phy reset.
+
+Example:
+
+eth: eth at 1101c000 {
+		compatible = "mediatek,mt2712-eth";
+		reg = <0 0x1101c000 0 0x1200>;
+		interrupts = <GIC_SPI 237 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-names = "macirq";
+		phy-mode ="rgmii";
+		mac-address = [00 55 7b b5 7d f7];
+		clock-names = "axi",
+			      "apb",
+			      "mac_ext",
+			      "ptp",
+			      "ptp_parent",
+			      "ptp_top";
+		clocks = <&pericfg CLK_PERI_GMAC>,
+			 <&pericfg CLK_PERI_GMAC_PCLK>,
+			 <&topckgen CLK_TOP_ETHER_125M_SEL>,
+			 <&topckgen CLK_TOP_ETHER_50M_SEL>,
+			 <&topckgen CLK_TOP_APLL1_D3>,
+			 <&topckgen CLK_TOP_APLL1>;
+		reset-gpio = <&pio 87 GPIO_ACTIVE_HIGH>;
+	};
-- 
1.7.9.5
