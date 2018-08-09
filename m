From: marek.behun@nic.cz (=?UTF-8?q?Marek=20Beh=C3=BAn?=)
Date: Thu,  9 Aug 2018 04:20:35 +0200
Subject: [PATCH v2 5/7] arm64: dts: marvell: armada-37xx: add nodes to support
 watchdog
In-Reply-To: <20180809022037.12001-1-marek.behun@nic.cz>
References: <20180809022037.12001-1-marek.behun@nic.cz>
Message-ID: <20180809022037.12001-6-marek.behun@nic.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the system controller node for CPU Miscellaneous Registers
(which is needed for the watchdog node) and the watchdog node.

Signed-off-by: Marek Behun <marek.behun@nic.cz>
---
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index 3353252d78a0..b2f041a17d9d 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -65,6 +65,18 @@
 			/* 32M internal register @ 0xd000_0000 */
 			ranges = <0x0 0x0 0xd0000000 0x2000000>;
 
+			wdt: watchdog-timer at 8300 {
+				compatible = "marvell,armada-3700-wdt";
+				reg = <0x8300 0x40>;
+				marvell,system-controller = <&cpu_misc>;
+				clocks = <&xtalclk>;
+			};
+
+			cpu_misc: system-controller at d000 {
+				compatible = "syscon", "simple-mfd";
+				reg = <0xd000 0x1000>;
+			};
+
 			spi0: spi at 10600 {
 				compatible = "marvell,armada-3700-spi";
 				#address-cells = <1>;
-- 
2.16.4
