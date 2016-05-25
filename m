From: peter.griffin@linaro.org (Peter Griffin)
Date: Wed, 25 May 2016 17:06:49 +0100
Subject: [PATCH v4 15/18] ARM: STi: DT: STiH407: Add sti-sasg-codec dt node
In-Reply-To: <1464192412-16386-1-git-send-email-peter.griffin@linaro.org>
References: <1464192412-16386-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1464192412-16386-17-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the dt node for the internal audio
codec IP.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 arch/arm/boot/dts/stih407-family.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index b423836..60f95b6 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -746,5 +746,14 @@
 				<&clk_s_c0_flexgen CLK_TX_ICN_DISP_0>,
 				<&clk_s_c0_flexgen CLK_EXT2F_A9>;
 		};
+
+		sti_sasg_codec: sti-sasg-codec {
+			compatible = "st,stih407-sas-codec";
+			#sound-dai-cells = <1>;
+			status = "okay";
+			st,syscfg = <&syscfg_core>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_spdif_out >;
+		};
 	};
 };
-- 
1.9.1
