From: joel@jms.id.au (Joel Stanley)
Date: Wed,  4 Oct 2017 19:46:34 +1030
Subject: [PATCH 1/2] ARM: dts: aspeed: Remove undocumented wdt properties
In-Reply-To: <20171004091635.12499-1-joel@jms.id.au>
References: <20171004091635.12499-1-joel@jms.id.au>
Message-ID: <20171004091635.12499-2-joel@jms.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The watchdog bindings do not describe an interrupt property nor clock
phandle, and the upstream driver never had code to use them. Drop them
from the device tree.

Also rename the node from wdt the more commonly used watchdog.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/arm/boot/dts/aspeed-g4.dtsi | 7 ++-----
 arch/arm/boot/dts/aspeed-g5.dtsi | 8 +++-----
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index e455bd236798..5be2e6a39917 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -204,17 +204,14 @@
 				status = "disabled";
 			};
 
-			wdt1: wdt at 1e785000 {
+			wdt1: watchdog at 1e785000 {
 				compatible = "aspeed,ast2400-wdt";
 				reg = <0x1e785000 0x1c>;
-				interrupts = <27>;
 			};
 
-			wdt2: wdt at 1e785020 {
+			wdt2: watchdog at 1e785020 {
 				compatible = "aspeed,ast2400-wdt";
 				reg = <0x1e785020 0x1c>;
-				interrupts = <27>;
-				clocks = <&clk_apb>;
 				status = "disabled";
 			};
 
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 77dded187d5a..71e1264b81aa 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -248,20 +248,18 @@
 				status = "disabled";
 			};
 
-			wdt1: wdt at 1e785000 {
+			wdt1: watchdog at 1e785000 {
 				compatible = "aspeed,ast2500-wdt";
 				reg = <0x1e785000 0x20>;
-				interrupts = <27>;
 			};
 
-			wdt2: wdt at 1e785020 {
+			wdt2: watchdog at 1e785020 {
 				compatible = "aspeed,ast2500-wdt";
 				reg = <0x1e785020 0x20>;
-				interrupts = <27>;
 				status = "disabled";
 			};
 
-			wdt3: wdt at 1e785040 {
+			wdt3: watchdog at 1e785040 {
 				compatible = "aspeed,ast2500-wdt";
 				reg = <0x1e785040 0x20>;
 				status = "disabled";
-- 
2.14.1
