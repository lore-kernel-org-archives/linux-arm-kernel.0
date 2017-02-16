From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 16 Feb 2017 16:31:36 +0100
Subject: [PATCH 3/3] arm64: dts: marvell: add RTC description for Armada 7K/8K
In-Reply-To: <20170216153136.27009-1-gregory.clement@free-electrons.com>
References: <20170216153136.27009-1-gregory.clement@free-electrons.com>
Message-ID: <20170216153136.27009-4-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This RTC IP is found in the CP110 which is part of the Armada 8K SoCs and
of the subset family the Armada 7K.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
index 3a99c36433d6..3a3bbc488736 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
@@ -79,6 +79,13 @@
 					"cpm-usb3dev", "cpm-eip150", "cpm-eip197";
 			};
 
+			rtc: rtc at 284000 {
+				compatible = "marvell,armada-8k-rtc";
+				reg = <0x284000 0x20>, <0x284080 0x24>;
+				reg-names = "rtc", "rtc-soc";
+				interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
 			cpm_sata0: sata at 540000 {
 				compatible = "marvell,armada-8k-ahci",
 					     "generic-ahci";
-- 
2.11.0
