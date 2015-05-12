From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 12 May 2015 13:51:44 +0100
Subject: [PATCH 07/13] ARM: STi: STiH416: Add Restart support for Orly2
In-Reply-To: <1431435110-22595-1-git-send-email-lee.jones@linaro.org>
References: <1431435110-22595-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1431435110-22595-8-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih416.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/stih416.dtsi b/arch/arm/boot/dts/stih416.dtsi
index 9ead8bb..6452d33 100644
--- a/arch/arm/boot/dts/stih416.dtsi
+++ b/arch/arm/boot/dts/stih416.dtsi
@@ -30,6 +30,12 @@
 		ranges;
 		compatible	= "simple-bus";
 
+		restart {
+			compatible = "st,stih416-restart";
+			st,syscfg = <&syscfg_sbc>;
+			status = "okay";
+		};
+
 		powerdown: powerdown-controller {
 			#reset-cells = <1>;
 			compatible = "st,stih416-powerdown";
-- 
1.9.1
