From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Thu, 22 Nov 2018 22:40:14 +0100
Subject: [PATCH v2 1/4] dt-bindings: clock: meson8b: export the CPU post
 dividers
In-Reply-To: <20181122214017.25643-1-martin.blumenstingl@googlemail.com>
References: <20181122214017.25643-1-martin.blumenstingl@googlemail.com>
Message-ID: <20181122214017.25643-2-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are four CPU clock post dividers:
- ABP
- PERIPH (used as input for the ARM global timer and ARM TWD timer)
- AXI
- L2 DRAM

Export these so we can use them in .dts files.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Acked-by: Jerome Brunet <jbrunet@baylibre.com>
---
 include/dt-bindings/clock/meson8b-clkc.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/dt-bindings/clock/meson8b-clkc.h b/include/dt-bindings/clock/meson8b-clkc.h
index a60f47b49231..5fe2923382d0 100644
--- a/include/dt-bindings/clock/meson8b-clkc.h
+++ b/include/dt-bindings/clock/meson8b-clkc.h
@@ -103,5 +103,9 @@
 #define CLKID_MPLL1		94
 #define CLKID_MPLL2		95
 #define CLKID_NAND_CLK		112
+#define CLKID_ABP		124
+#define CLKID_PERIPH		126
+#define CLKID_AXI		128
+#define CLKID_L2_DRAM		130
 
 #endif /* __MESON8B_CLKC_H */
-- 
2.19.1
