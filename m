From: pierre-yves.mordret@st.com (Pierre-Yves MORDRET)
Date: Mon, 23 Apr 2018 11:48:30 +0200
Subject: [PATCH v2 4/5] ARM: dts: stm32: Add I2C4 support for STM32MP157C-ED1
In-Reply-To: <1524476911-19056-1-git-send-email-pierre-yves.mordret@st.com>
References: <1524476911-19056-1-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <1524476911-19056-5-git-send-email-pierre-yves.mordret@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add I2C4 support for STM32MP157C evaluation daughter.
Required for PMIC.

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
  Version history:
     v1:
        * Initial
---
---
 arch/arm/boot/dts/stm32mp157c-ed1.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c-ed1.dts b/arch/arm/boot/dts/stm32mp157c-ed1.dts
index 9f90337a..490b712 100644
--- a/arch/arm/boot/dts/stm32mp157c-ed1.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ed1.dts
@@ -25,6 +25,14 @@
 	};
 };
 
+&i2c4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c4_pins_a>;
+	i2c-scl-rising-time-ns = <185>;
+	i2c-scl-falling-time-ns = <20>;
+	status = "okay";
+};
+
 &uart4 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart4_pins_a>;
-- 
2.7.4
