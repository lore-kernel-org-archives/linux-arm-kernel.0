From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 16 Aug 2016 10:34:56 +0100
Subject: [PATCH v4 05/17] ARM: dts: STiH416: Define PWM Capture clock
In-Reply-To: <20160816093508.28307-1-lee.jones@linaro.org>
References: <20160816093508.28307-1-lee.jones@linaro.org>
Message-ID: <20160816093508.28307-6-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih416.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/stih416.dtsi b/arch/arm/boot/dts/stih416.dtsi
index 2001d48..bf15a32 100644
--- a/arch/arm/boot/dts/stih416.dtsi
+++ b/arch/arm/boot/dts/stih416.dtsi
@@ -483,8 +483,9 @@
 					&pinctrl_pwm0_chan2_default
 					&pinctrl_pwm0_chan3_default>;
 
-			clock-names	= "pwm";
-			clocks		= <&clk_sysin>;
+			clock-names	= "pwm", "capture";
+			clocks		= <&clk_sysin>, <&clk_s_a0_ls CLK_ICN_REG>;
+
 			st,pwm-num-chan = <4>;
 		};
 
-- 
2.9.0
