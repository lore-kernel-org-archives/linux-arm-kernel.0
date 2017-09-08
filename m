From: dinguyen@kernel.org (Dinh Nguyen)
Date: Fri,  8 Sep 2017 10:48:53 -0500
Subject: [PATCH 1/2] arm64: dts: stratix10: fix up the gic register for the
 Stratix10 platform
Message-ID: <1504885734-9618-1-git-send-email-dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The register entries for the ARM GIC-400 should have a 2nd set of address.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
index c2b9bcb..631e09a 100644
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
+		      <0x0 0xfffc2000 0x0 0x2000>,
+		      <0x0 0xfffc4000 0x0 0x2000>,
+		      <0x0 0xfffc6000 0x0 0x2000>;
 	};
 
 	soc {
-- 
2.7.4
