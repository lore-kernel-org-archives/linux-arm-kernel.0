From: pierre-yves.mordret@st.com (Pierre-Yves MORDRET)
Date: Thu, 6 Jul 2017 17:53:06 +0200
Subject: [PATCH v3 5/5] ARM: dts: stm32: Add I2C1 support for STM32F746 eval
 board
In-Reply-To: <1499356386-28779-1-git-send-email-pierre-yves.mordret@st.com>
References: <1499356386-28779-1-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <1499356386-28779-6-git-send-email-pierre-yves.mordret@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds I2C1 support for STM32F746 eval board

Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
 Version history:
    v3:
        * None

    v2:
        * Add SCL Rising/Falling time for eval board
---
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
2.7.4
