From: josh.wu@atmel.com (Josh Wu)
Date: Tue, 9 Dec 2014 18:54:45 +0800
Subject: [PATCH 1/2] ARM: at91/dt: sama5d3: move wm8904 codec to i2c1
Message-ID: <1418122486-23184-1-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since from rev.D MB, the wm8904 is moved to i2c1.
This patch will adapt to this change.

Signed-off-by: Josh Wu <josh.wu@atmel.com>
---
 arch/arm/boot/dts/sama5d3xmb.dtsi | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/sama5d3xmb.dtsi b/arch/arm/boot/dts/sama5d3xmb.dtsi
index 49c10d3..74bc633 100644
--- a/arch/arm/boot/dts/sama5d3xmb.dtsi
+++ b/arch/arm/boot/dts/sama5d3xmb.dtsi
@@ -38,12 +38,7 @@
 				atmel,clk-from-rk-pin;
 			};
 
-			/*
-			 * i2c0 conflicts with ISI:
-			 * disable it to allow the use of ISI
-			 * can not enable audio when i2c0 disabled
-			 */
-			i2c0: i2c at f0014000 {
+			i2c1: i2c at f0018000 {
 				wm8904: wm8904 at 1a {
 					compatible = "wm8904";
 					reg = <0x1a>;
-- 
1.9.1
