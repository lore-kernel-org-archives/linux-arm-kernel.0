From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Mon, 31 Jul 2017 15:36:43 +0800
Subject: [PATCH v5 10/10] arm: dts: mt7623: add clock-frequency to CPU nodes
In-Reply-To: <cover.1501486190.git.sean.wang@mediatek.com>
References: <cover.1501486190.git.sean.wang@mediatek.com>
Message-ID: <878bfa648e0a8c4ec4e2a400e2b45a803e808abc.1501486190.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Add clock-frequency property to CPU nodes. Avoids warnings like
[    0.001568] /cpus/cpu at 0 missing clock-frequency property
[    0.001588] /cpus/cpu at 1 missing clock-frequency property
[    0.001601] /cpus/cpu at 2 missing clock-frequency property
[    0.001614] /cpus/cpu at 3 missing clock-frequency property
at boot time

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 arch/arm/boot/dts/mt7623.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
index 86cab5c..4ae0ab0 100644
--- a/arch/arm/boot/dts/mt7623.dtsi
+++ b/arch/arm/boot/dts/mt7623.dtsi
@@ -89,24 +89,28 @@
 			#cooling-cells = <2>;
 			cooling-min-level = <0>;
 			cooling-max-level = <7>;
+			clock-frequency = <1300000000>;
 		};
 		cpu1: cpu at 1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a7";
 			reg = <0x1>;
 			operating-points-v2 = <&cpu_opp_table>;
+			clock-frequency = <1300000000>;
 		};
 		cpu2: cpu at 2 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a7";
 			reg = <0x2>;
 			operating-points-v2 = <&cpu_opp_table>;
+			clock-frequency = <1300000000>;
 		};
 		cpu3: cpu at 3 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a7";
 			reg = <0x3>;
 			operating-points-v2 = <&cpu_opp_table>;
+			clock-frequency = <1300000000>;
 		};
 	};
 
-- 
2.7.4
