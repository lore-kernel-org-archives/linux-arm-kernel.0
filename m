From: guodong.xu@linaro.org (Guodong Xu)
Date: Fri, 19 Feb 2016 13:19:07 +0800
Subject: [PATCH 4/5] arm64: dts: hi6220: add resets property into dwmmc nodes
In-Reply-To: <1455859148-29098-1-git-send-email-guodong.xu@linaro.org>
References: <1455859148-29098-1-git-send-email-guodong.xu@linaro.org>
Message-ID: <1455859148-29098-5-git-send-email-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add resets property into dwmmc_0, dwmmc_1 and dwmmc_2 for hi6220

Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index 28bd441..7452359 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -7,6 +7,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/hi6220-clock.h>
 #include <dt-bindings/pinctrl/hisi.h>
+#include <dt-bindings/reset/hisi,hi6220-resets.h>
 
 / {
 	compatible = "hisilicon,hi6220";
@@ -748,6 +749,7 @@
 			interrupts = <0x0 0x48 0x4>;
 			clocks = <&sys_ctrl 2>, <&sys_ctrl 1>;
 			clock-names = "ciu", "biu";
+			resets = <&sys_ctrl PERIPH_RSTDIS0_MMC0>;
 			bus-width = <0x8>;
 			vmmc-supply = <&ldo19>;
 			pinctrl-names = "default";
@@ -767,6 +769,7 @@
 			#size-cells = <0x0>;
 			clocks = <&sys_ctrl 4>, <&sys_ctrl 3>;
 			clock-names = "ciu", "biu";
+			resets = <&sys_ctrl PERIPH_RSTDIS0_MMC1>;
 			vqmmc-supply = <&ldo7>;
 			vmmc-supply = <&ldo10>;
 			bus-width = <0x4>;
@@ -785,6 +788,7 @@
 			interrupts = <0x0 0x4a 0x4>;
 			clocks = <&sys_ctrl HI6220_MMC2_CIUCLK>, <&sys_ctrl HI6220_MMC2_CLK>;
 			clock-names = "ciu", "biu";
+			resets = <&sys_ctrl PERIPH_RSTDIS0_MMC2>;
 			bus-width = <0x4>;
 			broken-cd;
 			pinctrl-names = "default", "idle";
-- 
1.9.1
