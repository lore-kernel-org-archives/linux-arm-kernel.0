From: fkan@apm.com (Feng Kan)
Date: Wed,  7 May 2014 09:18:01 -0700
Subject: [PATCH V6 2/5] arm64: dts: Add X-Gene reboot driver dts node
In-Reply-To: <1399479484-2605-1-git-send-email-fkan@apm.com>
References: <1399479484-2605-1-git-send-email-fkan@apm.com>
Message-ID: <1399479484-2605-3-git-send-email-fkan@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add X-Gene platform reboot driver dts node.

Signed-off-by: Feng Kan <fkan@apm.com>
---
 arch/arm64/boot/dts/apm-storm.dtsi |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/boot/dts/apm-storm.dtsi b/arch/arm64/boot/dts/apm-storm.dtsi
index 93f4b2d..306a9cd 100644
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
@@ -339,5 +344,12 @@
 			phys = <&phy3 0>;
 			phy-names = "sata-phy";
 		};
+
+		reboot at 17000014 {
+			compatible = "syscon-reboot";
+			regmap = <&scu>;
+			offset = <0x14>;
+			mask = <0x1>;
+		};
 	};
 };
-- 
1.7.6.1
