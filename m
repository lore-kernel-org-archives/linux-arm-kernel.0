From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sun, 30 Jul 2017 13:17:36 +0200
Subject: [PATCH] arm64: dts: realtek: Clean up RTD1295 UART reg property
Message-ID: <20170730111737.22888-1-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The downstream RTD1195 and apparently RTD1295 trees have a modified 8250
serial driver that acknowledges its interrupts using the second reg area,
which is an irq mux.

Drop these unused second reg entries for the UART nodes.

Fixes: 72a7786c0a0d ("ARM64: dts: Add Realtek RTD1295 and Zidoo X9S")
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 arch/arm64/boot/dts/realtek/rtd1295.dtsi | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/realtek/rtd1295.dtsi b/arch/arm64/boot/dts/realtek/rtd1295.dtsi
index d8f84666c8ce..43da91fce2b1 100644
--- a/arch/arm64/boot/dts/realtek/rtd1295.dtsi
+++ b/arch/arm64/boot/dts/realtek/rtd1295.dtsi
@@ -89,8 +89,7 @@
 
 		uart0: serial at 98007800 {
 			compatible = "snps,dw-apb-uart";
-			reg = <0x98007800 0x400>,
-			      <0x98007000 0x100>;
+			reg = <0x98007800 0x400>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clock-frequency = <27000000>;
@@ -99,8 +98,7 @@
 
 		uart1: serial at 9801b200 {
 			compatible = "snps,dw-apb-uart";
-			reg = <0x9801b200 0x100>,
-			      <0x9801b00c 0x100>;
+			reg = <0x9801b200 0x100>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clock-frequency = <432000000>;
@@ -109,8 +107,7 @@
 
 		uart2: serial at 9801b400 {
 			compatible = "snps,dw-apb-uart";
-			reg = <0x9801b400 0x100>,
-			      <0x9801b00c 0x100>;
+			reg = <0x9801b400 0x100>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clock-frequency = <432000000>;
-- 
2.12.3
