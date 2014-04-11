From: l.stach@pengutronix.de (Lucas Stach)
Date: Fri, 11 Apr 2014 16:59:39 +0200
Subject: [PATCH 5/6] ARM: dts: ste-dbx: drop address cells from GIC node
In-Reply-To: <1397228380-7352-1-git-send-email-l.stach@pengutronix.de>
References: <1397228380-7352-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <1397228380-7352-5-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is likely a copy-and-paste error from the
ARM GIC documentation, that has already been fixed.

address-cells should have been set to 0, as with the size
cells. As having those properties set to 0 is the
same thing as not specifying them, drop them completely.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm/boot/dts/ste-dbx5x0.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/ste-dbx5x0.dtsi b/arch/arm/boot/dts/ste-dbx5x0.dtsi
index e41eedca3ce3..c73414d3fe50 100644
--- a/arch/arm/boot/dts/ste-dbx5x0.dtsi
+++ b/arch/arm/boot/dts/ste-dbx5x0.dtsi
@@ -24,7 +24,6 @@
 		intc: interrupt-controller at a0411000 {
 			compatible = "arm,cortex-a9-gic";
 			#interrupt-cells = <3>;
-			#address-cells = <1>;
 			interrupt-controller;
 			reg = <0xa0411000 0x1000>,
 			      <0xa0410100 0x100>;
-- 
1.9.1
