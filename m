From: b44548@freescale.com (Chao Fu)
Date: Thu, 25 Sep 2014 18:24:25 +0800
Subject: [PATCH 3/3] Documentation:spi:fsl-dspi:add DSPI tcf transfer support
In-Reply-To: <1411640665-20671-1-git-send-email-b44548@freescale.com>
References: <1411640665-20671-1-git-send-email-b44548@freescale.com>
Message-ID: <1411640665-20671-3-git-send-email-b44548@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chao Fu <B44548@freescale.com>

Add bool value tcfq-mode or eoq-mode.
The bool will determine DSPI transfer data mode (tcfq or eoq)
in a platform.

Signed-off-by: Chao Fu      <b44548@freescale.com>
---
 Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt b/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
index cbbe16e..635387c 100644
--- a/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
+++ b/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
@@ -10,6 +10,8 @@ Required properties:
 - pinctrl-names: must contain a "default" entry.
 - spi-num-chipselects : the number of the chipselect signals.
 - bus-num : the slave chip chipselect signal number.
+- eoq-mode/tcfq-mode: enable EOQ/TCFQ interrupt to receive data
+	according to different platform.
 
 Optional property:
 - big-endian: If present the dspi device's registers are implemented
@@ -28,6 +30,7 @@ dspi0 at 4002c000 {
 	clock-names = "dspi";
 	spi-num-chipselects = <5>;
 	bus-num = <0>;
+	eoq-mode;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_dspi0_1>;
 	big-endian;
-- 
1.8.4
