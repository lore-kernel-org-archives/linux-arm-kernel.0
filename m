From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 22 Jul 2014 15:52:31 +0100
Subject: [PATCH 4/5] ARM: sti: Add Restart support for the STiH416 (Orly2)
 board
In-Reply-To: <1406040752-25229-1-git-send-email-lee.jones@linaro.org>
References: <1406040752-25229-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1406040752-25229-5-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih416.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/stih416.dtsi b/arch/arm/boot/dts/stih416.dtsi
index 84758d7..95b15b0 100644
--- a/arch/arm/boot/dts/stih416.dtsi
+++ b/arch/arm/boot/dts/stih416.dtsi
@@ -28,6 +28,12 @@
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
1.8.3.2
