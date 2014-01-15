From: fkan@apm.com (Feng Kan)
Date: Tue, 14 Jan 2014 17:07:33 -0800
Subject: [PATCH V3 1/3] arm64: add reboot dts entry for X-Gene platform.
In-Reply-To: <1389748055-23534-1-git-send-email-fkan@apm.com>
References: <1389748055-23534-1-git-send-email-fkan@apm.com>
Message-ID: <1389748055-23534-2-git-send-email-fkan@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing dts entries for the X-Gene reboot driver.

Signed-off-by: Feng Kan <fkan@apm.com>
---
 arch/arm64/boot/dts/apm-storm.dtsi |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/boot/dts/apm-storm.dtsi b/arch/arm64/boot/dts/apm-storm.dtsi
index d37d736..7beac9d 100644
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
@@ -187,5 +192,10 @@
 			interrupt-parent = <&gic>;
 			interrupts = <0x0 0x4c 0x4>;
 		};
+
+		reboot at 17000014 {
+			compatible = "apm,xgene-reboot";
+			apm,scu = <&scu>;
+		};
 	};
 };
-- 
1.7.6.1
