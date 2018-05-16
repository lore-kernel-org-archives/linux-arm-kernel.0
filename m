From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Wed, 16 May 2018 09:36:01 +0200
Subject: [RESEND PATCH v5 6/6] ARM: dts: stm32: Enable pwm3 input capture on
 stm32f429i-eval
In-Reply-To: <1526456161-27865-1-git-send-email-fabrice.gasnier@st.com>
References: <1526456161-27865-1-git-send-email-fabrice.gasnier@st.com>
Message-ID: <1526456161-27865-7-git-send-email-fabrice.gasnier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable pwm3 input capture on stm32f429i-eval, by using DMA.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Reviewed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
---
 arch/arm/boot/dts/stm32429i-eval.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/stm32429i-eval.dts b/arch/arm/boot/dts/stm32429i-eval.dts
index 7eb786a..88d878a 100644
--- a/arch/arm/boot/dts/stm32429i-eval.dts
+++ b/arch/arm/boot/dts/stm32429i-eval.dts
@@ -290,6 +290,9 @@
 &timers3 {
 	status = "okay";
 
+	/* Enable PWM input capture by using dma */
+	dmas = <&dma1 4 5 0x400 0x0>;
+	dma-names = "ch1";
 	pwm {
 		pinctrl-0 = <&pwm3_pins>;
 		pinctrl-names = "default";
-- 
1.9.1
