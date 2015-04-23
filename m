From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 23 Apr 2015 16:03:01 -0700
Subject: [PATCH v2 2/2] ARM: dts: BCM63xx: Add timer and syscon-reboot nodes
In-Reply-To: <1429830181-28338-1-git-send-email-f.fainelli@gmail.com>
References: <1429830181-28338-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1429830181-28338-3-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a "brcm,bcm6328-timer" and "syscon-reboot" nodes to allow the
generic syscon-reboot driver to reset a BCM63138 SoC.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/dts/bcm63138.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/bcm63138.dtsi b/arch/arm/boot/dts/bcm63138.dtsi
index f46329c8ad75..c23402e18811 100644
--- a/arch/arm/boot/dts/bcm63138.dtsi
+++ b/arch/arm/boot/dts/bcm63138.dtsi
@@ -114,6 +114,11 @@
 		#size-cells = <1>;
 		ranges = <0 0xfffe8000 0x8100>;
 
+		timer: timer at 80 {
+			compatible = "brcm,bcm6328-timer", "syscon";
+			reg = <0x80 0x3c>;
+		};
+
 		serial0: serial at 600 {
 			compatible = "brcm,bcm6345-uart";
 			reg = <0x600 0x1b>;
@@ -131,5 +136,12 @@
 			clock-names = "periph";
 			status = "disabled";
 		};
+
+		reboot {
+			compatible = "syscon-reboot";
+			regmap = <&timer>;
+			offset = <0x34>;
+			mask = <1>;
+		};
 	};
 };
-- 
2.1.0
