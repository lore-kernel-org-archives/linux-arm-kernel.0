From: lkundrak@v3.sk (Lubomir Rintel)
Date: Mon, 12 Nov 2018 04:20:16 +0100
Subject: [PATCH v3 07/18] DT: marvell,mmp2: add more TWSI controllers
In-Reply-To: <20181112032027.653931-1-lkundrak@v3.sk>
References: <20181112032027.653931-1-lkundrak@v3.sk>
Message-ID: <20181112032027.653931-8-lkundrak@v3.sk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I've gotten the base addresses, clocks and interrupts from an rusty and old
out-of-tree driver. I haven't actually checked against the datasheet, since
that one is reserved for the Marvell inner circle.

Tested with an accelerometer on TWSI6 on an OLPC XO 1.75 machine.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 arch/arm/boot/dts/mmp2.dtsi | 49 +++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/arm/boot/dts/mmp2.dtsi b/arch/arm/boot/dts/mmp2.dtsi
index 63d49abf4e92..7549680ab2e3 100644
--- a/arch/arm/boot/dts/mmp2.dtsi
+++ b/arch/arm/boot/dts/mmp2.dtsi
@@ -269,6 +269,55 @@
 				status = "disabled";
 			};
 
+			twsi3: i2c at d4032000 {
+				compatible = "mrvl,mmp-twsi";
+				reg = <0xd4032000 0x1000>;
+				interrupt-parent = <&intcmux17>;
+				interrupts = <1>;
+				clocks = <&soc_clocks MMP2_CLK_TWSI2>;
+				resets = <&soc_clocks MMP2_CLK_TWSI2>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			twsi4: i2c at d4033000 {
+				compatible = "mrvl,mmp-twsi";
+				reg = <0xd4033000 0x1000>;
+				interrupt-parent = <&intcmux17>;
+				interrupts = <2>;
+				clocks = <&soc_clocks MMP2_CLK_TWSI3>;
+				resets = <&soc_clocks MMP2_CLK_TWSI3>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+
+			twsi5: i2c at d4033800 {
+				compatible = "mrvl,mmp-twsi";
+				reg = <0xd4033800 0x1000>;
+				interrupt-parent = <&intcmux17>;
+				interrupts = <3>;
+				clocks = <&soc_clocks MMP2_CLK_TWSI4>;
+				resets = <&soc_clocks MMP2_CLK_TWSI4>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			twsi6: i2c at d4034000 {
+				compatible = "mrvl,mmp-twsi";
+				reg = <0xd4034000 0x1000>;
+				interrupt-parent = <&intcmux17>;
+				interrupts = <4>;
+				clocks = <&soc_clocks MMP2_CLK_TWSI5>;
+				resets = <&soc_clocks MMP2_CLK_TWSI5>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
 			rtc: rtc at d4010000 {
 				compatible = "mrvl,mmp-rtc";
 				reg = <0xd4010000 0x1000>;
-- 
2.19.1
