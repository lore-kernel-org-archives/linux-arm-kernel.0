From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 17 Jun 2015 14:12:21 +0200
Subject: [PATCH RESEND 4/4] ARM: mvebu: use armada-380-xor on Armada 38x and
 39x
In-Reply-To: <1434543141-3242-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1434543141-3242-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1434543141-3242-5-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada 38x and 39x SoC support have an updated XOR hardware block
compared to previous SoCs. These features can be enabled by using the
'armada-380-xor' compatible string, available since commit
6f166312c6ea ("dmaengine: mv_xor: add support for a38x command in
descriptor mode").

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-38x.dtsi | 4 ++--
 arch/arm/boot/dts/armada-39x.dtsi | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
index 1710523..4851d32 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -448,7 +448,7 @@
 			};
 
 			xor at 60800 {
-				compatible = "marvell,orion-xor";
+				compatible = "marvell,armada-380-xor", "marvell,orion-xor";
 				reg = <0x60800 0x100
 				       0x60a00 0x100>;
 				clocks = <&gateclk 22>;
@@ -463,7 +463,7 @@
 			};
 
 			xor at 60900 {
-				compatible = "marvell,orion-xor";
+				compatible = "marvell,armada-380-xor", "marvell,orion-xor";
 				reg = <0x60900 0x100
 				       0x60b00 0x100>;
 				clocks = <&gateclk 28>;
diff --git a/arch/arm/boot/dts/armada-39x.dtsi b/arch/arm/boot/dts/armada-39x.dtsi
index 9c510d8..b77c8dc 100644
--- a/arch/arm/boot/dts/armada-39x.dtsi
+++ b/arch/arm/boot/dts/armada-39x.dtsi
@@ -323,7 +323,7 @@
 			};
 
 			xor at 60800 {
-				compatible = "marvell,orion-xor";
+				compatible = "marvell,armada-380-xor", "marvell,orion-xor";
 				reg = <0x60800 0x100
 				       0x60a00 0x100>;
 				clocks = <&gateclk 22>;
@@ -338,7 +338,7 @@
 			};
 
 			xor at 60900 {
-				compatible = "marvell,orion-xor";
+				compatible = "marvell,armada-380-xor", "marvell,orion-xor";
 				reg = <0x60900 0x100
 				       0x60b00 0x100>;
 				clocks = <&gateclk 28>;
-- 
2.1.0
