From: hdegoede@redhat.com (Hans de Goede)
Date: Sun,  8 Mar 2015 21:53:42 +0100
Subject: [PATCH 3/3] ARM: dts: sunxi: Adjust touchscreen compatible for sun5i
 and later
In-Reply-To: <1425848022-18001-1-git-send-email-hdegoede@redhat.com>
References: <1425848022-18001-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1425848022-18001-4-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The touchscreen controller in the A13 and later has a different temperature
curve than the one in the original A10, change the compatible for the A13 and
later so that the kernel will use the correct curve.

Reported-by: Tong Zhang <lovewilliam@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun5i.dtsi     | 2 +-
 arch/arm/boot/dts/sun7i-a20.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
index e42cbb0..610ea18 100644
--- a/arch/arm/boot/dts/sun5i.dtsi
+++ b/arch/arm/boot/dts/sun5i.dtsi
@@ -494,7 +494,7 @@
 		};
 
 		rtp: rtp at 01c25000 {
-			compatible = "allwinner,sun4i-a10-ts";
+			compatible = "allwinner,sun5i-a13-ts";
 			reg = <0x01c25000 0x100>;
 			interrupts = <29>;
 			#thermal-sensor-cells = <0>;
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 3a8530b..8df77f5 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -1043,7 +1043,7 @@
 		};
 
 		rtp: rtp at 01c25000 {
-			compatible = "allwinner,sun4i-a10-ts";
+			compatible = "allwinner,sun5i-a13-ts";
 			reg = <0x01c25000 0x100>;
 			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
 			#thermal-sensor-cells = <0>;
-- 
2.3.1
