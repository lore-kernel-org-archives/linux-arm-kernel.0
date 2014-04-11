From: l.stach@pengutronix.de (Lucas Stach)
Date: Fri, 11 Apr 2014 16:59:38 +0200
Subject: [PATCH 4/6] ARM: dts: vybrid: drop address and size cells from GIC
 node
In-Reply-To: <1397228380-7352-1-git-send-email-l.stach@pengutronix.de>
References: <1397228380-7352-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <1397228380-7352-4-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is likely a copy-and-paste error from the
ARM GIC documentation, that has already been fixed.

address-cells should have been set to 0, as with the size
cells. As having those properties set to 0 is the
same thing as not specifying them, drop them completely.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm/boot/dts/vf610.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/vf610.dtsi b/arch/arm/boot/dts/vf610.dtsi
index 804873367669..bb78e901ed5d 100644
--- a/arch/arm/boot/dts/vf610.dtsi
+++ b/arch/arm/boot/dts/vf610.dtsi
@@ -72,8 +72,6 @@
 			intc: interrupt-controller at 40002000 {
 				compatible = "arm,cortex-a9-gic";
 				#interrupt-cells = <3>;
-				#address-cells = <1>;
-				#size-cells = <1>;
 				interrupt-controller;
 				reg = <0x40003000 0x1000>,
 				      <0x40002100 0x100>;
-- 
1.9.1
