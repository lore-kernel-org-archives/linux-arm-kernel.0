From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 26 Aug 2015 14:08:02 +0100
Subject: [PATCH 3/4] ARM: STiH407: Add nodes for RemoteProc
In-Reply-To: <1440594483-29601-1-git-send-email-lee.jones@linaro.org>
References: <1440594483-29601-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1440594483-29601-4-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih407-family.dtsi | 48 +++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index 33daa49..89a363c 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -608,5 +608,53 @@
 			status		= "okay";
 			tx-only;
 		};
+
+		st231_gp0: st231-gp0 at 0 {
+			compatible = "st,st231-rproc";
+			reg = <0x40000000 0x01000000>;
+			reg-names = "carveout";
+			resets = <&softreset STIH407_ST231_GP0_SOFTRESET>;
+			reset-names = "sw_reset";
+			clocks = <&clk_s_c0_flexgen CLK_ST231_GP_0>;
+			clock-names = "rproc_clk";
+			clock-frequency = <600000000>;
+			st,syscfg-boot = <&syscfg_core 0x22C>;
+		};
+
+		st231_gp1: st231-gp1 at 0 {
+			compatible = "st,st231-rproc";
+			reg = <0x41000000 0x01000000>;
+			reg-names = "carveout";
+			resets = <&softreset STIH407_ST231_GP1_SOFTRESET>;
+			reset-names = "sw_reset";
+			clocks = <&clk_s_c0_flexgen CLK_ST231_GP_1>;
+			clock-names = "rproc_clk";
+			clock-frequency = <600000000>;
+			st,syscfg-boot = <&syscfg_core 0x220>;
+		};
+
+		st231_audio: st231-audio at 0 {
+			compatible = "st,st231-rproc";
+			reg = <0x42000000 0x01000000>;
+			reg-names = "carveout";
+			resets = <&softreset STIH407_ST231_AUD_SOFTRESET>;
+			reset-names = "sw_reset";
+			clocks = <&clk_s_c0_flexgen CLK_ST231_AUD_0>;
+			clock-names = "rproc_clk";
+			clock-frequency = <600000000>;
+			st,syscfg-boot = <&syscfg_core 0x228>;
+		};
+
+		st231_dmu: st231-dmu at 0 {
+			compatible = "st,st231-rproc";
+			reg = <0x43000000 0x01000000>;
+			reg-names = "carveout";
+			resets = <&softreset STIH407_ST231_DMU_SOFTRESET>;
+			reset-names = "sw_reset";
+			clocks = <&clk_s_c0_flexgen CLK_ST231_DMU>;
+			clock-names = "rproc_clk";
+			clock-frequency = <600000000>;
+			st,syscfg-boot = <&syscfg_core 0x224>;
+		};
 	};
 };
-- 
1.9.1
