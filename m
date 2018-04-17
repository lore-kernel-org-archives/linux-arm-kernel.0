From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Tue, 17 Apr 2018 15:45:30 +0200
Subject: [PATCH 4/4] ARM: dts: stm32: enable timer trigger 6 on stm32mp157c-ed1
In-Reply-To: <1523972730-29240-1-git-send-email-fabrice.gasnier@st.com>
References: <1523972730-29240-1-git-send-email-fabrice.gasnier@st.com>
Message-ID: <1523972730-29240-5-git-send-email-fabrice.gasnier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable timer 6 on stm32mp157c-ed1 that can serve as trigger for
ADC for instance.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 arch/arm/boot/dts/stm32mp157c-ed1.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c-ed1.dts b/arch/arm/boot/dts/stm32mp157c-ed1.dts
index 9f90337a..4f12225 100644
--- a/arch/arm/boot/dts/stm32mp157c-ed1.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ed1.dts
@@ -25,6 +25,13 @@
 	};
 };
 
+&timers6 {
+	status = "okay";
+	timer at 5 {
+		status = "okay";
+	};
+};
+
 &uart4 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart4_pins_a>;
-- 
1.9.1
