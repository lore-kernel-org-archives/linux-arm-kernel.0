From: hoegeun.kwon@samsung.com (Hoegeun Kwon)
Date: Tue, 28 Feb 2017 17:17:59 +0900
Subject: [RESEND PATCH v2 5/5] arm: dts: Remove the OF graph from DSI node for
 exynos4210 dts
In-Reply-To: <1488269879-28876-1-git-send-email-hoegeun.kwon@samsung.com>
References: <1488269879-28876-1-git-send-email-hoegeun.kwon@samsung.com>
 <CGME20170228081812epcas5p3bf4f6f273099fbb6e6d26ffbab76f4d7@epcas5p3.samsung.com>
Message-ID: <1488269879-28876-6-git-send-email-hoegeun.kwon@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The OF graph is not needed because the panel is a child of dsi. So
Remove the ports node and move burst and esc clock frequency
properties to the parent (DSI node).

Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
---
 arch/arm/boot/dts/exynos4210-trats.dts | 23 ++---------------------
 1 file changed, 2 insertions(+), 21 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4210-trats.dts b/arch/arm/boot/dts/exynos4210-trats.dts
index 0ca1b4d..9452bed 100644
--- a/arch/arm/boot/dts/exynos4210-trats.dts
+++ b/arch/arm/boot/dts/exynos4210-trats.dts
@@ -197,24 +197,11 @@
 &dsi_0 {
 	vddcore-supply = <&vusb_reg>;
 	vddio-supply = <&vmipi_reg>;
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
 		reg = <0>;
 		compatible = "samsung,s6e8aa0";
@@ -242,12 +229,6 @@
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
