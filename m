From: hoegeun.kwon@samsung.com (Hoegeun Kwon)
Date: Mon, 06 Mar 2017 13:42:22 +0900
Subject: [PATCH v4 4/5] arm64: dts: exynos: Remove the OF graph from DSI node
In-Reply-To: <1488775343-6236-1-git-send-email-hoegeun.kwon@samsung.com>
References: <1488775343-6236-1-git-send-email-hoegeun.kwon@samsung.com>
 <CGME20170306044237epcas5p35d955ba5e849a8ebcf13007ab1b377dc@epcas5p3.samsung.com>
Message-ID: <1488775343-6236-5-git-send-email-hoegeun.kwon@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The OF graph is not needed because the panel is a child of dsi. Remove
the ports node in DSI node.

Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
index e31e20c..77ba238 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
@@ -303,20 +303,6 @@
 	samsung,pll-clock-frequency = <24000000>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&te_irq>;
-
-	ports {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		port at 1 {
-			reg = <1>;
-
-			dsi_out: endpoint {
-				samsung,burst-clock-frequency = <512000000>;
-				samsung,esc-clock-frequency = <16000000>;
-			};
-		};
-	};
 };
 
 &hdmi {
-- 
1.9.1
