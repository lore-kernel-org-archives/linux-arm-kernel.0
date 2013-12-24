From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 24 Dec 2013 23:19:36 +0900
Subject: [PATCH 13/21] ARM: shmobile: koelsch: Specify external clock
 frequency in DT
In-Reply-To: <cover.1387893834.git.horms+renesas@verge.net.au>
References: <cover.1387893834.git.horms+renesas@verge.net.au>
Message-ID: <fcf0c725cb38f7d55a89e6f87183afee90a3846d.1387893834.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The external crystal frequency is 20MHz on the Koelsch board. Specify it
in the device tree.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index d431f31..fd556c3 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -45,6 +45,10 @@
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
