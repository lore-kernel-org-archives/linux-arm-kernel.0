From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Wed, 9 Jul 2014 14:05:32 +0530
Subject: [PATCH V2 2/2] ARM: dts: DRA7: Add node for RTC
In-Reply-To: <1404894932-26677-1-git-send-email-lokeshvutla@ti.com>
References: <alpine.DEB.2.02.1407060031120.23762@utopia.booyaka.com>
 <1404894932-26677-1-git-send-email-lokeshvutla@ti.com>
Message-ID: <1404894932-26677-3-git-send-email-lokeshvutla@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add node for RTC.
And also making RTC regulator always-on, as RTC should be powered
always.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
[nm at ti.com: update with rtc crossbar number]
Signed-off-by: Nishanth Menon <nm@ti.com>
---
This patch depends on the crossbar dt patch series by Sricharan:
https://www.mail-archive.com/linux-omap at vger.kernel.org/msg106910.html

 arch/arm/boot/dts/dra7-evm.dts |    1 +
 arch/arm/boot/dts/dra7.dtsi    |    9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index 4adc280..bca6d4a 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -249,6 +249,7 @@
 					regulator-min-microvolt = <1050000>;
 					regulator-max-microvolt = <1050000>;
 					regulator-boot-on;
+					regulator-always-on;
 				};
 
 				ldoln_reg: ldoln {
diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 55a6cd4..46779197 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -828,6 +828,15 @@
 			ti,hwmods = "sata";
 		};
 
+		rtcss at 48838000 {
+			compatible = "ti,am3352-rtc";
+			reg = <0x48838000 0x100>;
+			interrupts = <GIC_SPI 217 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 217 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "rtcss";
+			clocks = <&sys_32k_ck>;
+		};
+
 		omap_control_usb2phy1: control-phy at 4a002300 {
 			compatible = "ti,control-phy-usb2";
 			reg = <0x4a002300 0x4>;
-- 
1.7.9.5
