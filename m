From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 31 Jul 2014 16:32:02 +0200
Subject: [PATCH v2] ARM: mvebu: Add RTC support for Armada 375
Message-ID: <1406817122-15675-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada 375 SoC has the same real time clock as the one used in
other Marvell EBU platforms. This patch consequently updates the
Device Tree of the Armada 375 SoC to describe the internal RTC.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
Hi Jason,

We missed it for the initial support of the SoC.

I know that it is very late for including for 3.17, so if it is
postpone for 3.18, it's fine.

However given the little change, maybe it is still possible to push it
in 3.17 ^_^

Thanks,

Gregory

Changelog:

v1->v2:
 - Fixed typos and improved the commit log

 arch/arm/boot/dts/armada-375.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/armada-375.dtsi b/arch/arm/boot/dts/armada-375.dtsi
index c1e49e7bf0fa..de6571445cef 100644
--- a/arch/arm/boot/dts/armada-375.dtsi
+++ b/arch/arm/boot/dts/armada-375.dtsi
@@ -185,6 +185,12 @@
 				};
 			};
 
+			rtc at 10300 {
+				compatible = "marvell,orion-rtc";
+				reg = <0x10300 0x20>;
+				interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
 			spi0: spi at 10600 {
 				compatible = "marvell,orion-spi";
 				reg = <0x10600 0x50>;
-- 
1.8.1.2
