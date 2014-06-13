From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 13 Jun 2014 19:13:59 +0200
Subject: [PATCH 2/4] of: Add new compatibles for CODA bindings
In-Reply-To: <1402679641-868-1-git-send-email-p.zabel@pengutronix.de>
References: <1402679641-868-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1402679641-868-2-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds new compatibles using the new Chips&Media vendor
prefix "cnm" and CODA model name as well as a Freescale specific
compatible value for i.MX6DL/S.
The latter is because for some reason the i.MX6DL/S firmware
provided by Freescale differs from the i.MX6Q/D version.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 Documentation/devicetree/bindings/media/coda.txt | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/coda.txt b/Documentation/devicetree/bindings/media/coda.txt
index 2865d04..f5e4d4b 100644
--- a/Documentation/devicetree/bindings/media/coda.txt
+++ b/Documentation/devicetree/bindings/media/coda.txt
@@ -5,10 +5,11 @@ Coda codec IPs are present in i.MX SoCs in various versions,
 called VPU (Video Processing Unit).
 
 Required properties:
-- compatible : should be "fsl,<chip>-src" for i.MX SoCs:
-  (a) "fsl,imx27-vpu" for CodaDx6 present in i.MX27
-  (b) "fsl,imx53-vpu" for CODA7541 present in i.MX53
-  (c) "fsl,imx6q-vpu" for CODA960 present in i.MX6q
+- compatible : should be "fsl,<chip>-src", "cnm,coda<model>" for i.MX SoCs:
+  (a) "fsl,imx27-vpu", "cnm,codadx6" for CodaDx6 present in i.MX27
+  (b) "fsl,imx53-vpu", "cnm,coda7541" for CODA7541 present in i.MX53
+  (c) "fsl,imx6q-vpu", "cnm,coda960" for CODA960 present in i.MX6Q/D
+  (d) "fsl,imx6dl-vpu", "cnm,coda960" for CODA960 present in i.MX6DL/S
 - reg: should be register base and length as documented in the
   SoC reference manual
 - interrupts : Should contain the VPU interrupt. For CODA960,
@@ -21,7 +22,7 @@ Required properties:
 Example:
 
 vpu: vpu at 63ff4000 {
-	compatible = "fsl,imx53-vpu";
+	compatible = "fsl,imx53-vpu", "cnm,coda7541";
 	reg = <0x63ff4000 0x1000>;
 	interrupts = <9>;
 	clocks = <&clks 63>, <&clks 63>;
-- 
2.0.0
