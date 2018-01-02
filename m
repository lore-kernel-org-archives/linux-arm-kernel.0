From: baruch@tkos.co.il (Baruch Siach)
Date: Tue,  2 Jan 2018 15:19:21 +0200
Subject: [PATCH 4/4] ARM: dts: bcm2837-rpi-3-b: add GPIO expander
In-Reply-To: <cover.1514898134.git.baruch@tkos.co.il>
References: <cover.1514898134.git.baruch@tkos.co.il>
Message-ID: <a29df633ee568e150c150debde66c0783a57c70a.1514898134.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a description of the RPi3 GPIO expander that the VC4 firmware controls.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/arm/boot/dts/bcm2837-rpi-3-b.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2837-rpi-3-b.dts b/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
index b44b3b5af00d..09dca48da2bd 100644
--- a/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
+++ b/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
@@ -23,6 +23,16 @@
 			gpios = <&gpio 47 0>;
 		};
 	};
+
+	soc {
+		expgpio: expgpio {
+			compatible = "brcm,bcm2835-expgpio";
+			gpio-controller;
+			#gpio-cells = <2>;
+			firmware = <&firmware>;
+			status = "okay";
+		};
+	};
 };
 
 /* uart0 communicates with the BT module */
-- 
2.15.1
