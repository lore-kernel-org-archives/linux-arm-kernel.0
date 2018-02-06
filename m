From: baolin.wang@linaro.org (Baolin Wang)
Date: Tue,  6 Feb 2018 17:28:24 +0800
Subject: [PATCH 5/7] arm64: dts: Add watchdog device node for Spreadtrum SC9860
In-Reply-To: <410b2f2d3f3f019c96ec31213647c41cd7f1174d.1517908478.git.baolin.wang@linaro.org>
References: <410b2f2d3f3f019c96ec31213647c41cd7f1174d.1517908478.git.baolin.wang@linaro.org>
Message-ID: <9b1a2b944df46b7127dce3baa237e1bfbc5ed2b6.1517908478.git.baolin.wang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the watchdog device node for Spreadtrum SC9860 platform to
watch the system's stability.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 arch/arm64/boot/dts/sprd/whale2.dtsi |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/sprd/whale2.dtsi b/arch/arm64/boot/dts/sprd/whale2.dtsi
index 3dc6389..f2cdf4d 100644
--- a/arch/arm64/boot/dts/sprd/whale2.dtsi
+++ b/arch/arm64/boot/dts/sprd/whale2.dtsi
@@ -141,6 +141,15 @@
 				compatible = "sprd,sc9860-pinctrl";
 				reg = <0 0x402a0000 0 0x10000>;
 			};
+
+			watchdog at 40310000 {
+				compatible = "sprd,sp9860-wdt";
+				reg = <0 0x40310000 0 0x1000>;
+				interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
+				timeout-sec = <12>;
+				clock-names = "enable";
+				clocks = <&aon_gate CLK_APCPU_WDG_EB>;
+			};
 		};
 	};
 
-- 
1.7.9.5
