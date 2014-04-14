From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon, 14 Apr 2014 10:23:31 -0300
Subject: [RESEND/PATCH v4 7/9] ARM: mvebu: Enable Armada 375 watchdog in the
 devicetree
In-Reply-To: <1397481813-4962-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1397481813-4962-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1397481813-4962-8-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the DT nodes to enable the watchdog support available on
Armada 375 SoC.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/boot/dts/armada-375.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/armada-375.dtsi b/arch/arm/boot/dts/armada-375.dtsi
index 3877693..0bfa57b 100644
--- a/arch/arm/boot/dts/armada-375.dtsi
+++ b/arch/arm/boot/dts/armada-375.dtsi
@@ -320,6 +320,12 @@
 				clocks = <&coreclk 0>;
 			};
 
+			watchdog at 20300 {
+				compatible = "marvell,armada-375-wdt";
+				reg = <0x20300 0x34>, <0x20704 0x4>, <0x18254 0x4>;
+				clocks = <&coreclk 0>;
+			};
+
 			xor at 60800 {
 				compatible = "marvell,orion-xor";
 				reg = <0x60800 0x100
-- 
1.9.1
