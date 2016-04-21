From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 21 Apr 2016 16:07:45 +0100
Subject: [[PATCH v2] 6/8] ARM: dts: STiH407: Add nodes for RemoteProc
In-Reply-To: <1461251267-14897-1-git-send-email-lee.jones@linaro.org>
References: <1461251267-14897-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1461251267-14897-6-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Maxime Coquelin <maxime.coquelin@st.com>
---
 arch/arm/boot/dts/stih407-family.dtsi | 40 +++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index 680b7c1..7cd358b 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -747,5 +747,45 @@
 			mbox-name	= "st231_audio_video";
 			status		= "okay";
 		};
+
+		st231_gp0: remote-processor at 40000000 {
+			compatible	= "st,st231-rproc";
+			reg		= <0x40000000 0x01000000>;
+			resets		= <&softreset STIH407_ST231_GP0_SOFTRESET>;
+			reset-names	= "sw_reset";
+			clocks		= <&clk_s_c0_flexgen CLK_ST231_GP_0>;
+			clock-frequency	= <600000000>;
+			st,syscfg	= <&syscfg_core 0x22c>;
+		};
+
+		st231_gp1: remote-processor at 41000000 {
+			compatible	= "st,st231-rproc";
+			reg		= <0x41000000 0x01000000>;
+			resets		= <&softreset STIH407_ST231_GP1_SOFTRESET>;
+			reset-names	= "sw_reset";
+			clocks		= <&clk_s_c0_flexgen CLK_ST231_GP_1>;
+			clock-frequency = <600000000>;
+			st,syscfg	= <&syscfg_core 0x220>;
+		};
+
+		st231_audio: remote-processor at 42000000 {
+			compatible	= "st,st231-rproc";
+			reg		= <0x42000000 0x01000000>;
+			resets		= <&softreset STIH407_ST231_AUD_SOFTRESET>;
+			reset-names	= "sw_reset";
+			clocks		= <&clk_s_c0_flexgen CLK_ST231_AUD_0>;
+			clock-frequency	= <600000000>;
+			st,syscfg	= <&syscfg_core 0x228>;
+		};
+
+		st231_dmu: remote-processor at 43000000 {
+			compatible	= "st,st231-rproc";
+			reg		= <0x43000000 0x01000000>;
+			resets		= <&softreset STIH407_ST231_DMU_SOFTRESET>;
+			reset-names	= "sw_reset";
+			clocks		= <&clk_s_c0_flexgen CLK_ST231_DMU>;
+			clock-frequency	= <600000000>;
+			st,syscfg	= <&syscfg_core 0x224>;
+		};
 	};
 };
-- 
2.8.0
