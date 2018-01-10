From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 10 Jan 2018 22:04:16 +0100
Subject: [PATCH] arm64: dts: socfpga: add missing interrupt-parent
Message-ID: <20180110210431.2330267-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PMU node has no working interrupt, as shown by this dtc warning:

arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dtb: Warning (interrupts_property): Missing interrupt-parent for /pmu

This adds an interrupt-parent property so we can correct parse
that interrupt number.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
If this looks ok, I'd apply it directly to the fixes branch
for 4.15, as the warning is one that was introduced in this
release.
---
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
index 7c9bdc7ab50b..9db19314c60c 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
@@ -66,6 +66,7 @@
 				     <&cpu1>,
 				     <&cpu2>,
 				     <&cpu3>;
+		interrupt-parent = <&intc>;
 	};
 
 	psci {
-- 
2.9.0
