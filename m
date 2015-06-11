From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 11 Jun 2015 19:36:44 +0200
Subject: [PATCH v4 13/13] crypto: marvell/CESA: add DT bindings documentation
In-Reply-To: <1434044206-10459-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1434044206-10459-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1434044206-10459-26-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT bindings documentation for the new marvell-cesa driver.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 .../devicetree/bindings/crypto/marvell-cesa.txt    | 45 ++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/crypto/marvell-cesa.txt

diff --git a/Documentation/devicetree/bindings/crypto/marvell-cesa.txt b/Documentation/devicetree/bindings/crypto/marvell-cesa.txt
new file mode 100644
index 0000000..c6c6a4a0
--- /dev/null
+++ b/Documentation/devicetree/bindings/crypto/marvell-cesa.txt
@@ -0,0 +1,45 @@
+Marvell Cryptographic Engines And Security Accelerator
+
+Required properties:
+- compatible: should be one of the following string
+	      "marvell,orion-crypto"
+	      "marvell,kirkwood-crypto"
+	      "marvell,dove-crypto"
+	      "marvell,armada-370-crypto"
+	      "marvell,armada-xp-crypto"
+	      "marvell,armada-375-crypto"
+	      "marvell,armada-38x-crypto"
+- reg: base physical address of the engine and length of memory mapped
+       region. Can also contain an entry for the SRAM attached to the CESA,
+       but this representation is deprecated and marvell,crypto-srams should
+       be used instead
+- reg-names: "regs". Can contain an "sram" entry, but this representation
+	     is deprecated and marvell,crypto-srams should be used instead
+- interrupts: interrupt number
+- clocks: reference to the crypto engines clocks. This property is not
+	  required for orion and kirkwood platforms
+- clock-names: "cesaX" and "cesazX", X should be replaced by the crypto engine
+	       id.
+	       This property is not required for the orion and kirkwoord
+	       platforms.
+	       "cesazX" clocks are not required on armada-370 platforms
+- marvell,crypto-srams: phandle to crypto SRAM definitions
+
+Optional properties:
+- marvell,crypto-sram-size: SRAM size reserved for crypto operations, if not
+			    specified the whole SRAM is used (2KB)
+
+
+Examples:
+
+	crypto at 90000 {
+		compatible = "marvell,armada-xp-crypto";
+		reg = <0x90000 0x10000>;
+		reg-names = "regs";
+		interrupts = <48>, <49>;
+		clocks = <&gateclk 23>, <&gateclk 23>;
+		clock-names = "cesa0", "cesa1";
+		marvell,crypto-srams = <&crypto_sram0>, <&crypto_sram1>;
+		marvell,crypto-sram-size = <0x600>;
+		status = "okay";
+	};
-- 
1.9.1
