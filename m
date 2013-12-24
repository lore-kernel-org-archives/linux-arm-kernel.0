From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 24 Dec 2013 23:19:35 +0900
Subject: [PATCH 12/21] ARM: shmobile: lager: Specify external clock frequency
 in DT
In-Reply-To: <cover.1387893834.git.horms+renesas@verge.net.au>
References: <cover.1387893834.git.horms+renesas@verge.net.au>
Message-ID: <62e43056ad5f584f8af83267c901f65e667e3657.1387893834.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The external crystal frequency is 20MHz on the Lager board. Specify it
in the device tree.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 67a6939..57569cb 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -58,6 +58,10 @@
 	};
 };
 
+&extal_clk {
+	clock-frequency = <20000000>;
+};
+
 &pfc {
 	pinctrl-0 = <&scif0_pins &scif1_pins>;
 	pinctrl-names = "default";
-- 
1.8.4
