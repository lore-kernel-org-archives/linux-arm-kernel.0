From: lho@apm.com (Loc Ho)
Date: Fri,  3 Jan 2014 14:23:20 -0700
Subject: [PATCH 1/1] clk: arm64: Fix the clock-names property for pcppll,
 socpll, and socplldiv2
Message-ID: <1388784200-8498-1-git-send-email-lho@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the clock-names property for pcppll, socpll, and socplldiv2
as found by Arnd B. The clock-name property for qmlclk, ethclk, and eth8clk 
will be fixed as part of the Ethernet/QM driver submission.

Signed-off-by: Loc Ho <lho@apm.com>
---
 arch/arm64/boot/dts/apm-storm.dtsi |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/apm-storm.dtsi b/arch/arm64/boot/dts/apm-storm.dtsi
index cd1e012..52ce601 100644
--- a/arch/arm64/boot/dts/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm-storm.dtsi
@@ -118,7 +118,7 @@
 				compatible = "apm,xgene-pcppll-clock";
 				#clock-cells = <1>;
 				clocks = <&refclk 0>;
-				clock-names = "pcppll";
+				clock-names = "refclk";
 				reg = <0x0 0x17000100 0x0 0x1000>;
 				clock-output-names = "pcppll";
 				type = <0>;
@@ -128,7 +128,7 @@
 				compatible = "apm,xgene-socpll-clock";
 				#clock-cells = <1>;
 				clocks = <&refclk 0>;
-				clock-names = "socpll";
+				clock-names = "refclk";
 				reg = <0x0 0x17000120 0x0 0x1000>;
 				clock-output-names = "socpll";
 				type = <1>;
@@ -138,7 +138,7 @@
 				compatible = "fixed-factor-clock";
 				#clock-cells = <1>;
 				clocks = <&socpll 0>;
-				clock-names = "socplldiv2";
+				clock-names = "socpll";
 				clock-mult = <1>;
 				clock-div = <2>;
 				clock-output-names = "socplldiv2";
-- 
1.5.5
