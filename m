From: lee.jones@linaro.org (Lee Jones)
Date: Wed,  8 Oct 2014 10:33:27 +0100
Subject: [PATCH 1/4] ARM: STi: DT: STiH407: Add Device Tree node for LPC
 Watchdog
In-Reply-To: <1412760810-23199-1-git-send-email-lee.jones@linaro.org>
References: <1412760810-23199-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1412760810-23199-2-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: David Paris <david.paris@st.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih407.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/stih407.dtsi b/arch/arm/boot/dts/stih407.dtsi
index f539627a..303df6c 100644
--- a/arch/arm/boot/dts/stih407.dtsi
+++ b/arch/arm/boot/dts/stih407.dtsi
@@ -259,5 +259,15 @@
 
 			status = "disabled";
 		};
+
+		watchdog at 0x8787000 {
+			compatible = "st,stih407-watchdog";
+			reg = <0x8787000 0x1000>, <0x204 0x4>;
+			reg-names = "base", "syscfg-en";
+			clock-names = "st_wdog";
+			clocks = <&clk_s_d3_flexgen CLK_LPC_0>;
+			timeout-sec = <600>;
+			st,syscfg = <&syscfg_core>;
+		};
 	};
 };
-- 
1.9.1
