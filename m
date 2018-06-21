From: ludovic.Barre@st.com (Ludovic Barre)
Date: Thu, 21 Jun 2018 11:02:17 +0200
Subject: [PATCH V4 4/4] ARM: dts: stm32: add iwdg2 support for stm32mp157c-ed1
In-Reply-To: <1529571737-3552-1-git-send-email-ludovic.Barre@st.com>
References: <1529571737-3552-1-git-send-email-ludovic.Barre@st.com>
Message-ID: <1529571737-3552-5-git-send-email-ludovic.Barre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch activates independent watchdog support for
stm32mp157c board.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 arch/arm/boot/dts/stm32mp157c-ed1.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c-ed1.dts b/arch/arm/boot/dts/stm32mp157c-ed1.dts
index ae33653..8af263a 100644
--- a/arch/arm/boot/dts/stm32mp157c-ed1.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ed1.dts
@@ -68,6 +68,11 @@
 	status = "okay";
 };
 
+&iwdg2 {
+	timeout-sec = <32>;
+	status = "okay";
+};
+
 &uart4 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart4_pins_a>;
-- 
2.7.4
