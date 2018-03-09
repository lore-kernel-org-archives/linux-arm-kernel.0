From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Fri,  9 Mar 2018 14:32:08 +0100
Subject: [PATCH RFC 3/3] ARM: dts: bcm2835-rpi: Enable OTP access for
 Raspberry Pi
In-Reply-To: <1520602328-28972-1-git-send-email-stefan.wahren@i2se.com>
References: <1520602328-28972-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1520602328-28972-4-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables OTP access for all Raspberry Pi variants.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/boot/dts/bcm2835-rpi.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
index 0198bd4..19a1027 100644
--- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
+++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
@@ -22,6 +22,12 @@
 			#address-cells = <0>;
 			#size-cells = <0>;
 			mboxes = <&mailbox>;
+
+			customer_otp: otp {
+				compatible = "raspberrypi,bcm2835-customer-otp";
+				#address-cells = <1>;
+				#size-cells = <1>;
+			};
 		};
 
 		power: power {
-- 
2.7.4
