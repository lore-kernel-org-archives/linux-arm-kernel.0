From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 24 Jul 2014 15:45:00 +0100
Subject: [PATCH] ARM: dts: dove: add DT LCD controllers
Message-ID: <E1XAKGS-0004WE-8h@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the DT fragment for the Marvell Dove LCD controllers.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
Jason,

David Airlie has taken the Armada DRM changes into his tree, so the DT
bits can now be queued for the next merge window.

 arch/arm/boot/dts/dove.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index 3b891dd20993..a5441d5482a6 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -630,6 +630,20 @@
 				reg = <0xe8400 0x0c>;
 				ngpios = <8>;
 			};
+
+			lcd1: lcd-controller at 810000 {
+				compatible = "marvell,dove-lcd";
+				reg = <0x810000 0x1000>;
+				interrupts = <46>;
+				status = "disabled";
+			};
+
+			lcd0: lcd-controller at 820000 {
+				compatible = "marvell,dove-lcd";
+				reg = <0x820000 0x1000>;
+				interrupts = <47>;
+				status = "disabled";
+			};
 		};
 	};
 };
-- 
1.8.3.1
