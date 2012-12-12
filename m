From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 12 Dec 2012 10:06:24 +0100
Subject: [PATCH V2 2/4] arm: mvebu: Add RTC support for Armada 370 and Armada
 XP
In-Reply-To: <1355303186-9267-1-git-send-email-gregory.clement@free-electrons.com>
References: <1355303186-9267-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1355303186-9267-3-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada 370 and Armada XP Socs have the same controller that the
one used in the orion platforms. This patch updates the device tree
for these SoCs.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Acked-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/armada-370-xp.dtsi |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index cf6c48a..86dccfa 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -129,6 +129,12 @@
 			clocks = <&coreclk 0>;
 			status = "disabled";
 		};
+
+		rtc at 10300 {
+			compatible = "marvell,orion-rtc";
+			reg = <0xd0010300 0x20>;
+			interrupts = <50>;
+		};
 	};
 };
 
-- 
1.7.9.5
