From: fkan@apm.com (Feng Kan)
Date: Thu, 31 Jul 2014 12:03:27 -0700
Subject: [PATCH V6 3/3] arm64:dts: Add APM X-Gene SoC GPIO controller DTS
 entries
In-Reply-To: <1406833407-28316-1-git-send-email-fkan@apm.com>
References: <1406833407-28316-1-git-send-email-fkan@apm.com>
Message-ID: <1406833407-28316-4-git-send-email-fkan@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add gpio dts node for APM X-Gene SoC platform.

Signed-off-by: Feng Kan <fkan@apm.com>
---
 arch/arm64/boot/dts/apm-storm.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/apm-storm.dtsi b/arch/arm64/boot/dts/apm-storm.dtsi
index 40aa96c..cf38b6f 100644
--- a/arch/arm64/boot/dts/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm-storm.dtsi
@@ -397,5 +397,12 @@
 			#clock-cells = <1>;
 			clocks = <&rtcclk 0>;
 		};
+
+		gfcgpio: gpio0 at 1701c000 {
+			compatible = "apm,xgene-gpio";
+			reg = <0x0 0x1701c000 0x0 0x40>;
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
 	};
 };
-- 
1.9.1
