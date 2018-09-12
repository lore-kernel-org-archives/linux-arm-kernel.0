From: phil@raspberrypi.org (Phil Elwell)
Date: Wed, 12 Sep 2018 17:42:34 +0100
Subject: [PATCH 2/2] ARM: dts: bcm283x: Correct mailbox register sizes
In-Reply-To: <1536770554-107314-1-git-send-email-phil@raspberrypi.org>
References: <1536770554-107314-1-git-send-email-phil@raspberrypi.org>
Message-ID: <1536770554-107314-3-git-send-email-phil@raspberrypi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The size field in a Device Tree "reg" property is encoded in bytes, not
words.

Signed-off-by: Phil Elwell <phil@raspberrypi.org>
---
 arch/arm/boot/dts/bcm2835-rpi.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
index cb2d6d7..c481eab 100644
--- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
+++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
@@ -32,7 +32,7 @@
 
 		mailbox at 7e00b840 {
 			compatible = "brcm,bcm2835-vchiq";
-			reg = <0x7e00b840 0xf>;
+			reg = <0x7e00b840 0x3c>;
 			interrupts = <0 2>;
 		};
 	};
-- 
2.7.4
