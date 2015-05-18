From: eric@anholt.net (Eric Anholt)
Date: Mon, 18 May 2015 12:43:35 -0700
Subject: [PATCH 3/7] ARM: bcm2835: Add DT for the firmware clocks driver.
In-Reply-To: <1431978219-14226-1-git-send-email-eric@anholt.net>
References: <1431978219-14226-1-git-send-email-eric@anholt.net>
Message-ID: <1431978219-14226-4-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 arch/arm/boot/dts/bcm2835-rpi.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
index ace33f6..ac5f84c 100644
--- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
+++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
@@ -20,6 +20,12 @@
 			compatible = "raspberrypi,firmware";
 			mboxes = <&mailbox>;
 		};
+
+		firmware_clocks: firmware-clocks {
+			compatible = "raspberrypi,firmware-clocks";
+			#clock-cells = <1>;
+			firmware = <&firmware>;
+		};
 	};
 };
 
-- 
2.1.4
