From: dinguyen@kernel.org (Dinh Nguyen)
Date: Fri,  7 Jul 2017 13:36:47 -0500
Subject: [PATCH] arm64: dts: fix up the gic register for the Stratix10 platform
Message-ID: <1499452607-30058-1-git-send-email-dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The register entries for the ARM GIC-400 should have a 2nd set of address.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
index 23d2ebc..1b035ed 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
@@ -75,10 +75,10 @@
 		compatible = "arm,gic-400", "arm,cortex-a15-gic";
 		#interrupt-cells = <3>;
 		interrupt-controller;
-		reg = <0x0 0xfffc1000 0x1000>,
-		      <0x0 0xfffc2000 0x2000>,
-		      <0x0 0xfffc4000 0x2000>,
-		      <0x0 0xfffc6000 0x2000>;
+		reg = <0x0 0xfffc1000 0x0 0x1000>,
+		      <0x0 0xfffc2000 0x0 0x1000>,
+		      <0x0 0xfffc4000 0x0 0x110>,
+		      <0x0 0xfffc6000 0x0 0x110>;
 	};
 
 	soc {
-- 
2.7.4
