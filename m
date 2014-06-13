From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 13 Jun 2014 19:14:00 +0200
Subject: [PATCH 3/4] of: Add named interrupts to CODA bindings
In-Reply-To: <1402679641-868-1-git-send-email-p.zabel@pengutronix.de>
References: <1402679641-868-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1402679641-868-3-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch documents named interrupt bindings for the CODA
video processing units.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 Documentation/devicetree/bindings/media/coda.txt | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/coda.txt b/Documentation/devicetree/bindings/media/coda.txt
index f5e4d4b..a44c4aa 100644
--- a/Documentation/devicetree/bindings/media/coda.txt
+++ b/Documentation/devicetree/bindings/media/coda.txt
@@ -12,19 +12,24 @@ Required properties:
   (d) "fsl,imx6dl-vpu", "cnm,coda960" for CODA960 present in i.MX6DL/S
 - reg: should be register base and length as documented in the
   SoC reference manual
-- interrupts : Should contain the VPU interrupt. For CODA960,
-  a second interrupt is needed for the MJPEG unit.
+- interrupts : Should contain the VPU (BIT processor) interrupt.
+  For CODA960, a second interrupt is needed for the JPEG unit.
 - clocks : Should contain the ahb and per clocks, in the order
   determined by the clock-names property.
 - clock-names : Should be "ahb", "per"
 - iram : phandle pointing to the SRAM device node
 
+Optional properties:
+- interrupt-names: Should be "bit" for the BIT processor interrupt
+  and "jpeg" for the JPEG unit interrupt on CODA960.
+
 Example:
 
 vpu: vpu at 63ff4000 {
 	compatible = "fsl,imx53-vpu", "cnm,coda7541";
 	reg = <0x63ff4000 0x1000>;
 	interrupts = <9>;
+	interrupt-names = "bit";
 	clocks = <&clks 63>, <&clks 63>;
 	clock-names = "ahb", "per";
 	iram = <&ocram>;
-- 
2.0.0
