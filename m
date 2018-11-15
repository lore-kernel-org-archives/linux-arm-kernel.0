From: bich.hemon@st.com (Bich HEMON)
Date: Thu, 15 Nov 2018 08:52:29 +0000
Subject: [PATCH 3/3] ARM: dts: stm32: add can1 sleep pins muxing on
 stm32mp157c-ev1 board
In-Reply-To: <1542271942-28130-1-git-send-email-bich.hemon@st.com>
References: <1542271942-28130-1-git-send-email-bich.hemon@st.com>
Message-ID: <1542271942-28130-4-git-send-email-bich.hemon@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pinctrl sleep state for can1 on stm32mp157c-ev1.

Signed-off-by: Bich Hemon <bich.hemon@st.com>
---
 arch/arm/boot/dts/stm32mp157c-ev1.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stm32mp157c-ev1.dts b/arch/arm/boot/dts/stm32mp157c-ev1.dts
index 063ee8a..fdc4c92 100644
--- a/arch/arm/boot/dts/stm32mp157c-ev1.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ev1.dts
@@ -124,8 +124,9 @@
 };
 
 &m_can1 {
-	pinctrl-names = "default";
+	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&m_can1_pins_a>;
+	pinctrl-1 = <&m_can1_sleep_pins_a>;
 	status = "okay";
 };
 
-- 
1.9.1
