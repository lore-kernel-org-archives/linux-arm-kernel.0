From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Fri, 2 Dec 2016 15:09:58 +0100
Subject: [PATCH 5/8] ARM: dts: stm32: enable RTC on stm32f429-disco
In-Reply-To: <1480687801-19525-2-git-send-email-amelie.delaunay@st.com>
References: <1480687801-19525-2-git-send-email-amelie.delaunay@st.com>
Message-ID: <1480687801-19525-7-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables RTC on stm32f429-disco with LSI as clock source because
X2 crystal for LSE is not fitted by default.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 arch/arm/boot/dts/stm32f429-disco.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f429-disco.dts b/arch/arm/boot/dts/stm32f429-disco.dts
index b6e63d8..49eddf6 100644
--- a/arch/arm/boot/dts/stm32f429-disco.dts
+++ b/arch/arm/boot/dts/stm32f429-disco.dts
@@ -94,6 +94,12 @@
 	clock-frequency = <8000000>;
 };
 
+&rtc {
+	assigned-clocks = <&rcc 1 CLK_RTC>;
+	assigned-clock-parents = <&rcc 1 CLK_LSI>;
+	status = "okay";
+};
+
 &usart1 {
 	pinctrl-0 = <&usart1_pins_a>;
 	pinctrl-names = "default";
-- 
1.9.1
