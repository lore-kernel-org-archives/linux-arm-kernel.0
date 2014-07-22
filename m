From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 22 Jul 2014 15:52:30 +0100
Subject: [PATCH 3/5] ARM: sti: Add Restart support for the STiH417 (Cannes)
 board
In-Reply-To: <1406040752-25229-1-git-send-email-lee.jones@linaro.org>
References: <1406040752-25229-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1406040752-25229-4-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih407.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/stih407.dtsi b/arch/arm/boot/dts/stih407.dtsi
index 4f9024f..a370e73 100644
--- a/arch/arm/boot/dts/stih407.dtsi
+++ b/arch/arm/boot/dts/stih407.dtsi
@@ -63,6 +63,12 @@
 		ranges;
 		compatible = "simple-bus";
 
+		restart {
+			compatible = "st,stih407-restart";
+			st,syscfg = <&syscfg_sbc_reg>;
+			status = "okay";
+		};
+
 		syscfg_sbc: sbc-syscfg at 9620000 {
 			compatible = "st,stih407-sbc-syscfg", "syscon";
 			reg = <0x9620000 0x1000>;
-- 
1.8.3.2
