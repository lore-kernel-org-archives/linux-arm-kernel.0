From: quentin.schulz@bootlin.com (Quentin Schulz)
Date: Fri,  6 Apr 2018 09:50:44 +0200
Subject: [PATCH 1/2] ARM: SPEAr600: add DT description of the watchdog
Message-ID: <0635969b6ef0fe528a27a8b6493cc3df770e1f60.1523000725.git-series.quentin.schulz@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SPEAr600 has a built-in watchdog which already has a DT binding
described in Documentation/devicetree/bindings/watchdog/sp805-wdt.txt.

Let's add the description of the watchdog device in the SPEAr600 Device
Tree.

Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
---
 arch/arm/boot/dts/spear600.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/spear600.dtsi b/arch/arm/boot/dts/spear600.dtsi
index 00166eb..d7c3096 100644
--- a/arch/arm/boot/dts/spear600.dtsi
+++ b/arch/arm/boot/dts/spear600.dtsi
@@ -213,6 +213,14 @@
 				interrupts = <6>;
 				status = "disabled";
 			};
+
+			wdt: wdt at fc880000 {
+				compatible = "arm,sp805", "arm,primecell";
+				reg = <0xfc880000 0x1000>;
+				interrupt-parent = <&vic1>;
+				interrupts = <20>;
+				status = "disabled";
+			};
 		};
 	};
 };

base-commit: 5e1dacccbb87780856219e29122f1eccec912ebb
-- 
git-series 0.9.1
