From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Thu, 17 Aug 2017 13:20:25 +0200
Subject: [RFC 4/4] arm64: dts: realtek: Update RTD1295 UART nodes with clocks
In-Reply-To: <20170817112026.24062-1-afaerber@suse.de>
References: <20170817112026.24062-1-afaerber@suse.de>
Message-ID: <20170817112026.24062-5-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace clock-frequency with a reference to the respective clock gates.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 arch/arm64/boot/dts/realtek/rtd1295.dtsi | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/realtek/rtd1295.dtsi b/arch/arm64/boot/dts/realtek/rtd1295.dtsi
index 078a11506876..503e2d5fc334 100644
--- a/arch/arm64/boot/dts/realtek/rtd1295.dtsi
+++ b/arch/arm64/boot/dts/realtek/rtd1295.dtsi
@@ -6,6 +6,7 @@
  * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
  */
 
+#include <dt-bindings/clock/realtek,rtd1295.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/reset/realtek,rtd1295.h>
 
@@ -152,7 +153,7 @@
 			reg = <0x98007800 0x400>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clock-frequency = <27000000>;
+			clocks = <&iso_clkc RTD1295_ISO_CLK_EN_MISC_UR0>;
 			interrupt-parent = <&iso_irq_mux>;
 			interrupts = <2>;
 			resets = <&iso_reset RTD1295_ISO_RSTN_UR0>;
@@ -172,7 +173,7 @@
 			reg = <0x9801b200 0x100>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clock-frequency = <432000000>;
+			clocks = <&clkc RTD1295_CLK_EN_UR1>;
 			interrupt-parent = <&irq_mux>;
 			interrupts = <3>, <5>;
 			resets = <&reset2 RTD1295_RSTN_UR1>;
@@ -184,7 +185,7 @@
 			reg = <0x9801b400 0x100>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clock-frequency = <432000000>;
+			clocks = <&clkc RTD1295_CLK_EN_UR2>;
 			interrupt-parent = <&irq_mux>;
 			interrupts = <8>, <13>;
 			resets = <&reset2 RTD1295_RSTN_UR2>;
-- 
2.12.3
