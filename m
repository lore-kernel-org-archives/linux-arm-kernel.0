From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue,  2 Jan 2018 15:55:51 +0100
Subject: [PATCH v2 1/8] arm64: dts: marvell: fix watchdog unit address in
 Armada AP806
In-Reply-To: <20180102145558.9773-1-thomas.petazzoni@free-electrons.com>
References: <20180102145558.9773-1-thomas.petazzoni@free-electrons.com>
Message-ID: <20180102145558.9773-2-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes the following DTC warning:

  Warning (simple_bus_reg): Node /ap806/config-space at f0000000/watchdog at 600000 simple-bus unit address format error, expected "610000"

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
index bbc5a4d3acac..36f6d7fbb310 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
@@ -241,7 +241,7 @@
 
 			};
 
-			watchdog: watchdog at 600000 {
+			watchdog: watchdog at 610000 {
 				compatible = "arm,sbsa-gwdt";
 				reg = <0x610000 0x1000>, <0x600000 0x1000>;
 				interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.14.3
