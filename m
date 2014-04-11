From: l.stach@pengutronix.de (Lucas Stach)
Date: Fri, 11 Apr 2014 16:59:36 +0200
Subject: [PATCH 2/6] ARM: dts: highbank,
 ecx-2000: drop address and size cells from GIC node
In-Reply-To: <1397228380-7352-1-git-send-email-l.stach@pengutronix.de>
References: <1397228380-7352-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <1397228380-7352-2-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is likely a copy-and-paste error from the
ARM GIC documentation, that has already been fixed.

address-cells should have been set to 0, as with the size
cells. As having those properties set to 0 is the
same thing as not specifying them, drop them completely.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm/boot/dts/ecx-2000.dts | 2 --
 arch/arm/boot/dts/highbank.dts | 2 --
 2 files changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/ecx-2000.dts b/arch/arm/boot/dts/ecx-2000.dts
index 2ccbb57fbfa8..cdb7b264b7fb 100644
--- a/arch/arm/boot/dts/ecx-2000.dts
+++ b/arch/arm/boot/dts/ecx-2000.dts
@@ -94,8 +94,6 @@
 		intc: interrupt-controller at fff11000 {
 			compatible = "arm,cortex-a15-gic";
 			#interrupt-cells = <3>;
-			#size-cells = <0>;
-			#address-cells = <1>;
 			interrupt-controller;
 			interrupts = <1 9 0xf04>;
 			reg = <0xfff11000 0x1000>,
diff --git a/arch/arm/boot/dts/highbank.dts b/arch/arm/boot/dts/highbank.dts
index ed14aeac0566..85e1a05b8a9c 100644
--- a/arch/arm/boot/dts/highbank.dts
+++ b/arch/arm/boot/dts/highbank.dts
@@ -109,8 +109,6 @@
 		intc: interrupt-controller at fff11000 {
 			compatible = "arm,cortex-a9-gic";
 			#interrupt-cells = <3>;
-			#size-cells = <0>;
-			#address-cells = <1>;
 			interrupt-controller;
 			reg = <0xfff11000 0x1000>,
 			      <0xfff10100 0x100>;
-- 
1.9.1
