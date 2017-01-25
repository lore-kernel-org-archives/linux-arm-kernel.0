From: rob.rice@broadcom.com (Rob Rice)
Date: Wed, 25 Jan 2017 11:44:47 -0500
Subject: [PATCH v3 1/3] crypto: brcm: DT documentation for Broadcom SPU
 hardware
In-Reply-To: <1485362689-11294-1-git-send-email-rob.rice@broadcom.com>
References: <1485362689-11294-1-git-send-email-rob.rice@broadcom.com>
Message-ID: <1485362689-11294-2-git-send-email-rob.rice@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Device tree documentation for Broadcom Secure Processing Unit
(SPU) crypto hardware.

Signed-off-by: Steve Lin <steven.lin1@broadcom.com>
Signed-off-by: Rob Rice <rob.rice@broadcom.com>
---
 .../devicetree/bindings/crypto/brcm,spu-crypto.txt | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/crypto/brcm,spu-crypto.txt

diff --git a/Documentation/devicetree/bindings/crypto/brcm,spu-crypto.txt b/Documentation/devicetree/bindings/crypto/brcm,spu-crypto.txt
new file mode 100644
index 0000000..29b6007
--- /dev/null
+++ b/Documentation/devicetree/bindings/crypto/brcm,spu-crypto.txt
@@ -0,0 +1,22 @@
+The Broadcom Secure Processing Unit (SPU) hardware supports symmetric
+cryptographic offload for Broadcom SoCs. A SoC may have multiple SPU hardware
+blocks.
+
+Required properties:
+- compatible: Should be one of the following:
+  brcm,spum-crypto - for devices with SPU-M hardware
+  brcm,spu2-crypto - for devices with SPU2 hardware
+  brcm,spu2-v2-crypto - for devices with enhanced SPU2 hardware features like SHA3
+  and Rabin Fingerprint support
+  brcm,spum-nsp-crypto - for the Northstar Plus variant of the SPU-M hardware
+
+- reg: Should contain SPU registers location and length.
+- mboxes: The mailbox channel to be used to communicate with the SPU.
+  Mailbox channels correspond to DMA rings on the device.
+
+Example:
+	crypto at 612d0000 {
+		compatible = "brcm,spum-crypto";
+		reg = <0 0x612d0000 0 0x900>;
+		mboxes = <&pdc0 0>;
+	};
-- 
2.1.0
