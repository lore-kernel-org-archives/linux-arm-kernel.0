From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Fri,  3 Jun 2016 19:47:12 +0000
Subject: [PATCH 1/2] DT: bindings: remove bcm2835-sdhci
In-Reply-To: <1464983233-27001-1-git-send-email-stefan.wahren@i2se.com>
References: <1464983233-27001-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1464983233-27001-2-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sdhci-iproc also supports bcm2835. So this binding is obsolete.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 .../devicetree/bindings/mmc/brcm,bcm2835-sdhci.txt |   18 ------------------
 1 file changed, 18 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mmc/brcm,bcm2835-sdhci.txt

diff --git a/Documentation/devicetree/bindings/mmc/brcm,bcm2835-sdhci.txt b/Documentation/devicetree/bindings/mmc/brcm,bcm2835-sdhci.txt
deleted file mode 100644
index 59476fb..0000000
--- a/Documentation/devicetree/bindings/mmc/brcm,bcm2835-sdhci.txt
+++ /dev/null
@@ -1,18 +0,0 @@
-Broadcom BCM2835 SDHCI controller
-
-This file documents differences between the core properties described
-by mmc.txt and the properties that represent the BCM2835 controller.
-
-Required properties:
-- compatible : Should be "brcm,bcm2835-sdhci".
-- clocks : The clock feeding the SDHCI controller.
-
-Example:
-
-sdhci: sdhci {
-	compatible = "brcm,bcm2835-sdhci";
-	reg = <0x7e300000 0x100>;
-	interrupts = <2 30>;
-	clocks = <&clk_mmc>;
-	bus-width = <4>;
-};
-- 
1.7.9.5
