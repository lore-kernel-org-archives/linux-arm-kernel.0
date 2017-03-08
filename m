From: hoegeun.kwon@samsung.com (Hoegeun Kwon)
Date: Wed, 08 Mar 2017 13:54:12 +0900
Subject: [PATCH v5 5/5] arm: dts: Remove the OF graph from DSI node
In-Reply-To: <1488948852-5380-1-git-send-email-hoegeun.kwon@samsung.com>
References: <1488948852-5380-1-git-send-email-hoegeun.kwon@samsung.com>
 <CGME20170308045503epcas1p2759ce089ec0e0d0a79c7d88e45efe9cc@epcas1p2.samsung.com>
Message-ID: <1488948852-5380-6-git-send-email-hoegeun.kwon@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The OF graph is not needed because the panel is a child of dsi. Remove
the ports node in DSI node, and port node in panel node.

Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Reviewed-by: Andi Shyti <andi.shyti@samsung.com>
---
 arch/arm/boot/dts/exynos3250-rinato.dts | 21 ---------------------
 arch/arm/boot/dts/exynos4210-trats.dts  | 21 ---------------------
 arch/arm/boot/dts/exynos4412-trats2.dts | 21 ---------------------
 3 files changed, 63 deletions(-)

diff --git a/arch/arm/boot/dts/exynos3250-rinato.dts b/arch/arm/boot/dts/exynos3250-rinato.dts
index c9f191c..82e676a 100644
--- a/arch/arm/boot/dts/exynos3250-rinato.dts
+++ b/arch/arm/boot/dts/exynos3250-rinato.dts
@@ -220,21 +220,6 @@
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
-				samsung,burst-clock-frequency = <250000000>;
-				samsung,esc-clock-frequency = <20000000>;
-			};
-		};
-	};
-
 	panel at 0 {
 		compatible = "samsung,s6e63j0x03";
 		reg = <0>;
@@ -264,12 +249,6 @@
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
 
diff --git a/arch/arm/boot/dts/exynos4210-trats.dts b/arch/arm/boot/dts/exynos4210-trats.dts
index 1743ca8..9452bed 100644
--- a/arch/arm/boot/dts/exynos4210-trats.dts
+++ b/arch/arm/boot/dts/exynos4210-trats.dts
@@ -202,21 +202,6 @@
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
@@ -244,12 +229,6 @@
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
 
diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
index 82221a0..86ce5e5 100644
--- a/arch/arm/boot/dts/exynos4412-trats2.dts
+++ b/arch/arm/boot/dts/exynos4412-trats2.dts
@@ -390,21 +390,6 @@
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
@@ -432,12 +417,6 @@
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
