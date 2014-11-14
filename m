From: fkan@apm.com (Feng Kan)
Date: Thu, 13 Nov 2014 16:19:57 -0800
Subject: [PATCH V2 3/7] arm64: dts: Add X-Gene reboot driver dts node
In-Reply-To: <1415924401-3013-1-git-send-email-fkan@apm.com>
References: <1415924401-3013-1-git-send-email-fkan@apm.com>
Message-ID: <1415924401-3013-4-git-send-email-fkan@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add X-Gene platform reboot driver dts node.

Signed-off-by: Feng Kan <fkan@apm.com>
---
 arch/arm64/boot/dts/apm-storm.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/apm-storm.dtsi b/arch/arm64/boot/dts/apm-storm.dtsi
index 6b4c577..9a28d3a 100644
--- a/arch/arm64/boot/dts/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm-storm.dtsi
@@ -103,6 +103,11 @@
 		#size-cells = <2>;
 		ranges;
 
+		scu: system-clk-controller at 17000000 {
+			compatible = "apm,xgene-scu","syscon";
+			reg = <0x0 0x17000000 0x0 0x400>;
+		};
+
 		clocks {
 			#address-cells = <2>;
 			#size-cells = <2>;
@@ -354,6 +359,13 @@
 			};
 		};
 
+		reboot: reboot at 17000014 {
+			compatible = "syscon-reboot";
+			regmap = <&scu>;
+			offset = <0x14>;
+			mask = <0x1>;
+		};
+
 		pcie0: pcie at 1f2b0000 {
 			status = "disabled";
 			device_type = "pci";
-- 
1.9.1
