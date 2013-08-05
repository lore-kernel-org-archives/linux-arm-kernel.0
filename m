From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon,  5 Aug 2013 17:26:06 +0200
Subject: [PATCH] ARM: DTS: SAMA5: Add PMU support
Message-ID: <1375716366-19121-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM Performance Monitor Units are available on the sama5d3, add the support in
the dtsi.

Tested with perf and oprofile on the sama5d31ek.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/sama5d3.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index a1d5e25..afa68ac 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -48,6 +48,11 @@
 		};
 	};
 
+       pmu {
+               compatible = "arm,cortex-a5-pmu";
+               interrupts = <46 IRQ_TYPE_LEVEL_HIGH 0>;
+       };
+
 	memory {
 		reg = <0x20000000 0x8000000>;
 	};
-- 
1.8.1.2
