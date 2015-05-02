From: manabian@gmail.com (Joachim Eastwood)
Date: Sat,  2 May 2015 18:40:42 +0200
Subject: [PATCH 2/2] doc: dt: add documentation for nxp,lpc1850-dwmac
In-Reply-To: <1430584842-23408-1-git-send-email-manabian@gmail.com>
References: <1430584842-23408-1-git-send-email-manabian@gmail.com>
Message-ID: <1430584842-23408-3-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 .../devicetree/bindings/net/nxp,lpc1850-dwmac.txt    | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/nxp,lpc1850-dwmac.txt

diff --git a/Documentation/devicetree/bindings/net/nxp,lpc1850-dwmac.txt b/Documentation/devicetree/bindings/net/nxp,lpc1850-dwmac.txt
new file mode 100644
index 000000000000..7edba1264f6f
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/nxp,lpc1850-dwmac.txt
@@ -0,0 +1,20 @@
+* NXP LPC1850 GMAC ethernet controller
+
+This device is a platform glue layer for stmmac.
+Please see stmmac.txt for the other unchanged properties.
+
+Required properties:
+ - compatible:  Should contain "nxp,lpc1850-dwmac"
+
+Examples:
+
+mac: ethernet at 40010000 {
+	compatible = "nxp,lpc1850-dwmac", "snps,dwmac-3.611", "snps,dwmac";
+	reg = <0x40010000 0x2000>;
+	interrupts = <5>;
+	interrupt-names = "macirq";
+	clocks = <&ccu1 CLK_CPU_ETHERNET>;
+	clock-names = "stmmaceth";
+	resets = <&rgu 22>;
+	reset-names = "stmmaceth";
+}
-- 
1.8.0
