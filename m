From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 10 Nov 2017 00:48:56 +0100
Subject: [PATCH] ARM: dts: vf610-zii-dev-c: Fix switch EEPROM size
Message-ID: <1510271336-30769-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The two Ethernet switches have an AT24C512 each. This is a 64K device,
not 512 bytes as currently listed in the device tree.

Reported-by: Chris Healy <cphealy@gmail.com>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/vf610-zii-dev-rev-c.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/vf610-zii-dev-rev-c.dts b/arch/arm/boot/dts/vf610-zii-dev-rev-c.dts
index db3b408ea55a..0c557a9e7e17 100644
--- a/arch/arm/boot/dts/vf610-zii-dev-rev-c.dts
+++ b/arch/arm/boot/dts/vf610-zii-dev-rev-c.dts
@@ -73,7 +73,7 @@
 				#size-cells = <0>;
 				reg = <0>;
 				dsa,member = <0 0>;
-				eeprom-length = <512>;
+				eeprom-length = <65536>;
 				interrupt-parent = <&gpio0>;
 				interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
 				interrupt-controller;
@@ -170,7 +170,7 @@
 				#size-cells = <0>;
 				reg = <0>;
 				dsa,member = <0 1>;
-				eeprom-length = <512>;
+				eeprom-length = <65536>;
 				interrupt-parent = <&gpio0>;
 				interrupts = <26 IRQ_TYPE_LEVEL_LOW>;
 				interrupt-controller;
-- 
2.15.0
