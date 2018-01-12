From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 12 Jan 2018 11:00:02 +0100
Subject: [PATCH] arm64: dts: marvell: armada-80x0: Fix pinctrl compatible
 string
Message-ID: <20180112100002.3967-1-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When replacing the cpm by cp0 and cps by cp1 [1] not only the label and
the alias were replaced but also the compatible string which was wrong.

Due to this the pinctrl driver was no more probed.

This patch fix it by reverting this change for the pinctrl compatible
string on Armada 8K.

[1]: "arm64: dts: marvell: replace cpm by cp0, cps by cp1"

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-80x0.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-80x0.dtsi b/arch/arm64/boot/dts/marvell/armada-80x0.dtsi
index 0d36b0fa7153..e9c84a1d3c4d 100644
--- a/arch/arm64/boot/dts/marvell/armada-80x0.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-80x0.dtsi
@@ -108,13 +108,13 @@
 
 &cp0_syscon0 {
 	cp0_pinctrl: pinctrl {
-		compatible = "marvell,armada-8k-cp0-pinctrl";
+		compatible = "marvell,armada-8k-cpm-pinctrl";
 	};
 };
 
 &cp1_syscon0 {
 	cp1_pinctrl: pinctrl {
-		compatible = "marvell,armada-8k-cp1-pinctrl";
+		compatible = "marvell,armada-8k-cps-pinctrl";
 
 		nand_pins: nand-pins {
 			marvell,pins =
-- 
2.15.1
