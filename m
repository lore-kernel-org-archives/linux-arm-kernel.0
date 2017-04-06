From: yannick.fertre@st.com (Yannick Fertre)
Date: Thu, 6 Apr 2017 14:19:27 +0200
Subject: [PATCH v5 4/5] ARM: dts: stm32: Add watchdog support for STM32F429
 eval board
In-Reply-To: <1491481168-22213-1-git-send-email-yannick.fertre@st.com>
References: <1491481168-22213-1-git-send-email-yannick.fertre@st.com>
Message-ID: <1491481168-22213-5-git-send-email-yannick.fertre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds watchdog support for STM32x9I-Eval board.

Signed-off-by: Yannick Fertre <yannick.fertre@st.com>
---
 arch/arm/boot/dts/stm32429i-eval.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/stm32429i-eval.dts b/arch/arm/boot/dts/stm32429i-eval.dts
index 6e4b42a..ff29980 100644
--- a/arch/arm/boot/dts/stm32429i-eval.dts
+++ b/arch/arm/boot/dts/stm32429i-eval.dts
@@ -144,6 +144,11 @@
 	};
 };
 
+&iwdg {
+	status = "okay";
+	timeout-sec = <32>;
+};
+
 &adc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&adc3_in8_pin>;
-- 
1.9.1
