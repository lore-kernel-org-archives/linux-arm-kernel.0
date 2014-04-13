From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 13 Apr 2014 16:39:56 +0200
Subject: [PATCH 19/29] ARM: orion5x: add standard pinctrl configs for sata0
 and sata1
In-Reply-To: <1397400006-4315-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397400006-4315-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1397400006-4315-20-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Several platforms will most likely use similar pinctrl configurations
for SATA0 and SATA1, so we declare those common configurations in the
Orion5x DT file.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/orion5x-mv88f5182.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/orion5x-mv88f5182.dtsi b/arch/arm/boot/dts/orion5x-mv88f5182.dtsi
index 11b487c..096ab02 100644
--- a/arch/arm/boot/dts/orion5x-mv88f5182.dtsi
+++ b/arch/arm/boot/dts/orion5x-mv88f5182.dtsi
@@ -18,6 +18,16 @@
 			pinctrl at 10000 {
 				compatible = "marvell,88f5182-pinctrl";
 				reg = <0x10000 0x8>, <0x10050 0x4>;
+
+				pmx_sata0: pmx-sata0 {
+					marvell,pins = "mpp12", "mpp14";
+					marvell,function = "sata0";
+				};
+
+				pmx_sata1: pmx-sata1 {
+					marvell,pins = "mpp13", "mpp15";
+					marvell,function = "sata1";
+				};
 			};
 
 			core_clk: core-clocks at 10030 {
-- 
1.8.3.2
