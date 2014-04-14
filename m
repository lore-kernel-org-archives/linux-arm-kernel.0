From: l.stach@pengutronix.de (Lucas Stach)
Date: Mon, 14 Apr 2014 16:18:15 +0200
Subject: [PATCH v2 3/6] ARM: dts: zynq: drop address cells from GIC node
In-Reply-To: <1397485098-19198-1-git-send-email-l.stach@pengutronix.de>
References: <1397485098-19198-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <1397485098-19198-3-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is likely a copy-and-paste error from the
ARM GIC documentation, that has already been fixed.

address-cells should have been set to 0, as with the size
cells. As having those properties set to 0 is the
same thing as not specifying them, drop them completely.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Acked-by: Rob Herring <robh@kernel.org>
---
v2: no change, added ack
---
 arch/arm/boot/dts/zynq-7000.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
index 511180769af5..3f277c2bc19c 100644
--- a/arch/arm/boot/dts/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/zynq-7000.dtsi
@@ -57,7 +57,6 @@
 		intc: interrupt-controller at f8f01000 {
 			compatible = "arm,cortex-a9-gic";
 			#interrupt-cells = <3>;
-			#address-cells = <1>;
 			interrupt-controller;
 			reg = <0xF8F01000 0x1000>,
 			      <0xF8F00100 0x100>;
-- 
1.9.1
