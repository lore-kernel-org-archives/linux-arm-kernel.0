From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 10 Jun 2016 15:23:31 +0200
Subject: [PATCH 03/10] arm64: dts: marvell: add tbg clocks for Armada 37xx
In-Reply-To: <1465565018-14172-1-git-send-email-gregory.clement@free-electrons.com>
References: <1465565018-14172-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1465565018-14172-4-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a new block of clocks. The Time Base Generators clocks can be the
parent of the peripheral clocks.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index 7c61e13a16f3..e9f0b97c63d5 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -105,6 +105,13 @@
 				status = "disabled";
 			};
 
+			tbg: tbg at 13200 {
+				compatible = "marvell,armada-3700-tbg-clock";
+				reg = <0x13200 0x100>;
+				clocks = <&xtalclk>;
+				#clock-cells = <1>;
+			};
+
 			gpio1: gpio at 13800 {
 				compatible = "marvell,mvebu-gpio-3700",
 				"syscon", "simple-mfd";
-- 
2.5.0
