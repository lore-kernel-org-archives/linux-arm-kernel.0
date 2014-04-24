From: tharvey@gateworks.com (Tim Harvey)
Date: Thu, 24 Apr 2014 15:07:25 -0700
Subject: [PATCH 1/3] ARM: dts: imx: Fix LVDS mapping for Ventana GW53xx/GW54xx
In-Reply-To: <1398377247-3901-1-git-send-email-tharvey@gateworks.com>
References: <1398377247-3901-1-git-send-email-tharvey@gateworks.com>
Message-ID: <1398377247-3901-2-git-send-email-tharvey@gateworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GW54xx and GW53xx baseboards use LVDS channel 0 not channel 1.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi | 2 +-
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
index 523f26f..ef7bd99 100644
--- a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
@@ -482,7 +482,7 @@
 &ldb {
 	status = "okay";
 
-	lvds-channel at 1 {
+	lvds-channel at 0 {
 		fsl,data-mapping = "spwg";
 		fsl,data-width = <18>;
 		status = "okay";
diff --git a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
index cab94bf..4ce8f68 100644
--- a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
@@ -504,7 +504,7 @@
 &ldb {
 	status = "okay";
 
-	lvds-channel at 1 {
+	lvds-channel at 0 {
 		fsl,data-mapping = "spwg";
 		fsl,data-width = <18>;
 		status = "okay";
-- 
1.8.3.2
