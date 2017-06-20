From: pierre-yves.mordret@st.com (Pierre-Yves MORDRET)
Date: Tue, 20 Jun 2017 13:41:30 +0200
Subject: [PATCH v2 5/5] ARM: dts: stm32: Add I2C1 support for STM32F746 eval
 board
In-Reply-To: <1497958890-5530-1-git-send-email-pierre-yves.mordret@st.com>
References: <1497958890-5530-1-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <1497958890-5530-6-git-send-email-pierre-yves.mordret@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds I2C1 support for STM32F746 eval board

Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
Changes in V2
  * Add SCL Rising/Falling time for eval board
---
 arch/arm/boot/dts/stm32746g-eval.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/stm32746g-eval.dts b/arch/arm/boot/dts/stm32746g-eval.dts
index 69a9579..9288c7a 100644
--- a/arch/arm/boot/dts/stm32746g-eval.dts
+++ b/arch/arm/boot/dts/stm32746g-eval.dts
@@ -102,3 +102,11 @@
 	pinctrl-names = "default";
 	status = "okay";
 };
+
+&i2c1 {
+	pinctrl-0 = <&i2c1_pins_b>;
+	pinctrl-names = "default";
+	i2c-scl-rising-time-ns = <185>;
+	i2c-scl-falling-time-ns = <20>;
+	status = "okay";
+};
-- 
1.9.1
