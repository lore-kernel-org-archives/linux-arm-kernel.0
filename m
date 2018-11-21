From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Wed, 21 Nov 2018 14:11:42 +0100
Subject: [PATCH 3/5] ARM: dts: bcm2835-rpi: Enable OTP access for Raspberry Pi
In-Reply-To: <1542805904-6446-1-git-send-email-stefan.wahren@i2se.com>
References: <1542805904-6446-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1542805904-6446-4-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables OTP access for all Raspberry Pi variants.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/boot/dts/bcm2835-rpi.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
index cb2d6d7..0fcd9da 100644
--- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
+++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
@@ -22,6 +22,10 @@
 			#address-cells = <0>;
 			#size-cells = <0>;
 			mboxes = <&mailbox>;
+
+			customer_otp: otp {
+				compatible = "raspberrypi,bcm2835-customer-otp";
+			};
 		};
 
 		power: power {
-- 
2.7.4
