From: moritz.fischer@ettus.com (Moritz Fischer)
Date: Thu, 23 Jul 2015 15:51:01 -0700
Subject: [RFC 2/3] dts: zynq: Add devicetree entry for PL reset controller.
In-Reply-To: <1437691862-21312-1-git-send-email-moritz.fischer@ettus.com>
References: <1437691862-21312-1-git-send-email-moritz.fischer@ettus.com>
Message-ID: <1437691862-21312-3-git-send-email-moritz.fischer@ettus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>
---
 arch/arm/boot/dts/zynq-7000.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
index b429e1d..a56fe11 100644
--- a/arch/arm/boot/dts/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/zynq-7000.dtsi
@@ -258,6 +258,12 @@
 				reg = <0x100 0x100>;
 			};
 
+			rstc: rstc at 240 {
+				#reset-cells = <1>;
+				compatible = "xlnx,zynq-reset-pl";
+				syscon = <&slcr>;
+			};
+
 			pinctrl0: pinctrl at 700 {
 				compatible = "xlnx,pinctrl-zynq";
 				reg = <0x700 0x200>;
-- 
2.4.3
