From: hoegeun.kwon@samsung.com (Hoegeun Kwon)
Date: Fri, 09 Jun 2017 11:59:33 +0900
Subject: [PATCH] ARM: dts: exynos: Add the OF graph between fimd and dsi
References: <CGME20170609025951epcas1p19f5ca8c241b8b79068a84eb239ed46ed@epcas1p1.samsung.com>
Message-ID: <1496977173-20550-1-git-send-email-hoegeun.kwon@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It should be connected to OF graph between fimd and dsi.
Add the OF graph between fimd and dsi.

Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
---
 arch/arm/boot/dts/exynos3250.dtsi | 26 ++++++++++++++++++++++++++
 arch/arm/boot/dts/exynos4.dtsi    | 26 ++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index 590ee44..22d523f 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -311,6 +311,19 @@
 			iommus = <&sysmmu_fimd0>;
 			samsung,sysreg = <&sys_reg>;
 			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 0 {
+					reg = <0>;
+					fimd_to_dsi: endpoint {
+						remote-endpoint =
+							<&dsi_to_fimd>;
+					};
+				};
+			};
 		};
 
 		dsi_0: dsi at 11C80000 {
@@ -326,6 +339,19 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 0 {
+					reg = <0>;
+					dsi_to_fimd: endpoint {
+						remote-endpoint =
+							<&fimd_to_dsi>;
+					};
+				};
+			};
 		};
 
 		sysmmu_fimd0: sysmmu at 11E20000 {
diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index 497a947..773d392 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -193,6 +193,19 @@
 		status = "disabled";
 		#address-cells = <1>;
 		#size-cells = <0>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port at 0 {
+				reg = <0>;
+				dsi_to_fimd: endpoint {
+					remote-endpoint =
+						<&fimd_to_dsi>;
+				};
+			};
+		};
 	};
 
 	camera {
@@ -715,6 +728,19 @@
 		iommus = <&sysmmu_fimd0>;
 		samsung,sysreg = <&sys_reg>;
 		status = "disabled";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port at 0 {
+				reg = <0>;
+				fimd_to_dsi: endpoint {
+					remote-endpoint =
+						<&dsi_to_fimd>;
+				};
+			};
+		};
 	};
 
 	tmu: tmu at 100C0000 {
-- 
1.9.1
