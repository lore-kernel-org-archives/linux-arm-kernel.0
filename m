From: antoine.tenart@free-electrons.com (=?UTF-8?q?Antoine=20T=C3=A9nart?=)
Date: Wed, 16 Apr 2014 14:40:09 +0200
Subject: [PATCH 2/4] Documentation: bindings: add the sdhci-berlin
In-Reply-To: <1397652011-21284-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1397652011-21284-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1397652011-21284-3-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the binding documentation for the Marvell Berlin SDHCI driver.

Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
---
 Documentation/devicetree/bindings/mmc/sdhci-berlin.txt | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-berlin.txt

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-berlin.txt b/Documentation/devicetree/bindings/mmc/sdhci-berlin.txt
new file mode 100644
index 000000000000..1a5591f85a64
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/sdhci-berlin.txt
@@ -0,0 +1,18 @@
+* Marvell Berlin SDHCI controller
+
+All common properties are documented in mmc.txt
+
+Required properties:
+- compatible: "marvell,berlin2-sdhci",
+	      "marvell,berlin2cd-sdhci",
+	      "marvell,berlin2q-sdhci"
+- clocks: reference to the SDHCI controller clock
+
+Example:
+
+sdhci0: sdhci at ab0000 {
+	compatible = "marvell,berlin2q-sdhci";
+	reg = <0xab0000 0x200>;
+	clocks = <&sdio1clk>;
+	interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
+};
-- 
1.8.3.2
