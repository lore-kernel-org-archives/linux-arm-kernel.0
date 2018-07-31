From: pawel.mikolaj.chmiel@gmail.com (=?UTF-8?q?Pawe=C5=82=20Chmiel?=)
Date: Tue, 31 Jul 2018 17:18:11 +0200
Subject: [PATCH v3 3/3] Input: atmel_mxt_ts: Document optional voltage
 regulators
In-Reply-To: <1533050291-11502-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
References: <1533050291-11502-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
Message-ID: <1533050291-11502-4-git-send-email-pawel.mikolaj.chmiel@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document new optional voltage regulators, which can be used
to power down/up touchscreen.

Signed-off-by: Pawe? Chmiel <pawel.mikolaj.chmiel@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes from v1:
  - Added reviewed-by
---
 Documentation/devicetree/bindings/input/atmel,maxtouch.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/atmel,maxtouch.txt b/Documentation/devicetree/bindings/input/atmel,maxtouch.txt
index c88919480d37..17930ecadad3 100644
--- a/Documentation/devicetree/bindings/input/atmel,maxtouch.txt
+++ b/Documentation/devicetree/bindings/input/atmel,maxtouch.txt
@@ -31,6 +31,12 @@ Optional properties for main touchpad device:
 
 - reset-gpios: GPIO specifier for the touchscreen's reset pin (active low)
 
+- avdd-supply: Analog power supply. It powers up the analog channel block
+    of the controller to detect the touches.
+
+- vdd-supply: Digital power supply. It powers up the digital block
+    of the controller to enable i2c communication.
+
 Example:
 
 	touch at 4b {
@@ -38,4 +44,6 @@ Example:
 		reg = <0x4b>;
 		interrupt-parent = <&gpio>;
 		interrupts = <TEGRA_GPIO(W, 3) IRQ_TYPE_LEVEL_LOW>;
+		avdd-supply = <&atsp_reg>;
+		vdd-supply = <&tsp_reg>;
 	};
-- 
2.7.4
