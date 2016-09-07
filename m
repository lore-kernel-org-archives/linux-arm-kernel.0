From: jorik@kippendief.biz (jorik at kippendief.biz)
Date: Wed,  7 Sep 2016 09:41:41 +0200
Subject: [PATCH v3 3/8] dts: sun8i-h3: move uart0 pinmux/peripheral assocation
 to DSTI
In-Reply-To: <1473234106-32330-1-git-send-email-jorik@kippendief.biz>
References: <1473234106-32330-1-git-send-email-jorik@kippendief.biz>
Message-ID: <1473234106-32330-4-git-send-email-jorik@kippendief.biz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jorik Jonker <jorik@kippendief.biz>

This is the only sensible pinmux/peripheral association for uart0, so I have
moved it from the board specific DTS to the DTSI. It is still up to the boards
to enable it, though.

Signed-off-by: Jorik Jonker <jorik@kippendief.biz>
---
 arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts | 2 --
 arch/arm/boot/dts/sun8i-h3-orangepi-2.dts       | 2 --
 arch/arm/boot/dts/sun8i-h3-orangepi-one.dts     | 2 --
 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts      | 2 --
 arch/arm/boot/dts/sun8i-h3.dtsi                 | 2 ++
 5 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts b/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
index 45f623b..c874270 100644
--- a/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
+++ b/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
@@ -178,8 +178,6 @@
 };
 
 &uart0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
index 6cb29f3..c9c0014 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
@@ -171,8 +171,6 @@
 };
 
 &uart0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
index a1423cc..c830ff9 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
@@ -134,8 +134,6 @@
 };
 
 &uart0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
index 772239e..ae87061 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
@@ -156,8 +156,6 @@
 };
 
 &uart0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index 933d42c..6635f3d 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -399,6 +399,8 @@
 			resets = <&ccu RST_BUS_UART0>;
 			dmas = <&dma 6>, <&dma 6>;
 			dma-names = "rx", "tx";
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart0_pins>;
 			status = "disabled";
 		};
 
-- 
2.7.4
