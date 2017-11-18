From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sat, 18 Nov 2017 14:04:12 +0100
Subject: [PATCH 1/2] dt-binding: rng: Add interrupt property for BCM2835
In-Reply-To: <1511010253-5006-1-git-send-email-stefan.wahren@i2se.com>
References: <1511010253-5006-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1511010253-5006-2-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As Sylvain Garrigues pointed out the BCM2835 RNG block has an
interrupt. Also in preparation for Florian's upcoming patch series
add this property to the binding. While we are at it fix the
indenting of the example.

Link: https://github.com/raspberrypi/linux/issues/2195
CC: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 Documentation/devicetree/bindings/rng/brcm,bcm2835.txt | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/rng/brcm,bcm2835.txt b/Documentation/devicetree/bindings/rng/brcm,bcm2835.txt
index 2654269..82ef4dd 100644
--- a/Documentation/devicetree/bindings/rng/brcm,bcm2835.txt
+++ b/Documentation/devicetree/bindings/rng/brcm,bcm2835.txt
@@ -6,11 +6,16 @@ Required properties:
   "brcm,bcm5301x-rng"
 - reg : Specifies base physical address and size of the registers.
 
+Optional properties:
+
+- interrupts: specify the interrupt for the RNG block
+
 Example:
 
 rng {
-        compatible = "brcm,bcm2835-rng";
-        reg = <0x7e104000 0x10>;
+	compatible = "brcm,bcm2835-rng";
+	reg = <0x7e104000 0x10>;
+	interrupts = <2 29>;
 };
 
 rng at 18033000 {
-- 
2.7.4
