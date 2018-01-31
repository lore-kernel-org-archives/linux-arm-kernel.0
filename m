From: a.hajda@samsung.com (Andrzej Hajda)
Date: Wed, 31 Jan 2018 14:44:33 +0100
Subject: [RFC PATCH v2 3/5] arm64: dts: exynos: add OF graph between MHL and
 USB connector
In-Reply-To: <20180131134435.12216-1-a.hajda@samsung.com>
References: <20180131134435.12216-1-a.hajda@samsung.com>
 <CGME20180131134458eucas1p15d3eaae8dce09aa348e9458840c2ea20@eucas1p1.samsung.com>
Message-ID: <20180131134435.12216-4-a.hajda@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OF graph describes MHL data lanes between MHL and respective USB
connector.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
 .../boot/dts/exynos/exynos5433-tm2-common.dtsi     | 31 +++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
index e5a6a2303060..427ff861b441 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
@@ -779,9 +779,22 @@
 		clocks = <&pmu_system_controller 0>;
 		clock-names = "xtal";
 
-		port {
-			mhl_to_hdmi: endpoint {
-				remote-endpoint = <&hdmi_to_mhl>;
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port at 0 {
+				reg = <0>;
+				mhl_to_hdmi: endpoint {
+					remote-endpoint = <&hdmi_to_mhl>;
+				};
+			};
+
+			port at 1 {
+				reg = <1>;
+				mhl_to_musb_con: endpoint {
+					remote-endpoint = <&musb_con_to_mhl>;
+				};
 			};
 		};
 	};
@@ -803,6 +816,18 @@
 				compatible = "usb-b-connector";
 				label = "micro-USB";
 				type = "micro";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port at 3 {
+						musb_con_to_mhl: endpoint {
+							remote-endpoint = <&mhl_to_musb_con>;
+						};
+					};
+				};
+			};
 			};
 		};
 
-- 
2.15.1
