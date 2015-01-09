From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri,  9 Jan 2015 16:32:45 +0100
Subject: [PATCH 4/4] ARM: mvebu: add Device Tree description of RTC on Armada
 38x
In-Reply-To: <1420817565-28800-1-git-send-email-gregory.clement@free-electrons.com>
References: <1420817565-28800-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1420817565-28800-5-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Marvell Armada 38x SoCs contains an RTC which differs from the RTC
used in the other mvebu SoCs until now. This commit adds the Device
Tree description of this interface at the SoC level.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-38x.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
index 04fe80d101f8..22909add8889 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -466,6 +466,12 @@
 				clocks = <&gateclk 4>;
 			};
 
+			rtc at 184a8 {
+				compatible = "marvell,armada-380-rtc";
+				reg = <0xa3800 0x20>, <0x184a0 0x0c>;
+				interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
 			sata at a8000 {
 				compatible = "marvell,armada-380-ahci";
 				reg = <0xa8000 0x2000>;
-- 
1.9.1
