From: baruch@tkos.co.il (Baruch Siach)
Date: Wed,  7 Feb 2018 20:35:25 +0200
Subject: [PATCH v4 4/5] ARM: dts: bcm2835: make the firmware node into a bus
In-Reply-To: <cover.1517923836.git.baruch@tkos.co.il>
References: <cover.1517923836.git.baruch@tkos.co.il>
Message-ID: <eb4fc74047a6b2ed7a7c0aef687f7440eae056f5.1517923836.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows adding devices for which the firmware exposes control interface
via the mailbox. An example of such device is the GPIO expander.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
v4: New patch in this series
---
 arch/arm/boot/dts/bcm2835-rpi.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
index e36c392a2b8f..0198bd46ef7c 100644
--- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
+++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
@@ -18,7 +18,9 @@
 
 	soc {
 		firmware: firmware {
-			compatible = "raspberrypi,bcm2835-firmware";
+			compatible = "raspberrypi,bcm2835-firmware", "simple-bus";
+			#address-cells = <0>;
+			#size-cells = <0>;
 			mboxes = <&mailbox>;
 		};
 
-- 
2.15.1
