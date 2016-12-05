From: ryder.lee@mediatek.com (Ryder Lee)
Date: Mon, 5 Dec 2016 15:01:24 +0800
Subject: [PATCH v1 2/2] crypto: mediatek - add DT bindings documentation
In-Reply-To: <1480921284-45827-1-git-send-email-ryder.lee@mediatek.com>
References: <1480921284-45827-1-git-send-email-ryder.lee@mediatek.com>
Message-ID: <1480921284-45827-3-git-send-email-ryder.lee@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT bindings documentation for the crypto driver

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../devicetree/bindings/crypto/mediatek-crypto.txt | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/crypto/mediatek-crypto.txt

diff --git a/Documentation/devicetree/bindings/crypto/mediatek-crypto.txt b/Documentation/devicetree/bindings/crypto/mediatek-crypto.txt
new file mode 100644
index 0000000..8b1db08
--- /dev/null
+++ b/Documentation/devicetree/bindings/crypto/mediatek-crypto.txt
@@ -0,0 +1,32 @@
+MediaTek cryptographic accelerators
+
+Required properties:
+- compatible: Should be "mediatek,mt7623-crypto"
+- reg: Address and length of the register set for the device
+- interrupts: Should contain the five crypto engines interrupts in numeric
+	order. These are global system and four descriptor rings.
+- clocks: the clock used by the core
+- clock-names: the names of the clock listed in the clocks property. These are
+	"ethif", "cryp"
+- power-domains: Must contain a reference to the PM domain.
+
+
+Optional properties:
+- interrupt-parent: Should be the phandle for the interrupt controller
+  that services interrupts for this device
+
+
+Example:
+	crypto: crypto at 1b240000 {
+		compatible = "mediatek,mt7623-crypto";
+		reg = <0 0x1b240000 0 0x20000>;
+		interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 83 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 84 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 91 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 97 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&topckgen CLK_TOP_ETHIF_SEL>,
+			 <&ethsys CLK_ETHSYS_CRYPTO>;
+		clock-names = "ethif","cryp";
+		power-domains = <&scpsys MT2701_POWER_DOMAIN_ETH>;
+	};
-- 
1.9.1
