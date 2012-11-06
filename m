From: afzal@ti.com (Afzal Mohammed)
Date: Tue, 6 Nov 2012 19:59:38 +0530
Subject: [PATCH v2] ARM: dts: AM33XX: Add usbss node
Message-ID: <1352212178-8472-1-git-send-email-afzal@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ajay Kumar Gupta <ajay.gupta@ti.com>

Device tree node for usbss on AM33XX. There are two musb
controllers on am33xx platform so have port0-mode and
port1-mode data.

[afzal at ti.com: reg & interrupt property addition]

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
Signed-off-by: Santhapuri, Damodar <damodar.santhapuri@ti.com>
Signed-off-by: Ravi Babu <ravibabu@ti.com>
Signed-off-by: Afzal Mohammed <afzal@ti.com>
---

v2: node named as "usb"

Depends on "usb: musb: dsps: dt binding - add resources, example"
(https://patchwork.kernel.org/patch/1704691/)

 arch/arm/boot/dts/am33xx.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 5dfd682..20a3f29 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -321,5 +321,22 @@
 			ti,hwmods = "spi1";
 			status = "disabled";
 		};
+
+		usb at 47400000 {
+			compatible = "ti,musb-am33xx";
+			reg = <0x47400000 0x1000	/* usbss */
+			       0x47401000 0x800		/* musb instance 0 */
+			       0x47401800 0x800>;	/* musb instance 1 */
+			interrupts = <17		/* usbss */
+				      18		/* musb instance 0 */
+				      19>;		/* musb instance 1 */
+			multipoint = <1>;
+			num-eps = <16>;
+			ram-bits = <12>;
+			port0-mode = <3>;
+			port1-mode = <3>;
+			power = <250>;
+			ti,hwmods = "usb_otg_hs";
+		};
 	};
 };
-- 
1.7.12
