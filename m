From: fkan@apm.com (Feng Kan)
Date: Thu, 23 Jan 2014 11:19:59 -0800
Subject: [PATCH V4 3/5] arm64: dts: Add X-Gene reboot driver dts node
In-Reply-To: <1390504801-24483-1-git-send-email-fkan@apm.com>
References: <1390504801-24483-1-git-send-email-fkan@apm.com>
Message-ID: <1390504801-24483-4-git-send-email-fkan@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add X-Gene platform reboot driver dts node.

Signed-off-by: Feng Kan <fkan@apm.com>
---
 arch/arm64/boot/dts/apm-storm.dtsi |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/boot/dts/apm-storm.dtsi b/arch/arm64/boot/dts/apm-storm.dtsi
index d37d736..4ef9d26 100644
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
@@ -187,5 +192,13 @@
 			interrupt-parent = <&gic>;
 			interrupts = <0x0 0x4c 0x4>;
 		};
+
+		reboot at 17000014 {
+			compatible = "syscon-reboot";
+			regmap = <&scu>;
+			offset = <0x14>;
+			mask = <0x1>;
+		};
+
 	};
 };
-- 
1.7.6.1
