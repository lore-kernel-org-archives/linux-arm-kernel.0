From: joel@jms.id.au (Joel Stanley)
Date: Wed,  4 Oct 2017 19:46:35 +1030
Subject: [PATCH 2/2] ARM: dts: aspeed: Enable watchdog two
In-Reply-To: <20171004091635.12499-1-joel@jms.id.au>
References: <20171004091635.12499-1-joel@jms.id.au>
Message-ID: <20171004091635.12499-3-joel@jms.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The second watchdog is left running by u-boot in the common
configurations of the firmware shipped on ASPEED boards. Ensure a driver
is loaded so the system can succcessfully boot.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/arm/boot/dts/aspeed-g4.dtsi | 1 -
 arch/arm/boot/dts/aspeed-g5.dtsi | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index 5be2e6a39917..9bf84d2ba038 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -212,7 +212,6 @@
 			wdt2: watchdog at 1e785020 {
 				compatible = "aspeed,ast2400-wdt";
 				reg = <0x1e785020 0x1c>;
-				status = "disabled";
 			};
 
 			vuart: serial at 1e787000 {
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 71e1264b81aa..ca023e9ab0b8 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -256,7 +256,6 @@
 			wdt2: watchdog at 1e785020 {
 				compatible = "aspeed,ast2500-wdt";
 				reg = <0x1e785020 0x20>;
-				status = "disabled";
 			};
 
 			wdt3: watchdog at 1e785040 {
-- 
2.14.1
