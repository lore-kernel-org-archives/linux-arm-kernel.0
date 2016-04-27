From: fabio.estevam@nxp.com (Fabio Estevam)
Date: Wed, 27 Apr 2016 11:02:34 -0300
Subject: [PATCH] ARM: dts: imx28-m28: Fix unit-address for partitions
Message-ID: <1461765754-19020-1-git-send-email-fabio.estevam@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to ePAPR v1.1: "The unit-address must match the first address
specified in the reg property of the node"

So do as recommended.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx28-m28.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-m28.dtsi b/arch/arm/boot/dts/imx28-m28.dtsi
index 759cc56..6270701 100644
--- a/arch/arm/boot/dts/imx28-m28.dtsi
+++ b/arch/arm/boot/dts/imx28-m28.dtsi
@@ -34,22 +34,22 @@
 					read-only;
 				};
 
-				partition at 1 {
+				partition at 300000 {
 					label = "environment";
 					reg = <0x00300000 0x00080000>;
 				};
 
-				partition at 2 {
+				partition at 380000 {
 					label = "redundant-environment";
 					reg = <0x00380000 0x00080000>;
 				};
 
-				partition at 3 {
+				partition at 400000 {
 					label = "kernel";
 					reg = <0x00400000 0x00400000>;
 				};
 
-				partition at 4 {
+				partition at 800000 {
 					label = "filesystem";
 					reg = <0x00800000 0x0f800000>;
 				};
-- 
1.9.1
