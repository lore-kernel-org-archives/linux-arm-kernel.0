From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 22 Jun 2015 16:43:53 +0100
Subject: [PATCH 4/8] ARM: STi: STiH407: Provide a node for CPUFreq
In-Reply-To: <1434987837-24212-1-git-send-email-lee.jones@linaro.org>
References: <1434987837-24212-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1434987837-24212-5-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih407-family.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index f48767e..f57fd83 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -98,6 +98,11 @@
 		ranges;
 		compatible = "simple-bus";
 
+		cpufreq {
+			compatible = "st,stih407-cpufreq";
+			st,syscfg = <&syscfg_core 0x8e0>;
+		};
+
 		restart {
 			compatible = "st,stih407-restart";
 			st,syscfg = <&syscfg_sbc_reg>;
-- 
1.9.1
