From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 15 Jan 2015 18:23:20 +0100
Subject: [PATCH v4 4/5] ARM: mvebu: add Device Tree description of RTC on
 Armada 38x
In-Reply-To: <1421342601-20384-1-git-send-email-gregory.clement@free-electrons.com>
References: <1421342601-20384-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1421342601-20384-5-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Marvell Armada 38x SoCs contains an RTC which differs from the RTC
used in the other mvebu SoCs until now. This commit adds the Device
Tree description of this interface at the SoC level.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-38x.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
index 04fe80d101f8..79c4acf186e2 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -466,6 +466,13 @@
 				clocks = <&gateclk 4>;
 			};
 
+			rtc at a3800 {
+				compatible = "marvell,armada-380-rtc";
+				reg = <0xa3800 0x20>, <0x184a0 0x0c>;
+				reg-names = "rtc", "rtc-soc";
+				interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
 			sata at a8000 {
 				compatible = "marvell,armada-380-ahci";
 				reg = <0xa8000 0x2000>;
-- 
1.9.1
