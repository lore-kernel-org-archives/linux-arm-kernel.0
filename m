From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 15 Oct 2015 16:28:45 +0200
Subject: [PATCH 1/3] ARM: dts: sunxi: Fix interrupt-cells for [r]pio on
 A23/A31/A33/A80
Message-ID: <1444919327-23747-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the gpio interrupt bindings where changed to add a bank to the
specifier list, the r_pio nodes of A23/A31/A33 where not updated to
match and neither was the pio node of the A80, this fixes this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun6i-a31.dtsi     | 2 +-
 arch/arm/boot/dts/sun8i-a23-a33.dtsi | 1 +
 arch/arm/boot/dts/sun9i-a80.dtsi     | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 98359f3..a97274a8 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -1102,7 +1102,7 @@
 			resets = <&apb0_rst 0>;
 			gpio-controller;
 			interrupt-controller;
-			#interrupt-cells = <2>;
+			#interrupt-cells = <3>;
 			#size-cells = <0>;
 			#gpio-cells = <3>;
 
diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
index 828aaf5..ddb9890 100644
--- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
@@ -647,6 +647,7 @@
 			resets = <&apb0_rst 0>;
 			gpio-controller;
 			interrupt-controller;
+			#interrupt-cells = <3>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			#gpio-cells = <3>;
diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
index 5908e3d..1118bf5 100644
--- a/arch/arm/boot/dts/sun9i-a80.dtsi
+++ b/arch/arm/boot/dts/sun9i-a80.dtsi
@@ -594,7 +594,7 @@
 			clocks = <&apb0_gates 5>;
 			gpio-controller;
 			interrupt-controller;
-			#interrupt-cells = <2>;
+			#interrupt-cells = <3>;
 			#size-cells = <0>;
 			#gpio-cells = <3>;
 
-- 
2.5.0
