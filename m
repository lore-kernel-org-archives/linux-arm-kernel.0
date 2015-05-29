From: eric@anholt.net (Eric Anholt)
Date: Thu, 28 May 2015 17:07:35 -0700
Subject: [PATCH v5 3/3] ARM: bcm2835: Add the firmware driver information to
 the RPi DT
In-Reply-To: <1432858055-8750-1-git-send-email-eric@anholt.net>
References: <1432858055-8750-1-git-send-email-eric@anholt.net>
Message-ID: <1432858055-8750-3-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v2: Drop pm-domains stuff since I've dropped it from the firmware
    driver for now, until we get drivers/base fixed.

v3: Rename the compatible to "raspberrypi,bcm2835-firmware"

Signed-off-by: Eric Anholt <eric@anholt.net>
Acked-by: Lee Jones <lee@kernel.org> (previous version with pm-domains)
Acked-by: Stephen Warren <swarren@wwwdotorg.org>
---
 arch/arm/boot/dts/bcm2835-rpi.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
index 46780bb..ab5474e 100644
--- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
+++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
@@ -14,6 +14,13 @@
 			linux,default-trigger = "heartbeat";
 		};
 	};
+
+	soc {
+		firmware: firmware {
+			compatible = "raspberrypi,bcm2835-firmware";
+			mboxes = <&mailbox>;
+		};
+	};
 };
 
 &gpio {
-- 
2.1.4
