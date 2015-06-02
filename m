From: ttnguyen@apm.com (Tai Nguyen)
Date: Tue,  2 Jun 2015 12:19:06 -0700
Subject: [PATCH 1/2 RESEND] power: reset: Add syscon reboot device node for
 APM X-Gene platform
In-Reply-To: <1433272747-27114-1-git-send-email-ttnguyen@apm.com>
References: <1433272747-27114-1-git-send-email-ttnguyen@apm.com>
Message-ID: <1433272747-27114-2-git-send-email-ttnguyen@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds syscon reboot device node to support reboot feature on APM X-Gene platform

Signed-off-by: Feng Kan  <fkan@apm.com>
Signed-off-by: Tai Nguyen <ttnguyen@apm.com>
---
 arch/arm64/boot/dts/apm/apm-storm.dtsi |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/apm/apm-storm.dtsi b/arch/arm64/boot/dts/apm/apm-storm.dtsi
index c8d3e0e..16efcf7 100644
--- a/arch/arm64/boot/dts/apm/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm/apm-storm.dtsi
@@ -710,5 +710,17 @@
 			dma-coherent;
 			clocks = <&dmaclk 0>;
 		};
+
+		scu: system-clk-controller at 17000000 {
+			compatible = "apm,xgene-scu","syscon";
+			reg = <0x0 0x17000000 0x0 0x400>;
+		};
+
+		reboot: reboot at 17000014 {
+			compatible = "syscon-reboot";
+			regmap = <&scu>;
+			offset = <0x14>;
+			mask = <0x1>;
+		};
 	};
 };
-- 
1.7.9.5
