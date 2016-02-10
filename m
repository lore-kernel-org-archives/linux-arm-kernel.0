From: anup.patel@broadcom.com (Anup Patel)
Date: Wed, 10 Feb 2016 11:40:49 +0530
Subject: [PATCH 4/6] dt-bindings: watchdog: Add ARM SP805 DT bindings
In-Reply-To: <1455084651-29325-1-git-send-email-anup.patel@broadcom.com>
References: <1455084651-29325-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1455084651-29325-5-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM SP805 DT node is already present in various DTS files.
This patch adds missing DT bindings documentation for ARM SP805.

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
Reviewed-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Vikram Prakash <vikramp@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
---
 .../devicetree/bindings/watchdog/arm,sp805.txt          | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/arm,sp805.txt

diff --git a/Documentation/devicetree/bindings/watchdog/arm,sp805.txt b/Documentation/devicetree/bindings/watchdog/arm,sp805.txt
new file mode 100644
index 0000000..6ebb77d
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/arm,sp805.txt
@@ -0,0 +1,17 @@
+ARM AMBA Primecell SP805 Watchdog
+
+Required properties:
+- compatible: Should be "arm,sp805" & "arm,primecell"
+- reg: Should contain location and length for watchdog timer register.
+- interrupts: Should contain the list of watchdog timer interrupts.
+- clocks: clocks driving the watchdog timer hardware. This list should be 2
+	clocks. With 2 clocks, the order is wdogclk clock, apb_pclk.
+
+Example:
+	wdt at 66090000 {
+		compatible = "arm,sp805", "arm,primecell";
+		reg = <0x66090000 0x1000>;
+		interrupts = <GIC_SPI 406 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&apb_pclk>,<&apb_pclk>;
+		clock-names = "wdogclk", "apb_pclk";
+	};
-- 
1.9.1
