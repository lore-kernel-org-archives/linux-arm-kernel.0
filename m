From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Wed, 14 Feb 2018 11:04:39 +0100
Subject: [RESEND PATCH v2 8/8] ARM: dts: stm32: Enable pwm3 input capture on
 stm32f429i-eval
In-Reply-To: <1518602679-3064-1-git-send-email-fabrice.gasnier@st.com>
References: <1518602679-3064-1-git-send-email-fabrice.gasnier@st.com>
Message-ID: <1518602679-3064-9-git-send-email-fabrice.gasnier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable pwm3 input capture on stm32f429i-eval, by using DMA.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Reviewed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
---
 arch/arm/boot/dts/stm32429i-eval.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/stm32429i-eval.dts b/arch/arm/boot/dts/stm32429i-eval.dts
index 293ecb9..d5498dd 100644
--- a/arch/arm/boot/dts/stm32429i-eval.dts
+++ b/arch/arm/boot/dts/stm32429i-eval.dts
@@ -271,6 +271,9 @@
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
