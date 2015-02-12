From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Thu, 12 Feb 2015 01:55:11 +0100
Subject: [PATCH 3/5] ARM: dts: zynq: Add LED for Parallella
In-Reply-To: <1423702513-4032-1-git-send-email-afaerber@suse.de>
References: <1423702513-4032-1-git-send-email-afaerber@suse.de>
Message-ID: <1423702513-4032-4-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the green LED CR10.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 arch/arm/boot/dts/zynq-parallella1.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/zynq-parallella1.dtsi b/arch/arm/boot/dts/zynq-parallella1.dtsi
index e77a4968fe17..8b2895c06c8e 100644
--- a/arch/arm/boot/dts/zynq-parallella1.dtsi
+++ b/arch/arm/boot/dts/zynq-parallella1.dtsi
@@ -18,6 +18,7 @@
  * GNU General Public License for more details.
  */
 /include/ "zynq-7000.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	compatible = "adapteva,parallella", "xlnx,zynq-7000";
@@ -36,6 +37,16 @@
 		bootargs = "console=ttyPS0,115200 earlyprintk root=/dev/mmcblk0p2 rootfstype=ext4 rw rootwait";
 		linux,stdout-path = "/amba/serial at e0001000";
 	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		cr10 {
+			label = "parallella:cr10:usr";
+			gpios = <&gpio0 7 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+		};
+	};
 };
 
 &clkc {
-- 
2.2.2
