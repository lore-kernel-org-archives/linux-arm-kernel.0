From: baolin.wang@linaro.org (Baolin Wang)
Date: Tue,  6 Feb 2018 17:28:22 +0800
Subject: [PATCH 3/7] arm64: dts: Add pin controller node for Spreadtrum SC9860
In-Reply-To: <410b2f2d3f3f019c96ec31213647c41cd7f1174d.1517908478.git.baolin.wang@linaro.org>
References: <410b2f2d3f3f019c96ec31213647c41cd7f1174d.1517908478.git.baolin.wang@linaro.org>
Message-ID: <07e3668174e3000be036da54dd5435e9ed2fd91a.1517908478.git.baolin.wang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the pin controller device node for Spreadtrum
SC9860 platform.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 arch/arm64/boot/dts/sprd/whale2.dtsi |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/sprd/whale2.dtsi b/arch/arm64/boot/dts/sprd/whale2.dtsi
index 63fe89e..23cedbd 100644
--- a/arch/arm64/boot/dts/sprd/whale2.dtsi
+++ b/arch/arm64/boot/dts/sprd/whale2.dtsi
@@ -129,6 +129,11 @@
 				clock-names = "enable";
 				clocks = <&aon_gate CLK_SPLK_EB>;
 			};
+
+			pin_controller: pinctrl at 402a0000 {
+				compatible = "sprd,sc9860-pinctrl";
+				reg = <0 0x402a0000 0 0x10000>;
+			};
 		};
 	};
 
-- 
1.7.9.5
