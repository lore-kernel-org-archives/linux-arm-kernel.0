From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 12 May 2015 13:51:43 +0100
Subject: [PATCH 06/13] ARM: STi: STiH407: Add Restart support for Cannes
In-Reply-To: <1431435110-22595-1-git-send-email-lee.jones@linaro.org>
References: <1431435110-22595-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1431435110-22595-7-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih407-family.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index 85159b8..46e6a38 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -65,6 +65,12 @@
 		ranges;
 		compatible = "simple-bus";
 
+		restart {
+			compatible = "st,stih407-restart";
+			st,syscfg = <&syscfg_sbc_reg>;
+			status = "okay";
+		};
+
 		powerdown: powerdown-controller {
 			compatible = "st,stih407-powerdown";
 			#reset-cells = <1>;
-- 
1.9.1
