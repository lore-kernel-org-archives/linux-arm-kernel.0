From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  4 Nov 2014 10:50:33 +0900
Subject: [PATCH 10/10] ARM: shmobile: koelsch: Enable DU device in DT
In-Reply-To: <cover.1415058552.git.horms+renesas@verge.net.au>
References: <cover.1415058552.git.horms+renesas@verge.net.au>
Message-ID: <0ee56d403549fd97d8acac6b7ba3a17f6999c30a.1415058552.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Specify the DU output topology, enable the DU device and configure the
related pins.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index 07550e7..4f4e56e5 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -211,14 +211,24 @@
 	};
 };
 
+&du {
+	pinctrl-0 = <&du_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	ports {
+		port at 1 {
+			lvds_connector: endpoint {
+			};
+		};
+	};
+};
+
 &extal_clk {
 	clock-frequency = <20000000>;
 };
 
 &pfc {
-	pinctrl-0 = <&du_pins>;
-	pinctrl-names = "default";
-
 	i2c2_pins: i2c2 {
 		renesas,groups = "i2c2";
 		renesas,function = "i2c2";
-- 
2.1.1
