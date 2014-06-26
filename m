From: fkan@apm.com (Feng Kan)
Date: Thu, 26 Jun 2014 15:59:47 -0700
Subject: [PATCH V5 3/3] arm64:dts: Add APM X-Gene SoC GPIO controller DTS
 entries
In-Reply-To: <1403823587-23404-1-git-send-email-fkan@apm.com>
References: <1403823587-23404-1-git-send-email-fkan@apm.com>
Message-ID: <1403823587-23404-4-git-send-email-fkan@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add gpio dts node for APM X-Gene SoC platform.

Signed-off-by: Feng Kan <fkan@apm.com>
---
 arch/arm64/boot/dts/apm-storm.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/apm-storm.dtsi b/arch/arm64/boot/dts/apm-storm.dtsi
index 40aa96c..a203a4e 100644
--- a/arch/arm64/boot/dts/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm-storm.dtsi
@@ -397,5 +397,12 @@
 			#clock-cells = <1>;
 			clocks = <&rtcclk 0>;
 		};
+
+		gpio: gpio0 at 1701c000 {
+			compatible = "apm,xgene-gpio";
+			reg = <0x0 0x1701c000 0x0 0x40>;
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
 	};
 };
-- 
1.9.1
