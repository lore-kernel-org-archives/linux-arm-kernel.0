From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 26 Jun 2015 14:47:39 +0200
Subject: [PATCH] ARM: dts: sunxi: Adjust touchscreen compatible for sun5i and
 later
Message-ID: <1435322859-27760-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a manual cherry pick of a commit currently queued up for merging
into 4.2, titled:
"ARM: dts: sunxi Adjust touchscreen compatible for sun5i and later"

For the 4.1 stable series, fixing a regression in 4.1 where we are now
reporting the wrong SoC temperature for sun5i and sun7i SoCs.

Conflicts:
	arch/arm/boot/dts/sun5i.dtsi

Original commit message:

The touchscreen controller in the A13 and later has a different temperature
curve than the one in the original A10, change the compatible for the A13 and
later so that the kernel will use the correct curve.

Cc: stable at vger.kernel.org # 4.1
Reported-by: m.silentcreek at gmail.com
Reported-by: Tong Zhang <lovewilliam@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun5i-a10s.dtsi | 2 +-
 arch/arm/boot/dts/sun5i-a13.dtsi  | 2 +-
 arch/arm/boot/dts/sun7i-a20.dtsi  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index 2fd8988..3794ca1 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -573,7 +573,7 @@
 		};
 
 		rtp: rtp at 01c25000 {
-			compatible = "allwinner,sun4i-a10-ts";
+			compatible = "allwinner,sun5i-a13-ts";
 			reg = <0x01c25000 0x100>;
 			interrupts = <29>;
 			#thermal-sensor-cells = <0>;
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index 883cb48..5098185 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -555,7 +555,7 @@
 		};
 
 		rtp: rtp at 01c25000 {
-			compatible = "allwinner,sun4i-a10-ts";
+			compatible = "allwinner,sun5i-a13-ts";
 			reg = <0x01c25000 0x100>;
 			interrupts = <29>;
 			#thermal-sensor-cells = <0>;
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index fdd1817..2b4847c 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -1042,7 +1042,7 @@
 		};
 
 		rtp: rtp at 01c25000 {
-			compatible = "allwinner,sun4i-a10-ts";
+			compatible = "allwinner,sun5i-a13-ts";
 			reg = <0x01c25000 0x100>;
 			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
 			#thermal-sensor-cells = <0>;
-- 
2.4.3
