From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  7 Aug 2013 13:28:35 +0900
Subject: [GIT PULL 14/19] ARM: shmobile: emev2: add PMU information to
 emev2.dtsi
In-Reply-To: <cover.1375838900.git.horms+renesas@verge.net.au>
References: <cover.1375838900.git.horms+renesas@verge.net.au>
Message-ID: <c95ebbb298e698836979ab28ce49383402c22d93.1375838900.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add PMU information to emev2.dtsi. With this
included KZM9D DT reference may use the PMU.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/emev2.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/emev2.dtsi b/arch/arm/boot/dts/emev2.dtsi
index 99ad2b2..9063a44 100644
--- a/arch/arm/boot/dts/emev2.dtsi
+++ b/arch/arm/boot/dts/emev2.dtsi
@@ -46,6 +46,12 @@
 		      <0xe0020000 0x0100>;
 	};
 
+	pmu {
+		compatible = "arm,cortex-a9-pmu";
+		interrupts = <0 120 4>,
+			     <0 121 4>;
+	};
+
 	sti at e0180000 {
 		compatible = "renesas,em-sti";
 		reg = <0xe0180000 0x54>;
-- 
1.8.3.2
