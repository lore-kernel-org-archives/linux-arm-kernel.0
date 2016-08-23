From: lars.persson@axis.com (Lars Persson)
Date: Tue, 23 Aug 2016 16:00:51 +0200
Subject: [PATCH 2/3] ARM: dts: artpec: use optimized pl310 settings
In-Reply-To: <cover.1471959733.git.larper@axis.com>
References: <cover.1471959733.git.larper@axis.com>
Message-ID: <a84983a0d19a339c1664f239c7d5725ca537eee4.1471959733.git.larper@axis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the cache settings that were determined to give best performance
on artpec-6 typical workloads.

Signed-off-by: Lars Persson <larper@axis.com>
---
 arch/arm/boot/dts/artpec6.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/artpec6.dtsi b/arch/arm/boot/dts/artpec6.dtsi
index db41b52..4e40d55 100644
--- a/arch/arm/boot/dts/artpec6.dtsi
+++ b/arch/arm/boot/dts/artpec6.dtsi
@@ -137,6 +137,13 @@
 		arm,data-latency = <1 1 1>;
 		arm,tag-latency = <1 1 1>;
 		arm,filter-ranges = <0x0 0x80000000>;
+		arm,double-linefill = <1>;
+		arm,double-linefill-incr = <0>;
+		arm,double-linefill-wrap = <0>;
+		prefetch-data = <1>;
+		prefetch-instr = <1>;
+		arm,prefetch-offset = <0>;
+		arm,prefetch-drop = <1>;
 	};
 
 	pmu {
-- 
2.1.4
