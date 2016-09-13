From: manabian@gmail.com (Joachim Eastwood)
Date: Tue, 13 Sep 2016 18:12:41 +0200
Subject: [PATCH 3/3] ARM: dts: lpc18xx: add otp node
In-Reply-To: <20160913161241.22492-1-manabian@gmail.com>
References: <20160913161241.22492-1-manabian@gmail.com>
Message-ID: <20160913161241.22492-4-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add node for the internal OTP (One Time Programmable) memory found
on all LPC18xx/43xx SoCs.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 arch/arm/boot/dts/lpc18xx.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/lpc18xx.dtsi b/arch/arm/boot/dts/lpc18xx.dtsi
index c6508ed..7ef0bc8 100644
--- a/arch/arm/boot/dts/lpc18xx.dtsi
+++ b/arch/arm/boot/dts/lpc18xx.dtsi
@@ -250,6 +250,18 @@
 			};
 		};
 
+		otp at 40045000 {
+			compatible = "nxp,lpc1850-otp";
+			reg = <0x40045000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			/* Flashless devices has part ID in OTP bank 0 */
+			part_id: identification at 0 {
+				reg = <0x0 0x10>;
+			};
+		};
+
 		rtc: rtc at 40046000 {
 			compatible = "nxp,lpc1850-rtc", "nxp,lpc1788-rtc";
 			reg = <0x40046000 0x1000>;
-- 
2.9.3
