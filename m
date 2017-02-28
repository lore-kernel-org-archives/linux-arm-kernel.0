From: hoegeun.kwon@samsung.com (Hoegeun Kwon)
Date: Tue, 28 Feb 2017 17:17:58 +0900
Subject: [RESEND PATCH v2 4/5] arm: dts: Remove the OF graph from DSI node for
 exynos4412 dts
In-Reply-To: <1488269879-28876-1-git-send-email-hoegeun.kwon@samsung.com>
References: <1488269879-28876-1-git-send-email-hoegeun.kwon@samsung.com>
 <CGME20170228081812epcas5p3d20eddc91da42ec4a0d973ddc59d184a@epcas5p3.samsung.com>
Message-ID: <1488269879-28876-5-git-send-email-hoegeun.kwon@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The OF graph is not needed because the panel is a child of dsi. So
Remove the ports node and move burst and esc clock frequency
properties to the parent (DSI node).

Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
---
 arch/arm/boot/dts/exynos4412-trats2.dts | 23 ++---------------------
 1 file changed, 2 insertions(+), 21 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
index 41ecd6d..86ce5e5 100644
--- a/arch/arm/boot/dts/exynos4412-trats2.dts
+++ b/arch/arm/boot/dts/exynos4412-trats2.dts
@@ -385,24 +385,11 @@
 &dsi_0 {
 	vddcore-supply = <&ldo8_reg>;
 	vddio-supply = <&ldo10_reg>;
+	samsung,burst-clock-frequency = <500000000>;
+	samsung,esc-clock-frequency = <20000000>;
 	samsung,pll-clock-frequency = <24000000>;
 	status = "okay";
 
-	ports {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		port at 1 {
-			reg = <1>;
-
-			dsi_out: endpoint {
-				remote-endpoint = <&dsi_in>;
-				samsung,burst-clock-frequency = <500000000>;
-				samsung,esc-clock-frequency = <20000000>;
-			};
-		};
-	};
-
 	panel at 0 {
 		compatible = "samsung,s6e8aa0";
 		reg = <0>;
@@ -430,12 +417,6 @@
 				vsync-len = <2>;
 			};
 		};
-
-		port {
-			dsi_in: endpoint {
-				remote-endpoint = <&dsi_out>;
-			};
-		};
 	};
 };
 
-- 
1.9.1
