From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 30 Jun 2014 23:57:51 +0200
Subject: [PATCH 1/9] ARM: dts: sunxi: Add #interrupt-cells to pinctrl nodes
In-Reply-To: <1404165479-23785-1-git-send-email-hdegoede@redhat.com>
References: <1404165479-23785-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1404165479-23785-2-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chen-Yu Tsai <wens@csie.org>

The pinctrl device is also an interrupt controller for external
interrupts. Add the missing #interrupt-cells property.

Also remove the unused #address-cells property.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
[hdegoede at redhat.com: make the same change for sun4i, sun5i and sun6i]
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi  | 2 +-
 arch/arm/boot/dts/sun5i-a10s.dtsi | 2 +-
 arch/arm/boot/dts/sun5i-a13.dtsi  | 2 +-
 arch/arm/boot/dts/sun6i-a31.dtsi  | 4 ++--
 arch/arm/boot/dts/sun7i-a20.dtsi  | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 9a489e2..ae6dd50 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -509,7 +509,7 @@
 			clocks = <&apb0_gates 5>;
 			gpio-controller;
 			interrupt-controller;
-			#address-cells = <1>;
+			#interrupt-cells = <2>;
 			#size-cells = <0>;
 			#gpio-cells = <3>;
 
diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index 25549c1..695a7c6 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -422,7 +422,7 @@
 			clocks = <&apb0_gates 5>;
 			gpio-controller;
 			interrupt-controller;
-			#address-cells = <1>;
+			#interrupt-cells = <2>;
 			#size-cells = <0>;
 			#gpio-cells = <3>;
 
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index be28b3b..74895e5 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -395,7 +395,7 @@
 			clocks = <&apb0_gates 5>;
 			gpio-controller;
 			interrupt-controller;
-			#address-cells = <1>;
+			#interrupt-cells = <2>;
 			#size-cells = <0>;
 			#gpio-cells = <3>;
 
diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index a9dfa12..baf8eff 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -429,7 +429,7 @@
 			clocks = <&apb1_gates 5>;
 			gpio-controller;
 			interrupt-controller;
-			#address-cells = <1>;
+			#interrupt-cells = <2>;
 			#size-cells = <0>;
 			#gpio-cells = <3>;
 
@@ -756,7 +756,7 @@
 			resets = <&apb0_rst 0>;
 			gpio-controller;
 			interrupt-controller;
-			#address-cells = <1>;
+			#interrupt-cells = <2>;
 			#size-cells = <0>;
 			#gpio-cells = <3>;
 		};
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 7017839..7597ac1 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -586,7 +586,7 @@
 			clocks = <&apb0_gates 5>;
 			gpio-controller;
 			interrupt-controller;
-			#address-cells = <1>;
+			#interrupt-cells = <2>;
 			#size-cells = <0>;
 			#gpio-cells = <3>;
 
-- 
2.0.0
