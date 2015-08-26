From: holler@ahsoftware.de (Alexander Holler)
Date: Wed, 26 Aug 2015 14:28:21 +0200
Subject: [PATCH 09/16] deps: dts: imx6q: make some remote-endpoints
 non-dependencies
In-Reply-To: <1440592108-3740-1-git-send-email-holler@ahsoftware.de>
References: <1440592108-3740-1-git-send-email-holler@ahsoftware.de>
Message-ID: <1440592108-3740-10-git-send-email-holler@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is necessary to remove dependency cycles introduced by
'remote-endpoints'.

Signed-off-by: Alexander Holler <holler@ahsoftware.de>
---
 arch/arm/boot/dts/imx6q.dtsi   | 2 ++
 arch/arm/boot/dts/imx6qdl.dtsi | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 399103b..8db7f25 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -184,6 +184,7 @@
 
 				ipu2_di0_hdmi: endpoint at 1 {
 					remote-endpoint = <&hdmi_mux_2>;
+					no-dependencies = <&hdmi_mux_2>;
 				};
 
 				ipu2_di0_mipi: endpoint at 2 {
@@ -205,6 +206,7 @@
 
 				ipu2_di1_hdmi: endpoint at 1 {
 					remote-endpoint = <&hdmi_mux_3>;
+					no-dependencies = <&hdmi_mux_3>;
 				};
 
 				ipu2_di1_mipi: endpoint at 2 {
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index b57033e..db3d0d0 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -1150,10 +1150,12 @@
 
 				ipu1_di0_hdmi: endpoint at 1 {
 					remote-endpoint = <&hdmi_mux_0>;
+					no-dependencies = <&hdmi_mux_0>;
 				};
 
 				ipu1_di0_mipi: endpoint at 2 {
 					remote-endpoint = <&mipi_mux_0>;
+					no-dependencies = <&mipi_mux_0>;
 				};
 
 				ipu1_di0_lvds0: endpoint at 3 {
@@ -1175,10 +1177,12 @@
 
 				ipu1_di1_hdmi: endpoint at 1 {
 					remote-endpoint = <&hdmi_mux_1>;
+					no-dependencies = <&hdmi_mux_1>;
 				};
 
 				ipu1_di1_mipi: endpoint at 2 {
 					remote-endpoint = <&mipi_mux_1>;
+					no-dependencies = <&mipi_mux_1>;
 				};
 
 				ipu1_di1_lvds0: endpoint at 3 {
-- 
2.1.0
