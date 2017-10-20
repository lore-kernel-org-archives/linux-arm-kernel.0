From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 20 Oct 2017 12:28:56 +0200
Subject: [PATCH 29/42] ARM: dts: r8a73a4: Add clock for CA15 CPU0 core
In-Reply-To: <cover.1508493785.git.horms+renesas@verge.net.au>
References: <cover.1508493785.git.horms+renesas@verge.net.au>
Message-ID: <a7869a5bc82682ac31452e178b4b3e9f8b48e7df.1508493785.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Improve hardware description by adding a clocks property to the device
node corresponding to the primary CA15 CPU core, which is for now the
only one described.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a73a4.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
index 310222634570..dd4d09712a2a 100644
--- a/arch/arm/boot/dts/r8a73a4.dtsi
+++ b/arch/arm/boot/dts/r8a73a4.dtsi
@@ -27,6 +27,7 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a15";
 			reg = <0>;
+			clocks = <&cpg_clocks R8A73A4_CLK_Z>;
 			clock-frequency = <1500000000>;
 			power-domains = <&pd_a2sl>;
 			next-level-cache = <&L2_CA15>;
-- 
2.11.0
