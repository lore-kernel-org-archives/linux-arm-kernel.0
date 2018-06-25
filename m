From: ludovic.Barre@st.com (Ludovic Barre)
Date: Mon, 25 Jun 2018 17:43:01 +0200
Subject: [PATCH V5 3/5] ARM: dts: stm32: add iwdg2 support for stm32mp157c
In-Reply-To: <1529941383-8653-1-git-send-email-ludovic.Barre@st.com>
References: <1529941383-8653-1-git-send-email-ludovic.Barre@st.com>
Message-ID: <1529941383-8653-4-git-send-email-ludovic.Barre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch adds independent watchdog support for stm32mp157c.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 arch/arm/boot/dts/stm32mp157c.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
index 7d17538..95cc166 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -784,6 +784,14 @@
 			status = "disabled";
 		};
 
+		iwdg2: watchdog at 5a002000 {
+			compatible = "st,stm32mp1-iwdg";
+			reg = <0x5a002000 0x400>;
+			clocks = <&rcc IWDG2>, <&rcc CK_LSI>;
+			clock-names = "pclk", "lsi";
+			status = "disabled";
+		};
+
 		usbphyc: usbphyc at 5a006000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.7.4
