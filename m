From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon, 17 Nov 2014 14:53:05 +0100
Subject: [PATCH 1/4] ARM: shmobile: r8a7740 dtsi: Add cache-controller node
In-Reply-To: <1416232388-2611-1-git-send-email-geert+renesas@glider.be>
References: <1416232388-2611-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1416232388-2611-2-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the missing cache-controller node. This will allow migration to the
generic l2c OF initialization.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: devicetree at vger.kernel.org
---
Note: This depends on "[PATCH v5 7/8] ARM: shmobile: r8a7740 dtsi: Add
      PM domain support" due to the pd_a3sm reference.
---
 arch/arm/boot/dts/r8a7740.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index e2c9496c2c325a1f..a9c7a986c0e9eca6 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -37,6 +37,17 @@
 		      <0xc2000000 0x1000>;
 	};
 
+	L2: cache-controller {
+		compatible = "arm,pl310-cache";
+		reg = <0xf0100000 0x1000>;
+		interrupts = <84>;
+		power-domains = <&pd_a3sm>;
+		arm,data-latency = <3 3 3>;
+		arm,tag-latency = <2 2 2>;
+		cache-unified;
+		cache-level = <2>;
+	};
+
 	pmu {
 		compatible = "arm,cortex-a9-pmu";
 		interrupts = <0 83 IRQ_TYPE_LEVEL_HIGH>;
-- 
1.9.1
