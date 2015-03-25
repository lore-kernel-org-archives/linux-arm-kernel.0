From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 24 Mar 2015 17:17:10 -0700
Subject: [PATCH 1/3] Documentation: bindings: add BCM6328-style soft reset
 binding
In-Reply-To: <1427242632-7971-1-git-send-email-f.fainelli@gmail.com>
References: <1427242632-7971-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1427242632-7971-2-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a binding document for the BCM6328-style software reset block found
in MIPS and ARM based Broadcom BCM63xx DSL SoCs.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 Documentation/devicetree/bindings/arm/bcm/bcm63138.txt | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/bcm/bcm63138.txt b/Documentation/devicetree/bindings/arm/bcm/bcm63138.txt
index bd49987a8812..bddf76d8dda4 100644
--- a/Documentation/devicetree/bindings/arm/bcm/bcm63138.txt
+++ b/Documentation/devicetree/bindings/arm/bcm/bcm63138.txt
@@ -7,3 +7,19 @@ following properties:
 Required root node property:
 
 compatible: should be "brcm,bcm63138"
+
+
+reboot node
+-----------
+
+Required properties
+
+- compatible: sould be "brcm,bcm6328-soft-reset"
+- reg: should be the base register addresse and length
+
+Example:
+
+reboot at b0 {
+	compatible = "brcm,bcm6328-soft-reset";
+	reg = <0xb0 0x4>;
+};
-- 
2.1.0
