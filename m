From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Wed, 11 Apr 2018 11:47:03 +0200
Subject: [PATCH 3/5] ARM: dts: stm32: add STMFX pinctrl/gpio expander support
 on stm32746g-eval
In-Reply-To: <1523440025-18077-1-git-send-email-amelie.delaunay@st.com>
References: <1523440025-18077-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <1523440025-18077-4-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for STMicroelectronics Multi-Function eXpander
pinctrl/gpio expander on stm32746g-eval. It is connected on I2C1.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 arch/arm/boot/dts/stm32746g-eval.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/stm32746g-eval.dts b/arch/arm/boot/dts/stm32746g-eval.dts
index 2d4e717..bd9a33d 100644
--- a/arch/arm/boot/dts/stm32746g-eval.dts
+++ b/arch/arm/boot/dts/stm32746g-eval.dts
@@ -106,6 +106,22 @@
 	i2c-scl-rising-time-ns = <185>;
 	i2c-scl-falling-time-ns = <20>;
 	status = "okay";
+
+	stmfxpinctrl: stmfx at 42 {
+		compatible = "st,stmfx-0300";
+		reg = <0x42>;
+		interrupt-parent = <&gpioi>;
+		interrupts = <8 1>;
+		status = "okay";
+
+		stmfxgpio: gpio-expander {
+			#gpio-cells = <2>;
+			#interrupt-cells = <2>;
+			gpio-controller;
+			interrupt-controller;
+			status = "okay";
+		};
+	};
 };
 
 &rtc {
-- 
2.7.4
