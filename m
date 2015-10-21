From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 21 Oct 2015 12:47:06 +0100
Subject: [PATCH v4 5/6] ARM: STiH407: Add nodes for RemoteProc
In-Reply-To: <1445428027-26174-1-git-send-email-lee.jones@linaro.org>
References: <1445428027-26174-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1445428027-26174-6-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih407-family.dtsi | 40 +++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index 1e4e01925..15c20b6 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -650,5 +650,45 @@
 			mbox-name	= "st231_audio_video";
 			status		= "okay";
 		};
+
+		st231_gp0: st231-gp0 at 40000000 {
+			compatible	= "st,st231-rproc";
+			reg		= <0x40000000 0x01000000>;
+			resets		= <&softreset STIH407_ST231_GP0_SOFTRESET>;
+			reset-names	= "sw_reset";
+			clocks		= <&clk_s_c0_flexgen CLK_ST231_GP_0>;
+			clock-frequency	= <600000000>;
+			st,syscfg	= <&syscfg_core 0x22c>;
+		};
+
+		st231_gp1: st231-gp1 at 41000000 {
+			compatible	= "st,st231-rproc";
+			reg		= <0x41000000 0x01000000>;
+			resets		= <&softreset STIH407_ST231_GP1_SOFTRESET>;
+			reset-names	= "sw_reset";
+			clocks		= <&clk_s_c0_flexgen CLK_ST231_GP_1>;
+			clock-frequency = <600000000>;
+			st,syscfg	= <&syscfg_core 0x220>;
+		};
+
+		st231_audio: st231-audio at 42000000 {
+			compatible	= "st,st231-rproc";
+			reg		= <0x42000000 0x01000000>;
+			resets		= <&softreset STIH407_ST231_AUD_SOFTRESET>;
+			reset-names	= "sw_reset";
+			clocks		= <&clk_s_c0_flexgen CLK_ST231_AUD_0>;
+			clock-frequency	= <600000000>;
+			st,syscfg	= <&syscfg_core 0x228>;
+		};
+
+		st231_dmu: st231-dmu at 43000000 {
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
1.9.1
