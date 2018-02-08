From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Thu, 8 Feb 2018 15:27:35 +0100
Subject: [PATCH 4/6] ARM: dts: stm32: add MFX support on I2C1 on stm32746g-eval
In-Reply-To: <1518100057-23234-1-git-send-email-amelie.delaunay@st.com>
References: <1518100057-23234-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <1518100057-23234-5-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MFX is used as gpio expander on stm32746g-eval.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 arch/arm/boot/dts/stm32746g-eval.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/stm32746g-eval.dts b/arch/arm/boot/dts/stm32746g-eval.dts
index e74ae59..99739f7 100644
--- a/arch/arm/boot/dts/stm32746g-eval.dts
+++ b/arch/arm/boot/dts/stm32746g-eval.dts
@@ -128,6 +128,23 @@
 	i2c-scl-rising-time-ns = <185>;
 	i2c-scl-falling-time-ns = <20>;
 	status = "okay";
+
+	mfx: mfx at 42 {
+		compatible = "st,mfx";
+		reg = <0x42>;
+		interrupts = <8 1>;
+		interrupt-parent = <&gpioi>;
+		interrupt-controller;
+		#interrupt-cells = <1>;
+
+		mfxgpio: mfx_gpio {
+			compatible = "st,mfx-gpio";
+			interrupts = <0>;
+			interrupt-parent = <&mfx>;
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+	};
 };
 
 &mac {
-- 
2.7.4
