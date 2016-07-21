From: jaz@semihalf.com (Grzegorz Jaszczyk)
Date: Thu, 21 Jul 2016 14:44:10 +0200
Subject: [PATCH 13/18] ARM: mvebu: a39x: enable rtc for all Armada-39x SoCs
In-Reply-To: <1469105055-25181-1-git-send-email-jaz@semihalf.com>
References: <1469105055-25181-1-git-send-email-jaz@semihalf.com>
Message-ID: <1469105055-25181-15-git-send-email-jaz@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Despite that FS states that rtc is present only in A395 and A398 and not in
A390, the rtc is working with A390.

Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>
---
 arch/arm/boot/dts/armada-39x.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/armada-39x.dtsi b/arch/arm/boot/dts/armada-39x.dtsi
index 1225cd8..5bed8b9 100644
--- a/arch/arm/boot/dts/armada-39x.dtsi
+++ b/arch/arm/boot/dts/armada-39x.dtsi
@@ -429,6 +429,13 @@
 				};
 			};
 
+			rtc at a3800 {
+				compatible = "marvell,armada-380-rtc";
+				reg = <0xa3800 0x20>, <0x184a0 0x0c>;
+				reg-names = "rtc", "rtc-soc";
+				interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
 			flash at d0000 {
 				compatible = "marvell,armada370-nand";
 				reg = <0xd0000 0x54>;
-- 
1.8.3.1
