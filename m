From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Thu, 25 May 2017 17:28:21 +0800
Subject: [PATCH 4/4] arm64: dts: mt7622: group clock DT nodes into separate DT
 file
In-Reply-To: <cover.1495703415.git.sean.wang@mediatek.com>
References: <cover.1495703415.git.sean.wang@mediatek.com>
Message-ID: <2f620561c49e923badff5118447db17f2cf09514.1495703415.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

For more readability and maintenance, all the clock related DT
nodes for mt7622 SoC are grouped into a separate DT file. And
currently mt7622-clock.dtsi only includes the fixed clock for
uart0 and the oscillator which would be extended after MT7622
clock driver is introduced.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt7622-clock.dtsi | 20 ++++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt7622.dtsi       |  1 +
 2 files changed, 21 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt7622-clock.dtsi

diff --git a/arch/arm64/boot/dts/mediatek/mt7622-clock.dtsi b/arch/arm64/boot/dts/mediatek/mt7622-clock.dtsi
new file mode 100644
index 0000000..6b1c3db
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt7622-clock.dtsi
@@ -0,0 +1,20 @@
+/*
+ * Copyright (c) 2017 MediaTek Inc.
+ * Author: Sean Wang <sean.wang@mediatek.com>
+ *
+ * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+ */
+/ {
+	clk25m: oscillator at 0 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <25000000>;
+		clock-output-names = "clkxtal";
+	};
+
+	uart_clk: dummy26m {
+		compatible = "fixed-clock";
+		clock-frequency = <25000000>;
+		#clock-cells = <0>;
+	};
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
index f610d30..c192fb9 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
@@ -8,6 +8,7 @@
 
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include "mt7622-clock.dtsi"
 
 / {
 	compatible = "mediatek,mt7622";
-- 
1.9.1
