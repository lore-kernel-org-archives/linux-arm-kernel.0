From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 26 Mar 2013 10:30:18 -0300
Subject: [PATCH] ARM: mvebu: Add gpio button to Mirabox board
Message-ID: <1364304618-2883-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Globalscale Mirabox board has a little gpio button
placed just above the SD card slot; the board user guide labels
this button as "System reset button".

This patch adds support for this button in the device tree file.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-mirabox.dts |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-mirabox.dts b/arch/arm/boot/dts/armada-370-mirabox.dts
index dd0c57d..8fb7590 100644
--- a/arch/arm/boot/dts/armada-370-mirabox.dts
+++ b/arch/arm/boot/dts/armada-370-mirabox.dts
@@ -70,5 +70,16 @@
 		usb at d0051000 {
 			status = "okay";
 		};
+
+		gpio-keys {
+			compatible = "gpio-keys";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reset at 1 {
+				label = "Reset Button";
+				linux,code = <116>;
+				gpios = <&gpio1 26 1>;
+			};
+		};
 	};
 };
-- 
1.7.8.6
