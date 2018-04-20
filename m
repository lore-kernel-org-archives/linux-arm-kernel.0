From: pierre-yves.mordret@st.com (Pierre-Yves MORDRET)
Date: Fri, 20 Apr 2018 11:05:22 +0200
Subject: [PATCH v1 2/2] ARM: dts: stm32: Add I2C1 support for STM32H743I-EVAL
 Board
In-Reply-To: <1524215122-14046-1-git-send-email-pierre-yves.mordret@st.com>
References: <1524215122-14046-1-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <1524215122-14046-3-git-send-email-pierre-yves.mordret@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add I2C1 support for STM32H743I-EVAL Board

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
  Version history:
     v1:
        * Initial
---
---
 arch/arm/boot/dts/stm32h743i-eval.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/stm32h743i-eval.dts b/arch/arm/boot/dts/stm32h743i-eval.dts
index c7187e1..3f8e0c4 100644
--- a/arch/arm/boot/dts/stm32h743i-eval.dts
+++ b/arch/arm/boot/dts/stm32h743i-eval.dts
@@ -92,6 +92,14 @@
 	clock-frequency = <25000000>;
 };
 
+&i2c1 {
+	pinctrl-0 = <&i2c1_pins_a>;
+	pinctrl-names = "default";
+	i2c-scl-rising-time-ns = <185>;
+	i2c-scl-falling-time-ns = <20>;
+	status = "okay";
+};
+
 &rtc {
 	status = "okay";
 };
-- 
2.7.4
